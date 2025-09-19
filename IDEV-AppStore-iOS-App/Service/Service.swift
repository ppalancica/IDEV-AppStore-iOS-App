import Foundation

final class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> Void) {
        let urlString = "http://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    /* func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> Void) {
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
    } */
    
    /* func fetchTopFreeApps(completion: @escaping (AppGroup?, Error?) -> Void) {
        // https://apps.apple.com/us/story/id1551161750
        // https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/games/25/explicit.json
        let urlString = "https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/25/apps.json"
        // To get Top Paid Apps use: "https://rss.marketingtools.apple.com/api/v2/us/apps/top-paid/25/apps.json"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch games: ", error)
                completion(nil, error)
                return
            }
            
            if let data {
                do {
                    let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                    completion(appGroup, nil)
                    
                    // print(appGroup.feed.results)
                    
                    // appGroup.feed.results.forEach {
                    //    print($0.name)
                    // }
                } catch let jsonError {
                    print("Failed to decode json: ", jsonError)
                    completion(nil, error)
                }
            }
            
        }.resume()
    } */
    
    func fetchTopFreeApps(completion: @escaping (AppGroup?, Error?) -> Void) {
        let urlString = "https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/25/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaidApps(completion: @escaping (AppGroup?, Error?) -> Void) {
        let urlString = "https://rss.marketingtools.apple.com/api/v2/us/apps/top-paid/25/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // The API doesn't seem to work anymore
    func fetchNewgames(completion: @escaping (AppGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/games/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // Helper
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
        /* let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch apps: ", error)
                completion(nil, error)
                return
            }
            
            if let data {
                do {
                    let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                    completion(appGroup, nil)
                    
                    // print(appGroup.feed.results)
                    
                    // appGroup.feed.results.forEach {
                    //    print($0.name)
                    // }
                } catch let jsonError {
                    print("Failed to decode json: ", jsonError)
                    completion(nil, error)
                }
            }
            
        }.resume() */
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
        /* let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch apps: ", error)
                completion(nil, error)
                return
            }
            
            if let data {
                do {
                    let objects = try JSONDecoder().decode([SocialApp].self, from: data)
                    completion(objects, nil)
                    // print(objects)
                } catch let jsonError {
                    print("Failed to decode json: ", jsonError)
                    completion(nil, error)
                }
            }
            
        }.resume() */
    }
    
    func fetchGenericJSONData<T: Decodable>(
        urlString: String,
        completion: @escaping (T?, Error?) -> Void
    ) {
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Failed to fetch JSON data: ", error)
                completion(nil, error)
                return
            }
            
            if let data {
                do {
                    let objects = try JSONDecoder().decode(T.self, from: data)
                    completion(objects, nil)
                    // print(objects)
                } catch let jsonError {
                    print("Failed to decode JSON text: ", jsonError)
                    completion(nil, error)
                }
            }
            
        }.resume()
    }
}
