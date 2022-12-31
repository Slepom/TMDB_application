
import Foundation


class TrailerViewModel{
    
    var arrayOfVideosForMovie: [Video] = []
    
func loadTrailerForMovie(movieId: Int, completion: @escaping ([Video]) -> ()) {
    
    let genresRequest = AF.request("https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)", method: .get)
    
    genresRequest.responseDecodable(of: VideoResponce.self) { response in
        do {
            self.arrayOfVideosForMovie = try response.result.get().results
            let filtered = self.arrayOfVideosForMovie.filter { video in // ???????????????????
                return video.type.rawValue == "Trailer"
            }
            completion(filtered)
        }
        catch {
            print("error: \(error)")
        }
        
    }
    
}
}
