
import Foundation
import Alamofire
class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){}
    
    
    // MARK: - get request_token
    func getRequest(_ complitionHandler: @escaping (String) -> Void){
        
        let request = AF.request(url_api, method: .get)
        request.responseDecodable(of: TokenModel.self) { response in
            
            do {
                let requestToken = try response.result.get().requestToken
                
               // print(requestToken)
                complitionHandler(requestToken)
            }
            catch{
                print(error)
            }
        }
        
    }
    
    
    // MARK: - authentication with lohin & password
    
    func posttoken(){
        
        //var sessionIdNew = ""
        getRequest { token in
            let requestPost = AF.request(url_login, method: .post, parameters: ["username": User.logins[0].login ?? "", "password": User.logins[0].password ?? "", "request_token": token], encoding: JSONEncoding.default )
            requestPost.responseDecodable(of: TokenModel.self) { response in
                do {
                    
                    let postSuccess = try response.result.get().success
                    print("POST request is = \(postSuccess)")
                    
                    // MARK: - get session_id
                    let requestPostSession = AF.request(url_session, method: .post, parameters: ["request_token": token], encoding: JSONEncoding.default)
                    requestPostSession.responseDecodable(of: SessionModel.self) { response in
                        do {
                            let sessionId = try response.result.get().sessionID
                            globalValueSessionId = sessionId
                           print("Session_id is \(sessionId)")
                            let requestDetails = AF.request("https://api.themoviedb.org/3/account?api_key=6cde63f94256f35e302a61f1dd4b7524&session_id=\(sessionId)", method: .get, encoding: JSONEncoding.default)
                            requestDetails.responseDecodable(of: DetailsAccountModel.self) { response in
                                
                                do {
                                    let idAccount = try response.result.get().id
                                    globalValueIdAccount = idAccount
                                   print("account id is \(idAccount)")
                                    
                                    
                                } catch {
                                    print(error)
                                }
                                
                                
                            }
                        }
                        catch {
                            print(error)
                        }
                        
                    }
                    
                    
                    
                    
                }
                catch {
                    print(error)
                }
                
            }
            
            
            
            
        }
        
    }
    
    
    
    
}

