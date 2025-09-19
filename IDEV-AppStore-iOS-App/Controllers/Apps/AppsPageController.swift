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
// All info about App with ID 6448311069 (ChatGPT): https://itunes.apple.com/lookup?id=6448311069
//

final class AppsPageController: BaseListController {
    
    fileprivate let cellIdentifier = "AppsGroupCell"
    fileprivate let headerIdentifier = "AppsGroupHeader"
    
    fileprivate var topFreeApps: AppGroup?
    
    fileprivate var socialApps: [SocialApp] = []
    fileprivate var groups: [AppGroup] = []
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicatorView.color = .black
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.register(AppsPageHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        var group1: AppGroup?
        var group2: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeApps { appGroup, error in
            dispatchGroup.leave()
            
            if let error {
                print("Failed to fetch Top Free Apps: ", error)
            } else if let appGroup {
                // Not used anymore
                // self.topFreeApps = appGroup
                
                // self.groups.append(appGroup)
                group1 = appGroup
 
                // DispatchQueue.main.async {
                //     self.collectionView.reloadData()
                // }
                
                // print(appGroup.feed.results)
                // print(appGroup.feed.title)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaidApps { appGroup, error in
            dispatchGroup.leave()
            
            if let error {
                print("Failed to fetch Top Paid Apps: ", error)
            } else if let appGroup {
                // Not used anymore
                // self.topFreeApps = appGroup
                
//                self.groups.append(appGroup)
                group2 = appGroup
 
                // DispatchQueue.main.async {
                //     self.collectionView.reloadData()
                // }
                
                // print(appGroup.feed.results)
                // print(appGroup.feed.title)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { socialApps, error in
            dispatchGroup.leave()
            
            if let error {
                print("Failed to fetch Social Apps: ", error)
            } else if let socialApps {
                self.socialApps = socialApps
                
                // socialApps.forEach { print($0.name) }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All task completed")
            
            self.activityIndicatorView.stopAnimating()
            
            if let group1 {
                self.groups.append(group1)
            }
            
            if let group2 {
                self.groups.append(group2)
            }
            
            self.collectionView.reloadData() // We are on Main Queue here, so no need to explicitly dispatch to Main Queue
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerIdentifier,
            for: indexPath
        ) as! AppsPageHeader
        
        header.appsHeaderHorizontalController.socialApps = socialApps
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
                cellIdentifier, for: indexPath
        ) as! AppsGroupCell
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            let appDetailVC = AppDetailController()
            appDetailVC.appId = feedResult.id
            appDetailVC.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(appDetailVC, animated: true)
        }
        
        // cell.titleLabel.text = topFreeApps?.feed.title
        // cell.horizontalController.appGroup = topFreeApps
        
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
