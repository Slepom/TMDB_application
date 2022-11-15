

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkLabel: UILabel!
    
    
    @IBAction func buttonAction(_ sender: Any) {
        NetworkManager.shared.posttoken(userName: loginTextField.text ?? "" , password: passwordTextField.text ?? "") { checkAuthentication in
//             if checkAuthentication == true{
//                self.getSecondView()
//             }
            checkAuthentication == true ? self.getSecondView() : self.checkLabelFunck()
            
        }
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.alpha = 0
        checkLabel.text = " "
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    private func checkLabelFunck(){
        checkLabel.text = "Wrong password"
    }
    

    
    func getSecondView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBar")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
  
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        self.button.alpha = 1
        }
    }

}
