import Foundation

final class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> Void) {
        // searchTerm could be "instagram", "twitter" etc
        let urlString = "http://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch apps: ", error)
                completion([], error)
                return
            }
            
            if let data {
                // let s = String(data: data, encoding: .utf8)
                // print(s)
                
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(searchResult.results, nil)
                    
                    // print(searchResult)
                    
                    // searchResult.results.forEach {
                    //     print($0.trackName, $0.primaryGenreName)
                    // }
                } catch let jsonError {
                    print("Failed to decode json: ", jsonError)
                    completion([], jsonError)
                }
            }
        }.resume()
    }
}
