

import UIKit
import Alamofire

class AuthenticationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequest { token in
            let request = AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=6cde63f94256f35e302a61f1dd4b7524", method: .post, parameters: ["username": "Slepom", "password": "Leon103115", "request_token": token], encoding: JSONEncoding.default )
            request.responseDecodable(of: NetworkManager.self) { response in
                print(try? response.result.get().success)
               
 
            }
        }
        
    }
    
 
    
    func getRequest(_ complitionHandler: @escaping (String) -> Void){
        let apiKey = "6cde63f94256f35e302a61f1dd4b7524"
        let request = AF.request("https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)", method: .get)
        request.responseDecodable(of: NetworkManager.self) { response in
            
            do {
                let requestToken = try response.result.get().requestToken
                
                print(requestToken)
                complitionHandler(requestToken)
            }
            catch{
                print(error)
            }
        }
  
    }
 
    
    
    
    
}
