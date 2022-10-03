

import UIKit
import Alamofire

class AuthenticationViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posttoken()
        
    }
    
    
    
    func getRequest(_ complitionHandler: @escaping (String) -> Void){
        
        let apiKey = "6cde63f94256f35e302a61f1dd4b7524"
        let request = AF.request("https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)", method: .get)
        request.responseDecodable(of: TokenModel.self) { response in
            
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
    
    
    func posttoken(){
        //let dispatch = DispatchGroup()
       // dispatch.enter()
        getRequest { token in
            let requestPost = AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=6cde63f94256f35e302a61f1dd4b7524", method: .post, parameters: ["username": "Slepom", "password": "Leon103115", "request_token": token], encoding: JSONEncoding.default )
            requestPost.responseDecodable(of: TokenModel.self) { response in
                do {
                    //let statusPost = try response.result.get().success
                    let requestTokenAffterPost = try response.result.get().requestToken
                    print("request token affter POST = \(requestTokenAffterPost)")
                    
                    let requestGet = AF.request("https://api.themoviedb.org/3/authentication/session/new?api_key=6cde63f94256f35e302a61f1dd4b7524", method: .post, parameters: ["request_token": token], encoding: JSONEncoding.default)
                    requestGet.responseDecodable(of: SessionModel.self) { response in
                        do {
                            let sessionId = try response.result.get().sessionID
                            print("!!!!!!!!!!!!!!!!! \(sessionId)")
                        }
                        catch {
                            print("?????????????????????\(error)")
                        }
                    }
                    
                    
                }
                catch {
                    print(error)
                }
                //dispatch.leave()
            }

            //dispatch.wait()
            
      
            
        }
        
    }
    
    //        func getSession(){
    //
    //            getRequest { token in
    //
    //                let request = AF.request("https://api.themoviedb.org/3/authentication/session/new?api_key=6cde63f94256f35e302a61f1dd4b7524", method: .get, parameters: ["request_token": token], encoding: JSONEncoding.default)
    //                request.responseDecodable(of: SessionModel.self) { response in
    //                    do {
    //                        let sessionId = try response.result.get().sessionID
    //                        print("!!!!!!!!!!!!!!!!! \(sessionId)")
    //                    }
    //                    catch {
    //                        print("?????????????????????\(error)")
    //                    }
    //                }
    //
    //
    //
    //            }
    //
    //        }
    
    
}
