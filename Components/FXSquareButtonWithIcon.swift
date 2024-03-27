import UIKit

class FXSquareButtonWithIcon: UIButton {
    
    // Initializer for programmatically created buttons
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    // Required initializer for Storyboard/XIB usage
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    private func configureButton() {
        // Set default button appearance
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor(red: 0.867, green: 0.853, blue: 0.855, alpha: 1).cgColor
        
        // Adjust the image within the button if needed
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // Adjust insets as needed
    }
    
    // Public function to set the icon of the button, resizing the icon to 20x20 points and maintaining its original color
    func setIcon(_ imageName: String) {
        if let originalImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal) {
            let resizedImage = resizeImage(image: originalImage, targetSize: CGSize(width: 20, height: 20))
            self.setImage(resizedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    // Helper function to resize an image to a new size
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
}
