//
//  WebViewController.swift
//  Reciplease
//
//  Created by megared on 12/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

//class WebViewController: UIViewController, SFSafariViewControllerDelegate WKUIDelegate {
//    var url: URL?
//    var webView: WKWebView!
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
//        loadPage()
//    }
//
//    func loadPage() {
//        guard url != nil else {
//            print("pas d'url")
//            return
//        }
//        let myRequest = URLRequest(url: url!)
//        webView.load(myRequest)
//    }
class WebViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var url: URL?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openSafariVC()
    }
    
    func openSafariVC() {
        let safariVC = SFSafariViewController(url: url!)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
    
//    @IBAction func tappedNextButton(_ sender: Any) {
//    }
//
//    @IBAction func tappedBackButton(_ sender: Any) {
//    }
//}



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
