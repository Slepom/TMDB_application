
import Foundation
import Alamofire

class GettingData{
    
    static let shared = GettingData()
    
    private init(){}
    
    
    var networkDictionary: [Genre:[MoviesByGenre]] = [:]
    
    
    func getGenres(_ complitionHandler: @escaping ([Genre]) -> Void){
        
        let request = AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US", method: .get)
        request.responseDecodable(of: GenreModel.self) { response in
            
            do {
                let genres = try response.result.get().genres
                
                //print(genres)
                complitionHandler(genres)
            }
            catch{
//                 print(error)
            }
        }
        
    }
    
    func createListMovie(_ complitionHandler: @escaping (MovieModel) -> Void) {
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate", method: .get)
        request.responseDecodable(of: MovieModel.self) { response in
            
            do {
                let result = try response.result.get()
                complitionHandler(result)
                //print("?????????????????????????????????????????\(result)")
            }
            catch{
                // print("!!!!!!!!!\(error)")
            }
            
        }
    }
    
    
    func createResulTest( _ complitionaHandler: @escaping ([MoviesByGenre]) -> Void){
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28&with_watch_monetization_types=flatrate", method: .get)
        request.responseDecodable(of: MovieModel.self) { response in
            do {
                let result = try response.result.get().results
                complitionaHandler(result)
                //print("?????????????????????????????????????????\(result)")
            }
            catch{
                //print("!!!!!!!!!\(error)")
            }
            
        }
    }
    func useThis(_ idGenres: Int ,_ complitionaHandler: @escaping ([MoviesByGenre]) -> Void){
        getGenres { arrayGenres in
            
            let idGenres = arrayGenres.first?.id
            let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(String(describing: idGenres))&with_watch_monetization_types=flatrate", method: .get)
            request.responseDecodable(of: MovieModel.self) { response in
                do {
                    let result = try response.result.get().results
                    complitionaHandler(result)
                    //print("-------------------------------------\(result)")
                }
                catch{
                    print("!!!!!!!!!\(error)")
                }
                
            }
            
            
        }
        
        
        
        
    }
    
    func finalTest(_ complitionaHandler: @escaping ([String:[MoviesByGenre]])-> Void){
        getGenres { arrayGenre in
            var returnDictionary: [String:[MoviesByGenre]] = [:]
            for genre in arrayGenre{
                let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre.id)&with_watch_monetization_types=flatrate", method: .get)
                request.responseDecodable(of: MovieModel.self) { response in
                    do {
                        let result = try response.result.get().results
                            returnDictionary[genre.name] = result
                            complitionaHandler(returnDictionary)
                        
//                        returnDictionary[genre] = result
//                        complitionaHandler(returnDictionary)
                        //print("---------\(genre.name)----------------------------\(result)")
                    }
                    catch{
                         print("!!!!!!!!!\(error)")
                    }
                    
                }
                
            }
            
        }

    }
    
  
        
        
    
    
    
    
    
    
    
    
    
    
}
