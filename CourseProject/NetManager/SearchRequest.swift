

import Foundation
import Alamofire

class SearchRequest{
    
    static let shared = SearchRequest()
    private init(){}
    
    // MARK: - Getting data after search
    
    func search(with query: String, completion: @escaping([MoviesByGenre])->Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let movieRequest = AF.request("https:api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)", method: .get)
        movieRequest.responseDecodable(of: MovieModel.self) { responce in
            do {
                let data = try responce.result.get().results
                completion(data)
            } catch {
                print(error)

            }
            
        }
        
    }

}
