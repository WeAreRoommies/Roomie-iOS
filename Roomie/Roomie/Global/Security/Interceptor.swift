//
//  Interceptor.swift
//  Roomie
//
//  Created by 김승원 on 5/29/25.
//

import Foundation

import Alamofire

final class Interceptor: RequestInterceptor {
    
    static let shared = Interceptor()
    let retryLimit = 3
    
    private init() {}
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        print("➡️[Interceptor] - adapt")
        var urlRequest = urlRequest
        
        if let accessToken = TokenManager.shared.fetchAccessToken() {
            if urlRequest.headers.dictionary["Authorization"] == nil {
                urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        }
        
        completion(.success(urlRequest))
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        print("🔄[Interceptor] - retry start")
        guard let response = request.task?.response as? HTTPURLResponse,response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        
        guard request.retryCount < retryLimit else {
            return completion(.doNotRetryWithError(error))
        }

        Task {
            do {
                let accessToken = try await authReissue()
                print("▶️[Interceptor] - retry success, token reissued")
                TokenManager.shared.saveTokens(accessToken: accessToken)
                completion(.retry)
                
            } catch let error as TokenError {
                print("⏸️[Interceptor] - retry failed: \(error.description)")
                switch error {
                case .noRefreshToken, .refreshTokenExpired, .userNotFound:
                    NotificationCenter.default.post(name: Notification.shouldLogout, object: nil)
                    await Toast.show(.sessionExpired)
                    break
                case .reissueFailed:
                    await Toast.show(.serverError)
                    break
                case .unknownError:
                    await Toast.show(.requestFailed)
                    break
                }
                
                completion(.doNotRetryWithError(error))
            } catch {
                await Toast.show(.unexpectedError)
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

private extension Interceptor {
    func authReissue() async throws -> String {
        do {
            guard let refreshToken = TokenManager.shared.fetchRefreshToken() else {
                throw TokenError.noRefreshToken
            }
            
            guard let response = try await AuthService().authReissue(refreshToken: refreshToken) else {
                throw TokenError.reissueFailed
            }
            
            guard let data = response.data else {
                switch response.code {
                case 40102:
                    throw TokenError.refreshTokenExpired
                case 40403:
                    throw TokenError.userNotFound
                default:
                    throw TokenError.reissueFailed
                }
            }
            
            return data.accessToken
            
        } catch let error as TokenError {
            throw error
        } catch {
            throw TokenError.unknownError(error: error)
        }
    }
}
