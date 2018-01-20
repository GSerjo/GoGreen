//
//  CaseViewController.swift
//  GoGreen
//
//  Created by Sergey Morenko on 1/20/18.
//  Copyright © 2018 Sergey Morenko. All rights reserved.
//

import UIKit
import WebKit

class CaseViewController: UIViewController {

    @IBOutlet weak var _webView: WKWebView!
    private var _case: CaseEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = _case.value
        
        let myURL = URL(string: "https://egov.uscis.gov/casestatus/mycasestatus.do?appReceiptNum=\(_case.value)")
        let myRequest = URLRequest(url: myURL!)
        _webView.load(myRequest)
    }
    
    public func setup(entity: CaseEntity) -> Void {
        _case = entity
    }
}
