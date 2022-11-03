

import Foundation
import Alamofire

class TrailerRequest {
    static let shared = TrailerRequest()

    private init(){}
    
    var videoKey = String()
    var arrayOfVideosForMovie = [Video]()
    var arrayOfVideosForTV = [Video]()

    func loadTrailerForMovie(movieId: Int, completion: @escaping ([Video]) -> ()) {
        
        let genresRequest = AF.request("https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)", method: .get)
        
        genresRequest.responseDecodable(of: VideoResponce.self) { response in
            do {
                self.arrayOfVideosForMovie = try response.result.get().results
                let filtered = self.arrayOfVideosForMovie.filter { video in
                    return video.type.rawValue == "Trailer"
                }
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\(filtered.count)")
                completion(filtered)
            }
            catch {
                print("error: \(error)")
            }
            
        }
        
    }
        
}
