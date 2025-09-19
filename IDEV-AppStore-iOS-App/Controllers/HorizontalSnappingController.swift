import UIKit

class HorizontalSnappingController: UICollectionViewController {

    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        
        super.init(collectionViewLayout: layout)
        
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnappingLayout: UICollectionViewFlowLayout {
    
    // Snap Behaviour
    
    // https://stackoverflow.com/a/43637969
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }
        
        // Some Math :)
        
        // let itemWidth = collectionView.frame.width - 48
        // let pageNumber = collectionView.contentOffset.x / itemWidth
        
        // return CGPoint(x: pageNumber * itemWidth, y: 0)
        
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                               withScrollingVelocity: velocity)

        // We are using Magic numbers, which is Incorrect
        let itemWidth = collectionView.frame.width - 48
        let itemSpace = itemWidth + minimumInteritemSpacing
        // let itemSpace = itemSize.width + minimumInteritemSpacing
        var currentItemIdx = round(collectionView.contentOffset.x / itemSpace)

        // Skip to the next cell, if there is residual scrolling velocity left.
        // This helps to prevent glitches
        let vX = velocity.x
        
        if vX > 0 {
            currentItemIdx += 1
        } else if vX < 0 {
            currentItemIdx -= 1
        }

        let nearestPageOffset = currentItemIdx * itemSpace
        
        return CGPoint(x: nearestPageOffset,
                       y: parent.y)
    }
}
