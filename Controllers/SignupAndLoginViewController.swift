//
//  SignupAndLoginViewController.swift
//  FitnestX
//
//  Created by Bhavik Jadav on 21/03/24.
//

import UIKit

class SignupAndLoginViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: FXCustomTextField!
    @IBOutlet weak var lastNameField: FXCustomTextField!
    @IBOutlet weak var emailField: FXCustomTextField!
    @IBOutlet weak var passwordField: FXCustomTextField!
    @IBOutlet weak var registerBtn: FXPrimaryButton!
    @IBOutlet weak var registerWithGoogleBtn: FXSquareButtonWithIcon!
    @IBOutlet weak var registerWithFbBtn: FXSquareButtonWithIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        firstNameField.setLeftImage(UIImage(named: "profile.png")!)
        lastNameField.setLeftImage(UIImage(named: "profile.png")!)
        emailField.setLeftImage(UIImage(named: "message.png")!)
        passwordField.setLeftImage(UIImage(named: "lock.png")!)
        registerWithGoogleBtn.setIcon("google.png")
        registerWithFbBtn.setIcon("facebook.png")
    }
    
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
