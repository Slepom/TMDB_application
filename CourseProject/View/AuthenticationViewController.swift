

import UIKit

class AuthenticationViewController: UIViewController {
    
    private let viewModel = AuthenticationVM()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkLabel: UILabel!
    
    
    
    // MARK: - Button action & registered user login
    
    @IBAction func buttonAction(_ sender: Any) {
        
        guard let userName = loginTextField.text, let password = passwordTextField.text else {return}
        
        viewModel.authentication(userName: userName, password: password) { status in
            
            if status == true{
                self.getSecondView()
            } else{
                self.checkLabelFunc()
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let newButton = button else {return}
        newButton.alpha = 0
    
        loginTextField.delegate = self
        passwordTextField.delegate = self

        //loginTextField.text = "Slepom"
        //passwordTextField.text = "Leon103115"
    }
    
    // MARK: - User verification function
    private func checkLabelFunc(){
        checkLabel.text = "Wrong password"
    }
    
    
    
    // MARK: - Transition to second View function
    
  private func getSecondView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBar")
        self.view.window?.rootViewController = vc
        self.view.window?.window?.makeKeyAndVisible()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}

// MARK: - Animation button

extension AuthenticationViewController: UITextFieldDelegate{
    
        func textFieldDidChangeSelection(_ textField: UITextField){
                UIView.animate(withDuration: 4, delay: 0) {
                    self.button.alpha = 1
                }
        }
    
}
