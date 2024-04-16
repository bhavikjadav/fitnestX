//
//  Constants.swift
//  FitnestX
//
//  Created by Bhavik Jadav on 16/04/24.
//

import UIKit

struct FX {
    static let appName = "FitnestX"
    
    struct segues {
        static let toStartOnBoarding = "toStartOnBoarding"
        static let toCompleteProfile = "toCompleteProfile"
    }
    
    struct fonts {
        static let fontBold = "Poppins-Bold"
    }
    
    struct colors {
        static let color1 = "#9DCEFF"
        static let color2 = "#92A3FD"
        static let dangerColor = UIColor.red.cgColor
        static let textFieldBorderColor = UIColor(red: 0.969, green: 0.973, blue: 0.973, alpha: 1).cgColor
        static let textFieldBackgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.973, alpha: 1)
    }
}
