import UIKit

final class AppDetailController: BaseListController {
    
    fileprivate let cellIdentifier = "AppDetailCell"
    
    var appId: String! {
        didSet {
            // print("appId: ", appId)
            let urlString = "https://itunes.apple.com/lookup?id=\(appId!)" // e.g. 6448311069
            
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
                print(result?.results.first?.releaseNotes)
                
                let app = result?.results.first
                self.app = app
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as! AppDetailCell
        
        cell.app = app
        
        return cell
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Calculate the size the cell needs based on the content
        let dummyCell = AppDetailCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        dummyCell.app = app
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))
        
        return CGSize(width: view.frame.width, height: estimatedSize.height)
        // return CGSize(width: view.frame.width, height: 600)
    }
}
