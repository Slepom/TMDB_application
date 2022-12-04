

import UIKit

class AuthenticationViewController: UIViewController {
    
    private let viewModel = AuthenticationVM()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkLabel: UILabel!
    
    
    @IBAction func buttonAction(_ sender: Any) {
        
        guard let userName = loginTextField.text, let password = passwordTextField.text else {return}
        
        viewModel.authentication(userName: userName, password: password) { status in
            
            print("1 \(status)")
            if status == true{
                print("2 \(status)")
                self.getSecondView()
            } else{
                print("3 \(status)")
                self.checkLabel.text = "Wrong password"
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let newButton = button else {return}
        newButton.alpha = 1
        loginTextField.delegate = self
        passwordTextField.delegate = self
        loginTextField.text = "Slepom"
        passwordTextField.text = "Leon103115"
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
    
//        func textFieldDidChangeSelection(_ textField: UITextField){
//                UIView.animate(withDuration: 4, delay: 0) {
//                    self.button.alpha = 1
//                }
//        }
    
}
