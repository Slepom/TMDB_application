
import Foundation
import Alamofire

class GettingData{
    
    static let shared = GettingData()
    
    private init(){}
    
    
    func getGenres(_ complitionHandler: @escaping ([Genre]) -> Void){
        
        let request = AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=6cde63f94256f35e302a61f1dd4b7524&language=en-US", method: .get)
        request.responseDecodable(of: GenreModel.self) { response in
            
            do {
                let genres = try response.result.get().genres
                
                //print(genres)
                complitionHandler(genres)
            }
            catch{
                print(error)
            }
        }
        
    }
    
    func createListMovie(){
        
        getGenres { arrayGenres in
            
            let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=6cde63f94256f35e302a61f1dd4b7524&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate", method: .get)
            request.responseDecodable(of: MovieModel.self) { response in
                
                do {
                    let result = try response.result.get().results.first
                    
                    print(result ?? "")
                }
                catch{
                    print(error)
                }
            }
            
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
