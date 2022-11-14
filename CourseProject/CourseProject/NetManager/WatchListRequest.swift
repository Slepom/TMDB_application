
import Foundation
import Alamofire

class WatchListRequest{
    static let shared = WatchListRequest()
    private init(){}
    var arrayWatchlistMoview = [MoviesByGenre]()
        
    // MARK: - request for add movie from watch list
    
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
    
    // MARK: - request for delete movie from watch list
        func removeMoviewFromWatchlist(accountID: Int, mediaType: String, mediaId: Int, sessionId: String, completion: @escaping (SessionResponce, Int) -> Void) {
    
                let parameters: [String: Any] = [
                    "media_type": mediaType,
                    "media_id": mediaId,
                    "watchlist": false
                ]
    
                let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accountID)/watchlist?api_key=\(apiKey)&session_id=\(sessionId)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    
                genresRequest.responseDecodable(of: SessionResponce.self) { response in
                    do {
                        let data = try response.result.get()
                        completion(data, mediaId)
                    }
                    catch {
                        print("error: \(error)")
                    }
    
                }
            }
   
}
