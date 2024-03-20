import UIKit

class FXPrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleButton()
    }
    
    private func styleButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Poppins-Bold", size: 20.0)
        layer.cornerRadius = 27
        setShadow()
        applyGradientToButton()
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    private func applyGradientToButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        let color1 = UIColor(hex: "#9DCEFF") ?? UIColor.blue
        let color2 = UIColor(hex: "#92A3FD") ?? UIColor.blue
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            // If the hex string is invalid, initialize with a default color
            self.init(white: 0, alpha: 0)
            return nil
        }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


