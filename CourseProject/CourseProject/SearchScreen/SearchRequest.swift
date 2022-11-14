

import Foundation
import Alamofire

class SearchRequest{
    
    static let shared = SearchRequest()
    private init(){}
    
    func search(with query: String, completion: @escaping([Movie])->Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let movieRequest = AF.request("https:api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)", method: .get)
        movieRequest.responseDecodable(of: SearchModel.self) { responce in
            do {
//                self.searchArray = try responce.result.get().results
                let data = try responce.result.get().results
                completion(data)
            } catch {
//                completion(.failure(error))
            }
            
        }
        
    }

}
