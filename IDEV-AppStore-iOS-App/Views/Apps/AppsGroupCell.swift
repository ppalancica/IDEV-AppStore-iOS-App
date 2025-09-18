import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        
        self.text = text
        self.font = font
    }
}

final class AppsGroupCell: UICollectionViewCell {
    
    let tittleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
    
    let horizontalController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        contentView.addSubview(tittleLabel)
        // tittleLabel.fillSuperview()
        tittleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        contentView.addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        horizontalController.view.anchor(top: tittleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
