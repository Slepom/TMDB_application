

import UIKit

class ViewController: UIViewController {

    var viewModelButton = ViewModelButton()
    
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
        
    @IBOutlet weak var checkLabel: UILabel!
    
    @IBAction func buttonAction(_ sender: Any) {
        checkPasswordLogin()
        NetworkManager.shared.posttoken()
        getSecondView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLabel.text = " "
        bindViewModelButton()
        
    }
    
    
    
    // MARK: - binding VM and VC
    
    func bindViewModelButton(){
        viewModelButton.statusText.bind({ (statusText) in
            DispatchQueue.main.async{
                self.checkLabel.text = statusText

            }
            
        })
    }

    // MARK: - check login and password
    func checkPasswordLogin(){
        viewModelButton.checkSignUpButton(login: loginTextField.text ?? "", password: passwordTextField.text ?? " ")
    }
    
    func getSecondView(){
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
    }
    
}

