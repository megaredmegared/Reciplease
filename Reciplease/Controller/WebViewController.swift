//
//  WebViewController.swift
//  Reciplease
//
//  Created by megared on 12/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var url: URL?
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
    }}

//class WebViewController: UIViewController, WKUIDelegate {
//
//     var webView: WKWebView!
//    
//    
//    var url: URL?
//    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        showWebPage()
//    }
//    
//    func showWebPage() {
//        let safeURL = URL(string: "https//www.apple.com")!
////        let request = URLRequest(url: safeURL!)
//        webView.load(URLRequest(url: safeURL))
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
