
import Foundation
import Alamofire

class GettingData{
    
    static let shared = GettingData()
    
    private init(){}
    
    
    var networkDictionary: [Genre:[MoviesByGenre]] = [:]
    
    // MARK: - Getting all genres
    
    func getGenres(_ complitionHandler: @escaping ([Genre]) -> Void){
        
        let request = AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US", method: .get)
        request.responseDecodable(of: GenreModel.self) { response in
            
            do {
                let genres = try response.result.get().genres
                complitionHandler(genres)
            }
            catch{
                 print(" error getGenres \(error)")
            }
        }
        
    }
    
//    func createListMovie(_ complitionHandler: @escaping (MovieModel) -> Void) {
//
//        let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate", method: .get)
//        request.responseDecodable(of: MovieModel.self) { response in
//
//            do {
//                let result = try response.result.get()
//                complitionHandler(result)
//            }
//            catch{
//                print("!!!!!!!!!\(error)")
//            }
//
//        }
//    }
//
    
//    func createResulTest( _ complitionaHandler: @escaping ([MoviesByGenre]) -> Void){
//
//        let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28&with_watch_monetization_types=flatrate", method: .get)
//        request.responseDecodable(of: MovieModel.self) { response in
//            do {
//                let result = try response.result.get().results
//                complitionaHandler(result)
//            }
//            catch{
//                print("!!!!!!!!!\(error)")
//            }
//
//        }
//    }
//    func useThis(_ idGenres: Int ,_ complitionaHandler: @escaping ([MoviesByGenre]) -> Void){
//        getGenres { arrayGenres in
//
//            let idGenres = arrayGenres.first?.id
//            let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(String(describing: idGenres))&with_watch_monetization_types=flatrate", method: .get)
//            request.responseDecodable(of: MovieModel.self) { response in
//                do {
//                    let result = try response.result.get().results
//                    complitionaHandler(result)
//                }
//                catch{
//                    print("!!!!!!!!!\(error)")
//                }
//
//            }
//
//
//        }
//
//
//
//
//    }
    
    // MARK: - Getting dictionary with key genres & value - top 20 movie
    func movieByGenres(_ complitionaHandler: @escaping ([String:[MoviesByGenre]])-> Void){
        getGenres { arrayGenre in
            var returnDictionary: [String:[MoviesByGenre]] = [:]
            for genre in arrayGenre{
                let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre.id)&with_watch_monetization_types=flatrate", method: .get)
                request.responseDecodable(of: MovieModel.self) { response in
                    do {
                        let result = try response.result.get().results
                            returnDictionary[genre.name] = result
                            complitionaHandler(returnDictionary)
                        
                    }
                    catch{
                         print("error movieByGenres \(error)")
                    }
                    
                }
                
            }
            
        }

    }
    
  
        
        
    
    
    
    
    
    
    
    
    
    
}
