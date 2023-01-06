

import Foundation
import Alamofire

class TrailerRequest {
    static let shared = TrailerRequest()

    private init(){}
    
    var videoKey = String()
    var arrayOfVideosForMovie = [Video]()
    var arrayOfVideosForTV = [Video]()

    
    
    // MARK: - Getting trailer movie
    func loadTrailerForMovie(movieId: Int, completion: @escaping ([Video]) -> ()) {
        
        let genresRequest = AF.request("https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)", method: .get)
        
        genresRequest.responseDecodable(of: VideoResponce.self) { response in
            do {
                self.arrayOfVideosForMovie = try response.result.get().results
                let filtered = self.arrayOfVideosForMovie.filter { video in
                    return video.type.rawValue == "Trailer"
                }
                completion(filtered)
            }
            catch {
                print("error: \(error)")
            }
            
        }
        
    }
    
    // MARK: - Add movie to watch list
    func addToWatchlist(accountID: Int, mediaType: String, mediaId: Int, sessionId: String, completion: @escaping (Welcome, String) -> Void) {
           
           let parameters: [String: Any] = [
                 "media_type": mediaType,
                 "media_id": mediaId,
                 "watchlist": true
           ]
           
           let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accountID)/watchlist?api_key=\(apiKey)&session_id=\(sessionId)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
           
           genresRequest.responseDecodable(of: Welcome.self) { response in
               do {
                   let data = try response.result.get()
                   completion(data, mediaType)
               }
               catch {
                   print("error: \(error)")
               }
               
           }
       }
}
