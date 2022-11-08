
import Foundation
import Alamofire

class WatchListRequest{
    static let shared = WatchListRequest()
    private init(){}
    var arrayWatchlistMoview = [MoviesByGenre]()
        
        func getWatchlist(accountId: Int, sessionId: String, completion: @escaping(([MoviesByGenre])->())) {

            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accountId)/watchlist/movies?language=en-US&sort_by=created_at.asc&page=1&api_key=\(apiKey)&session_id=\(sessionId)", method: .get)

            genresRequest.responseDecodable(of: MovieModel.self) { response in
                do {
                    self.arrayWatchlistMoview = try response.result.get().results
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }

            }
        }
    
    
    
    
    
}
