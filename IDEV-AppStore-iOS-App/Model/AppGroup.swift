import Foundation

struct FeedResult: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct AppGroup: Decodable {
    let feed: Feed
}
