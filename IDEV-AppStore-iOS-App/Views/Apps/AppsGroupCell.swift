import UIKit

final class AppsGroupCell: UICollectionViewCell {
    
    let tittleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        contentView.addSubview(tittleLabel)
        // tittleLabel.fillSuperview()
        tittleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
