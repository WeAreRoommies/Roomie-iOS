//
//  HouseDetailWebViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/24/25.
//

import UIKit
import WebKit

import SnapKit
import Then

final class HouseDetailWebViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = UIView()
    
    private var webView: WKWebView! = nil
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = rootView
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }
    
    // MARK: - UISetting
    
    func setStyle() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration).then {
            $0.allowsBackForwardNavigationGestures = true
            $0.configuration.preferences.javaScriptEnabled = true
        }
    }
    
    func setUI() {
        self.rootView.addSubview(webView)
    }
    
    func setLayout() {
        webView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    override func setView() {
        setNavigationBar(with: "")
    }
    
    // MARK: - Function
    
    func loadURL() {
        if let url = URL(string: "http://pf.kakao.com/_WviTn") {
            let urlRequest = URLRequest(url: url)
            webView?.load(urlRequest)
        } else {
            print("실패")
        }
    }
}
