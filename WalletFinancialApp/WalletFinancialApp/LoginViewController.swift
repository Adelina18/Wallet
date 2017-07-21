//
//  LoginViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/19/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginMessage: UILabel!
    
    let kMsgShowFinger = "Fingerprint needed"
    let kMsgShowReason = "Dismiss this screen"
    let kMsgSuccess = "Login successfully"
    
    var context = LAContext()
    var policy: LAPolicy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        var error: NSError?
        
        if #available(iOS 9.0, *) {
            // iOS 9+ users with Biometric and Passcode verification
            policy = .deviceOwnerAuthentication
        } else {
            // iOS 8+ users with Biometric and Custom (Fallback button) verification
            context.localizedFallbackTitle = "Fuu!"
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
        
        guard context.canEvaluatePolicy(policy!, error: &error) else {
            loginMessage.text = error?.localizedDescription
            return
        }
        
        //Touch ID can be used
        loginMessage.text = kMsgShowFinger
        loginProcess(policy: policy!)
    }
    
    private func loginProcess(policy: LAPolicy) {
        // Start evaluation process with a callback that is executed when the user ends the process successfully or not
        context.evaluatePolicy(policy, localizedReason: "Touch ID is needed to login into the application.", reply: { (success, error) in
            DispatchQueue.main.async {

                guard success else {
                    guard let error = error else {
                        print("Unexpected error!")
                        return
                    }
                    
                    switch(error) {
                        case LAError.authenticationFailed:
                            print ("There was a problem verifying your identity.")
                        case LAError.userCancel:
                            print("Authentication was canceled by user.")
                        case LAError.userFallback:
                            print("The user tapped the fallback button (Fuu!)")
                        case LAError.systemCancel:
                            print("Authentication was canceled by system.")
                        case LAError.passcodeNotSet:
                            print("Passcode is not set on the device.")
                        case LAError.touchIDNotAvailable:
                            print("Touch ID is not available on the device.")
                        case LAError.touchIDNotEnrolled:
                            print("Touch ID has no enrolled fingers.")
                        // iOS 9+ functions
                        case LAError.touchIDLockout:
                            print("There were too many failed Touch ID attempts and Touch ID is now locked.")
                        case LAError.appCancel:
                            print("Authentication was canceled by application.")
                        case LAError.invalidContext:
                            print("LAContext passed to this call has been previously invalidated.")
                        default:
                            print("Touch ID may not be configured")
                            break
                    }
                    
                    self.loginMessage.text = "Retry"
                    let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapFunc))
                    self.loginMessage.addGestureRecognizer(tap)
                    self.loginMessage.isUserInteractionEnabled = true
                    
                    return
                }
                self.loginMessage.text = self.kMsgSuccess
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.goToDashboard()
                }
            }
        })
    }
    
    func tapFunc(sender: UITapGestureRecognizer) {
        loginProcess(policy: policy!)
    }
    
    func goToDashboard() {
        
    }

}

