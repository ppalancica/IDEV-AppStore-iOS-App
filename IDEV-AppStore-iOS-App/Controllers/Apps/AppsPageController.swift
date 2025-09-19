import UIKit

//
// RSS Feed Generator
//
// https://rss.marketingtools.apple.com/
//
// https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/25/apps.json
//
// Not working anymore: http://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json
// https://itunes.apple.com/lookup?id=%@
//
// https://rss.app/en/
//
final class AppsPageController: BaseListController {
    
    fileprivate let cellIdentifier = "AppsGroupCell"
    fileprivate let headerIdentifier = "AppsGroupHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.register(AppsPageHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchTopFreeApps { appGroup, error in
            if let error {
                print("Failed to fetch Top Free Apps")
                return
            }
            
            if let appGroup {
                print(appGroup.feed.results)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: headerIdentifier,
                                                                     for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        return cell
    }
}

extension AppsPageController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}
