

/*
 view controller life cycle
 
 init()
 viewLoad()
 viewDidLoad()
 viewWillAppear()
 viewWillLayoutSubviews()
 viewDidLayoutSubviews()
 viewDidAppear()
 viewWillDisappear()
 viewDidDisappear()
 deinit()
 
 didReceiveMemoryWarning()
 viewWillTransition(to: with:)
 
 */

/*
 Difference
 */

import UIKit
import PlaygroundSupport

let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
view.backgroundColor = UIColor.red
container.addSubview(view)

PlaygroundPage.current.liveView = container
PlaygroundPage.current.needsIndefiniteExecution = true
