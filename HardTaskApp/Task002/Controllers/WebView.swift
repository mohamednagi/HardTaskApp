//
//  WebView.swift
//  HardTask
//
//  Created by Mohamed Nagi on 4/1/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instance.getTerms(webView: webView)
    }
    

}
