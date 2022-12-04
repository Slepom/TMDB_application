
import Foundation
import Alamofire
class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){}
    
    
    // MARK: - Getting request_token
    func getRequest(_ complitionHandler: @escaping (String) -> Void){
        
        let request = AF.request(url_api, method: .get)
        request.responseDecodable(of: TokenModel.self) { response in
            
            do {
                let requestToken = try response.result.get().requestToken
                
                // print(requestToken)
                complitionHandler(requestToken)
            }
            catch{
                print("Error getting token \(error)")
            }
        }
        
    }
    
    
    // MARK: - Getting session request with login & password
    
    func postSession(userName: String, password: String, token: String, complitionHandler: @escaping (Bool)->Void){
        let requestPost = AF.request(url_login, method: .post, parameters: ["username": userName, "password": password, "request_token": token], encoding: JSONEncoding.default )
        requestPost.responseDecodable(of: TokenModel.self) { response in
            do {
                let postSuccess = try response.result.get().success
                complitionHandler(postSuccess)
            } catch{
                print("Error posting session \(error)")
            }
        }
        
    }
    
    // MARK: - Creating new session
    
    func createSession(requestToken: String, completion: @escaping (SessionModel) -> Void){
        
        let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)", method: .post, parameters: ["request_token": requestToken], encoding: JSONEncoding.default)
        genresRequest.responseDecodable(of: SessionModel.self) { response in
            do {
                let data = try response.result.get()
                
                globalValueSessionId = data.sessionID
                completion(data)
            }
            catch {
                print("Error new session \(error)")
            }
        }
    }
    
    // MARK: - Getting account id
    
    func getAccountId(sessionId: String, completion: @escaping (String) -> Void) {
        
        let genresRequest = AF.request("https://api.themoviedb.org/3/account?api_key=\(apiKey)&session_id=\(sessionId)", method: .get)
        genresRequest.responseDecodable(of: DetailsAccountModel.self) { response in
            do {
                let idAccount = try response.result.get().id
                globalValueIdAccount = idAccount
            }
            catch {
                print("Error new account id \(error)")
            }
        }
    }
    
    // MARK: - Delete session
    
    func deleteSession(sessionId: String) {
        let parameters: [String: Any] = [
            "session_id": sessionId
        ]
        let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/session?api_key=\(apiKey)", method: .delete, parameters: parameters, encoding: JSONEncoding.default)
        genresRequest.responseDecodable(of: SessionResponce.self) { response in
            do {
                let data = try response.result.get()
                print(data.success)
            }
            catch {
                print("Error new delete session \(error)")
            }
        }
    }
    
  
}

