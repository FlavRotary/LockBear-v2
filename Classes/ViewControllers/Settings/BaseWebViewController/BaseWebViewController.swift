//
//  BaseWebViewController.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class BaseWebViewController: BaseViewController, WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        webView.navigationDelegate = self
    }
    
    //MARK: - WKWebViewNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        let activityData = ActivityData(size: CGSize(width: 100,height: 100),
                                        message: "Loading...",
                                        messageFont: UIFont.boldSystemFont(ofSize: 18.0),
                                        messageSpacing: nil,
                                        type: .circleStrokeSpin,
                                        color: UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0),
                                        padding: 10,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil,
                                        backgroundColor: UIColor.clear,
                                        textColor: UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0))
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
