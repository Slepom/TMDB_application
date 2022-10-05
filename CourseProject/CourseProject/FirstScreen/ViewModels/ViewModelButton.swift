

import Foundation
import UIKit.UIColor

class ViewModelButton{
    var statusText = BindingButton("")
    var statusLogin = BindingButton(true)
    func checkSignUpButton(login: String, password: String){
        if login != User.logins[0].login || password != User.logins[0].password{
            statusText.newValue = "Wrong login oro password."
            statusLogin.newValue = false
        } else {
            statusText.newValue = "You successfully logged in."
        }
    }
}

