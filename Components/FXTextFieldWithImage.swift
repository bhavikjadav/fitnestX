// CustomTextField.swift

import UIKit

class FXCustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Set the Poppins-Regular font with a size of 12pt
        self.font = UIFont(name: "Poppins-Regular", size: 14)

        // Set corner radius and background color
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.973, alpha: 1)

        // Additional styling
        self.clipsToBounds = true
    }

    func setLeftImage(_ image: UIImage) {
        let iconSize = CGFloat(18)  // Size of the icon
        let leftMargin = CGFloat(15)
        let spaceBetweenIconAndPlaceholder = CGFloat(8)

        let leftImageView = UIImageView(frame: CGRect(x: leftMargin, y: 0.0, width: iconSize, height: iconSize))
        leftImageView.image = image
        leftImageView.contentMode = .scaleAspectFit

        let viewWidth = iconSize + leftMargin + spaceBetweenIconAndPlaceholder
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: viewWidth, height: iconSize))
        leftView.addSubview(leftImageView)

        self.leftView = leftView
        self.leftViewMode = .always
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 315, height: 48)
    }
}
