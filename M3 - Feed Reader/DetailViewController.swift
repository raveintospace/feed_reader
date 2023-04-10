//
//  DetailViewController.swift
//  M3 - Feed Reader
//
//  Created by Uri on 8/4/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var webContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
