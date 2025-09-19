import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}

extension UIButton {
    
    convenience init(title: String) {
        self.init(type: .system)
        
        setTitle(title, for: .normal)
    }
}
