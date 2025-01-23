//
//  APPLELOVERCLUBViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/24/25.
//

import UIKit

import WebKit
import SnapKit
import Then

final class APPLELOVERCLUBViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = UIView()
    
    private var webView: WKWebView! = nil
    
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
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = rootView
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUrl()
    }
    
    override func setView() {
        setNavigationBar(with: "")
    }
    
    // MARK: - Function
    
    func loadUrl() {
        if let url = URL(string: "https://1401kms-70595.waveon.me") {
            let urlRequest = URLRequest(url: url)
            webView?.load(urlRequest)
        } else {
            print("실패")
        }
    }
}
