# SidewalkExample

Sample code for WebSocket-based Javascript execution in WKWebview via [Sidewalk Swift SDK](https://github.com/Danesz/Sidewalk).


## The project
The project showcases a workaround for a [memory leak in WKWebView](https://bugs.webkit.org/show_bug.cgi?id=215729) when using `evaluateJavaScript`

The webview keeps reference to the script that was executed via `evaluateJavaScript` even after the execution was finished.

In this example we send 1 MB strings in every 0,5 sec to the webview and ask to print the length of it.


## The results
The script executions and their effect on the memory were investigated on a jailbroken iPhone with `htop`, `top` and `Xcode`

### WKWebview.evaluateJavasSript(..)
Once the WKWebview was initialized, a new `com.apple.WebKit.WebContent` process appeared on the process list.
The memory usage of this process started to climb up rapidly, above **500+ MB**, more than 25% of the available memory of the device.

(Sometimes, being on this level for a longer period, the webview seemed like it crashed. It got "refreshed" and loaded an empty `about:blank` page.)

![evaluateJavaScript recording](WebviewEvalHighlight.gif)

### sidewalkJavaScript(...)
By using the Sidewalk-way, the memory usage was around **87 MB**.

![sidewalkJavaScript recording](SidewalkEvalHighlight.gif)

### Conclusion
It seems for a Javascript-heavy WKWebview-based application the WebSocket approach is more suitable.

After destorying the webview the memory will be freed, so continous re-creation is also an option when using `evaluateJavaScript`. If the goal is to have a long-living webview, some care is needed around Javascript execution. Here `Sidewalk` can come handy.

## Disclaimer
SidewalkExample and the Sidewalk projects are in a proof-of-concept phase, without any warranties, for educational purposes only.
The author will not be liable for any misinterpretation of data and damages you may suffer in connection with using, modifying, or distributing the projects.
