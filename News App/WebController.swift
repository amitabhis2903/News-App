//
//  WebController.swift
//  News App
//
//  Created by Ammy Pandey on 02/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class WebController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
    }

   
}
