//
//  SidewalkEvaluateViewController.swift
//  SidewalkExample
//
//  Created by Daniel Dallos on 13/11/2021.
//

import Foundation
import Sidewalk

class SidewalkEvaluateViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SidewalkEvaluate"
    }
    
    override func evaluateJS(script: String) {
        self.webview?.sidewalkJavaScript(script)
    }
    
    override func customWebviewSetup() {
        Sidewalk.shared().attachToWebView(webview!, when: .atDocumentStart)
    }
    
    override func customWebviewTeardown() {
        Sidewalk.shared().forgetWebview(self.webview!)
    }
}
