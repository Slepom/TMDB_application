

import Foundation
import Alamofire
class AuthenticationVM{
    
    func authentication(userName: String, password: String, complitionHandler: @escaping (Bool) -> Void){
        
        NetworkManager.shared.getRequest { token in
            NetworkManager.shared.postSession(userName: userName, password: password, token: token) { status
                in
                //complitionHandler(status)
                print(status)
                NetworkManager.shared.createSession(requestToken: token) { session in
                    NetworkManager.shared.getAccountId(sessionId: session.sessionID) { account in
                        
                    }
                    complitionHandler(session.success)
                    
                }
            }
            
        }
        
        
    }
    
}
