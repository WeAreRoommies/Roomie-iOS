//
//  MyPageWebViewController.swift
//  Roomie
//
//  Created by 예삐 on 7/18/25.
//

import UIKit
import WebKit

import SnapKit
import Then

final class MyPageWebViewontroller: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = UIView()
    
    private var webView: WKWebView! = nil
    
    private let webViewType: WebViewType
    
    // MARK: - LifeCycle
    
    init(type: WebViewType) {
        self.webViewType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setView() {
        setNavigationBar(with: webViewType.title)
    }
    
    // MARK: - Function
    
    func loadURL() {
        let urlString = webViewType.urlString
        guard let url = URL(string: urlString) else {
            print("URL 변환 실패: \(urlString)")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
