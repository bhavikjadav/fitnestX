//
//  OnboardingViewController.swift
//  FitnestX
//
//  Created by Bhavik Jadav on 20/03/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var getStartedBtn: FXPrimaryButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func getStartedPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStartOnBoarding", sender: self)
    }
}
