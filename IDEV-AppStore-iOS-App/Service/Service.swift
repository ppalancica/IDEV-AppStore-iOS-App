import Foundation

final class Service {
    
    static let shared = Service()
    
    func fetchApps(completion: @escaping ([Result]) -> Void) {
        let urlString = "http://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch apps: ", error)
                return
            }
            
            if let data {
                // let s = String(data: data, encoding: .utf8)
                // print(s)
                
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(searchResult.results)
                    
                    // print(searchResult)
                    
                    // searchResult.results.forEach {
                    //     print($0.trackName, $0.primaryGenreName)
                    // }
                } catch let jsonError {
                    print("Failed to decode json: ", jsonError)
                }
            }
        }.resume()
    }
}
