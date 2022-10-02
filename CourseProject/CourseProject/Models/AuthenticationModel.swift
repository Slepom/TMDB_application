

import Foundation

struct AuthenticationModel{
    
    var userLogin = User.logins
    let apiKey = "6cde63f94256f35e302a61f1dd4b7524"
    let base_url = "https://api.themoviedb.org/3/authentication/token/"
    let url_api = "new?api_key="
    let url_logIn = "validate_with_login?"
}

