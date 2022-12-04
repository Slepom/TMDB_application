

import UIKit

class AuthenticationViewController: UIViewController {
    
    private let viewModel = AuthenticationVM()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkLabel: UILabel!
    
    
    @IBAction func buttonAction(_ sender: Any) {
        
        guard let userName = loginTextField.text, let password = passwordTextField.text else {return}

//        NetworkManager.shared.posttoken(userName: userName, password: password) { checkAuthentication in
//          print("1111111111111 \(checkAuthentication)")
//            if checkAuthentication == true{
//                print("2222222222222 \(checkAuthentication)")
//                self.getSecondView()
//                self.checkLabel.text = "Wrong password"
//
//            } else{
//                print("3333333333333 \(checkAuthentication)")
//
//                //self.checkLabel.text = "Wrong password"
//            }
//////            checkAuthentication == true ? self.getSecondView() : self.checkLabelFunck()

        
        viewModel.authentication(userName: userName, password: password) { status in
         
            if status == true{
                self.getSecondView()
            } else{
                self.checkLabel.text = "Wrong password"
            }
        }
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let newButton = button else {return}
        newButton.alpha = 1
        //checkLabel.text = " "
        loginTextField.delegate = self
        passwordTextField.delegate = self
        //loginTextField.text = "Slepom"
        //passwordTextField.text = "Leon103115"
    }
    
    private func checkLabelFunck(){
        checkLabel.text = "Wrong password"
    }
    

    
    func getSecondView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBar")
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
      //  guard let controller = storyboard.instantiateViewController(withIdentifier: "second") as? ViewController else { print("signIn vc id not set"); return }
        self.view.window?.rootViewController = vc
        self.view.window?.window?.makeKeyAndVisible()
    }
  
}

extension AuthenticationViewController: UITextFieldDelegate{
    
//    func textFieldDidChangeSelection(_ textField: UITextField){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//        self.button.alpha = 1
//        }
//    }

}
