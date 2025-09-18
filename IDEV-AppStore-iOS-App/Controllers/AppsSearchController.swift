import UIKit
import SDWebImage
//
// iTunes Search API
//
// https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
//
// https://performance-partners.apple.com/search-api
//
// https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/SearchExamples.html#//apple_ref/doc/uid/TP40017632-CH6-SW1
//
// http://itunes.apple.com/search?term=jack+johnson
// http://itunes.apple.com/search?term=instagram&entity=software
//
// https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html
// https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/LookupExamples.html
//
// https://performance-partners.apple.com/program-overview
//
// https://publicapi.dev/i-tunes-api
//
// https://jsonformatter.org/json-pretty-print
//
// https://stackoverflow.com/questions/44177089/itunes-search-api-page-number-for-the-query
//
// ----------------
//
// https://cocoapods.org/
// https://github.com/SDWebImage/SDWebImage
//
// sudo gem install cocoapods
// pod init
// vi Podfile
// open Podfile
// Add pod 'SDWebImage'
// pod install
//
// Close Xcode and open .xcworkspace from now on
//
// ENABLE_USER_SCRIPT_SANDBOXING must be NO
//
// https://stackoverflow.com/questions/76590131/error-while-build-ios-app-in-xcode-sandbox-rsync-samba-13105-deny1-file-w
//

final class AppsSearchController: UICollectionViewController {

    fileprivate let cellIdentifier = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        fetchiTunesApps()
    }
    
    fileprivate var appResults: [Result] = []
    
    fileprivate func fetchiTunesApps() {
        Service.shared.fetchApps() { results, error in
            if let error {
                print("Failed to fetch apps: ", error)
                return
            }
            
            self.appResults = results
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath
        ) as! SearchResultCell
        
        let appResult = appResults[indexPath.item]
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        
        // We can use a library such as SDWebImage
        
        // cell.appIconImageView.image =
        // cell.screenshot1ImageView
        
        // cell.nameLabel.text = "HERE IS MY APP NAME"
        
        return cell
    }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
}
