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

final class AppsSearchController: BaseListController {

    fileprivate let cellIdentifier = "SearchResultCell"
    
    fileprivate let searchControler = UISearchController(searchResultsController: nil)
    
    fileprivate var timer: Timer? // Userd for Search Throttling
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
        
        // fetchiTunesApps()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchControler
        navigationItem.hidesSearchBarWhenScrolling = false
        searchControler.obscuresBackgroundDuringPresentation = false
        searchControler.searchBar.delegate = self
    }
    
    fileprivate var appResults: [Result] = []
    
    fileprivate func fetchiTunesApps() {
        Service.shared.fetchApps(searchTerm: "Twitter") { result, error in
            if let error {
                print("Failed to fetch apps: ", error)
                return
            }
            
            self.appResults = result?.results ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        enterSearchTermLabel.isHidden = appResults.count != 0
        
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath
        ) as! SearchResultCell
        
        cell.appResult = appResults[indexPath.item]
        
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

extension AppsSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        
        print(searchText)
        
        // We have to use Search Throttling - a small delay before making the Network Request
        
        timer?.invalidate() // Cancels any previous scheduled execution
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            Service.shared.fetchApps(searchTerm: searchText) { result, error in
                self.appResults = result?.results ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
