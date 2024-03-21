//
//  SignupAndLoginViewController.swift
//  FitnestX
//
//  Created by Bhavik Jadav on 21/03/24.
//

import UIKit

class SignupAndLoginViewController: UIViewController {

        
    @IBOutlet weak var firstNameField: FXCustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.setLeftImage(UIImage(named: "profile.png")!)
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
