

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
    
    // MARK: - add Navigarion & TabBar controllers
    
    func createNavigation(){
        let tabBarVc = UITabBarController()
        //        let vc1 = UINavigationController(rootViewController: SecondViewController())
        //        let vc2 = UINavigationController(rootViewController: DetailsViewController())
        //        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc1 = SecondViewController()
        let vc2 = DetailsViewController()
        let vc3 = SearchViewController()
        vc1.title = " "
        vc2.title = " "
        vc3.title = " "
        tabBarVc.setViewControllers([vc1,vc2,vc3 ], animated: false)
        guard let items = tabBarVc.tabBar.items else{return}
        
        let images = ["house", "movie", "search"]
        for namePictures in 0..<images.count{
            items[namePictures].image = UIImage(systemName: images[namePictures])
        }
        
        tabBarVc.modalPresentationStyle = .fullScreen
        present(tabBarVc, animated: true)
    }
    
    
    
}

