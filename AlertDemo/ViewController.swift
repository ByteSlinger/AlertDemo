//
//  ViewController.swift
//  AlertDemo - Display and dismiss UIAlertControllers with UIControl (no action buttons)
//              (similar to Toast on Android OS)
//
//      4 different ways to close a UIAlertController popup window:
//
//      1) Timeout - dismiss an Alert Window after a number of seconds (like Android Toast)
//      2) Tap outside the Alert Window (tap on Alert Window DOES NOT close it)
//      3) Tap the Alert Window (tap anywhere else DOES NOT close it)
//      4) Tap anywhere on the screen (on Alert Window or outside of it) to close it

//
//  Created by ByteSlinger on 2018-01-19.
//  Copyright © 2018 ByteSlinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let alertController = UIAlertController(title: "Alert", message: "SO Awesome!", preferredStyle: .alert)
    let timeoutController = UIAlertController(title: "Timeout", message: "That Alert timed out!", preferredStyle: .actionSheet)
    let dismissControl = UIControl()
    
    @IBOutlet var alertButton1: UIButton!
    @IBOutlet var alertButton2: UIButton!
    @IBOutlet var alertButton3: UIButton!
    @IBOutlet var alertButton4: UIButton!

    // display a modal popup in the middle, tap outside popup to close
    @IBAction func displayAlert1(_ sender: UIButton) {
        alertController.message = "You must wait for this Alert to timeout"
        
        self.present(alertController, animated: true, completion: {
            self.perform(#selector(self.timeoutAlert), with: self.alertController, afterDelay: 3)
        })
    }
    
    // display a modal popup in the middle, tap outside popup to close
    @IBAction func displayAlert2(_ sender: UIButton) {
        alertController.message = "Tap outside this Alert to close"
        
        self.present(alertController, animated: true, completion: {
            self.dismissControl.frame = self.alertController.view.superview?.bounds ?? CGRect.zero
            
            self.alertController.view.superview?.insertSubview(self.dismissControl, belowSubview: self.alertController.view)
            
            self.perform(#selector(self.timeoutAlert), with: self.alertController, afterDelay: 3)
        })
    }
    
    // display a modal popup in the middle, tap on or outside popup to close
    @IBAction func displayAlert3(_ sender: UIButton) {
        alertController.message = "Tap anywhere to close"
        
        self.present(alertController, animated: true, completion: {
            self.dismissControl.frame = self.alertController.view.superview?.bounds ?? CGRect.zero
            
            self.alertController.view.superview?.addSubview(self.dismissControl)
            
            self.perform(#selector(self.timeoutAlert), with: self.alertController, afterDelay: 3)
        })
    }
    
    // display a modal popup in the middle, tap on popup to close
    @IBAction func displayAlert4(_ sender: UIButton) {
        alertController.message = "Tap on this Alert to close"
        
        self.present(alertController, animated: true, completion: {
            // important - use bounds:  alertController.view.frame WILL NOT WORK
            self.dismissControl.frame = self.alertController.view.bounds

            self.alertController.view.addSubview(self.dismissControl)
            
            self.perform(#selector(self.timeoutAlert), with: self.alertController, afterDelay: 3)
        })
    }

    // close the current alert popup (middle) and display the timeout alert (bottom)
    @objc func timeoutAlert(_ alertController: UIAlertController) {
        if (alertController == UIApplication.shared.keyWindow?.rootViewController?.presentedViewController) {
            timeoutController.message = alertController.message!
            
            alertController.view.willRemoveSubview(self.dismissControl)
            
            alertController.dismiss(animated: true, completion: {
                self.present(self.timeoutController,animated: true, completion: {
                    self.perform(#selector(self.dismissTimeout), with: self.timeoutController, afterDelay: 2)
                })
            })
        }
    }
    
    // dimiss (close) the alert popup
    @objc func dismissAlert() {
        // make sure there are no timeoutAlert calls waiting
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        alertController.view.willRemoveSubview(self.dismissControl)
        
        alertController.dismiss(animated: true, completion: nil)
    }
    
    // dimiss (close) the timeout popup
    @objc func dismissTimeout(_ alert: UIAlertController) {
        alert.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // make the dismissControl execute dismissAlert for all touch events
        dismissControl.addTarget(self, action: #selector(self.dismissAlert), for: .allTouchEvents)
        
        // make the buttons a little prettier
        alertButton1.layer.cornerRadius = 32
        alertButton2.layer.cornerRadius = 32
        alertButton3.layer.cornerRadius = 32
        alertButton4.layer.cornerRadius = 32
    }
}

