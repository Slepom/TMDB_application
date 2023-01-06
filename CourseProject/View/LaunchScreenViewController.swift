
import UIKit
import Lottie
class LaunchScreenViewController: AuthenticationViewController {

    var animationView: LottieAnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        createAnimation()
       transitionToSecondView()
      
        
    }
    
    // MARK: - Create lottie animation
    
    private func createAnimation(){
        animationView = .init(name: "circle")
        let size = self.view.frame.size.width
        animationView.bounds = CGRect(x: 0, y: 0, width: size/4, height: size/4)
        animationView.center = view.center
        animationView.play()
        view.addSubview(animationView)
    }
    
    // MARK: - create func transition to second View
    
    private func transitionToSecondView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "signIn") as? AuthenticationViewController else { print("signIn vc id not set"); return }
            self.present(controller, animated: true, completion: nil)
        }
    }

}
