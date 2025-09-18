import UIKit

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

final class AppsSearchController: UICollectionViewController {

    fileprivate let cellIdentifier = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        fetchiTunesApps()
    }
    
    fileprivate func fetchiTunesApps() {
        let urlString = "http://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch apps: ", error)
                return
            }
            
            if let data {
                let s = String(data: data, encoding: .utf8)
                print(s)
            }
            
        }.resume()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath
        ) as! SearchResultCell
        
        cell.nameLabel.text = "HERE IS MY APP NAME"
        
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
