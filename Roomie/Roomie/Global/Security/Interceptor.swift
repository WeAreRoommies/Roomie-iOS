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
    private init() {}
    
    let retryLimit = 3
    let retryDelay: TimeInterval = 1
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
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
        completion: @escaping (
            RetryResult
        ) -> Void
    ) {
        print("----------------- [ retry 진입 ] -----------------")
        guard let response = request.task?.response as? HTTPURLResponse,response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        
        guard request.retryCount < retryLimit else {
                return completion(.doNotRetryWithError(error))
            }

        Task {
            do {
                let (accessToken, refreshToken) = try await authReissue()
                TokenManager.shared.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                completion(.retryWithDelay(retryDelay))
                
            } catch  {
                print("토큰 재발급 오류: \(error.localizedDescription)")
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

private extension Interceptor {
    func authReissue() async throws -> (String, String) {
        /*
         Todo: 에러처리 필요
         */
        do {
            guard let refreshToken = TokenManager.shared.fetchRefreshToken() else {
                throw NSError(domain: "RefreshTokenError", code: -1, userInfo: [NSLocalizedDescriptionKey: "refreshToken 없음"])
            }
            
            /*
             Todo: 의존성 주입 필요
             */
            guard let responseBody = try await AuthService().authReissue(refreshToken: refreshToken),
                  let data = responseBody.data else {
                
                throw NSError(domain: "ReissueError", code: -1, userInfo: [NSLocalizedDescriptionKey: "재발급 데이터 없음"])
            }
            
            return (data.accessToken, data.refreshToken)
            
        } catch {
            throw error
        }
    }
}
