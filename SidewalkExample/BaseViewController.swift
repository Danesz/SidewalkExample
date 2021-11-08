import UIKit
import Sidewalk
import WebKit
import Telegraph

class BaseViewController: UIViewController {

    let padding = "".padding(toLength: 1*1024*1024, withPad: "?", startingAt: 0)

    var webview: WKWebView?
    var index: Int =  0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        // some webview configuration
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        //custom webview script config
        config.userContentController = WKUserContentController()
        config.userContentController.addUserScript(WKUserScript(source: "console.log('atDocumentEnd')", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true))
        config.userContentController.addUserScript(WKUserScript(source: "console.log('atDocumentStart')", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true))
        
        webview = WKWebView(frame: CGRect(x: 100, y: 100, width: 200, height: 400), configuration: config)
        self.view.addSubview(webview!)

        self.customWebviewSetup()
        
        webview?.loadHTMLString("<html><head></head><body style=\"font-size: 5em;\"></body></html>", baseURL: URL(string: "http://localhost"))
        
        self.startTimer()
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            print("Timer fired!")
            guard let welf = self else {
                return;
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                welf.index = welf.index+1
                let script = String(format: "document.body.innerHTML = %d + \", \" + \"%@\".length", welf.index, welf.padding)

                welf.evaluateJS(script: script)
                                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
        self.customWebviewTeardown()
        self.webview!.removeFromSuperview()
        self.webview = nil
    }
    
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning!")
    }
    
    //MARK: - abstract methods
    
    func customWebviewSetup() {
        preconditionFailure("This method must be overridden")
    }
    
    func customWebviewTeardown() {
        preconditionFailure("This method must be overridden")
    }
    
    func evaluateJS(script: String) {
        preconditionFailure("This method must be overridden")
    }
    
}

