//
//  WebviewEvaluateViewController.swift
//  SidewalkExample
//
//  Created by Daniel Dallos on 13/11/2021.
//

import Foundation

class WebviewEvaluateViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WebviewEvaluate"
    }
    
    override func evaluateJS(script: String) {
        self.webview?.evaluateJavaScript(script)
    }
    
    override func customWebviewSetup() {
        
    }
    
    override func customWebviewTeardown() {
        
    }
}
