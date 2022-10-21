
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
                // print(error)
            }
        }
        
    }
    
    func createListMovie(_ complitionHandler: @escaping (MovieModel) -> Void) {
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=6cde63f94256f35e302a61f1dd4b7524&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate", method: .get)
        request.responseDecodable(of: MovieModel.self) { response in
            
            do {
                let result = try response.result.get()
                complitionHandler(result)
                //print("?????????????????????????????????????????\(result)")
            }
            catch{
                print("!!!!!!!!!\(error)")
            }
            
        }
    }
    
    
    func createResulTest( _ complitionaHandler: @escaping ([Result]) -> Void){
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=6cde63f94256f35e302a61f1dd4b7524&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28&with_watch_monetization_types=flatrate", method: .get)
        request.responseDecodable(of: MovieModel.self) { response in
            do {
                let result = try response.result.get().results
                complitionaHandler(result)
                //print("?????????????????????????????????????????\(result)")
            }
            catch{
                print("!!!!!!!!!\(error)")
            }
            
        }
}
    func useThis(_ idGenres: Int ,_ complitionaHandler: @escaping ([Result]) -> Void){
        getGenres { arrayGenres in

            let idGenres = arrayGenres.first?.id
            let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=6cde63f94256f35e302a61f1dd4b7524&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(String(describing: idGenres))&with_watch_monetization_types=flatrate", method: .get)
            request.responseDecodable(of: MovieModel.self) { response in
                do {
                    let result = try response.result.get().results
                    complitionaHandler(result)
                    print("-------------------------------------\(result)")
                }
                catch{
                    print("!!!!!!!!!\(error)")
                }
                
            }
//,msn,fknsd,mnfsdfkmnsa,fmnas,mfna,smnf,as
            //аыавфыав
            //аыфваыф/
            //фыаа
            
            
            
        }
        
        
        
        
    }
    
    func finalTest(_ complitionaHandler: @escaping ([Result])-> Void) -> [Genre:[Result]]{
        var returnDictionary: [Genre:[Result]] = [:]
        getGenres { arrayGenre in
            
            for (index,id) in arrayGenre.enumerated(){
                let request = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=6cde63f94256f35e302a61f1dd4b7524&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(String(describing: id.id))&with_watch_monetization_types=flatrate", method: .get)
                request.responseDecodable(of: MovieModel.self) { response in
                    do {
                        let result = try response.result.get().results
                        complitionaHandler(result)
                        returnDictionary[arrayGenre[index]] = result
                        print("---------\(id.id)----------------------------\(result)")
                    }
                    catch{
                        print("!!!!!!!!!\(error)")
                    }
                    
                }
                
            }
          
        }
        
        return returnDictionary
    }
    
    
    
    
    
    
   
}
