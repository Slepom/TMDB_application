//
//  LaunchScreenViewController.swift
//  CourseProject
//
//  Created by Полина Жарова on 27.11.22.
//

import UIKit
import Lottie
class LaunchScreenViewController: ViewController {

    var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        animationView = .init(name: "circle")
        let size = self.view.frame.size.width
        animationView.bounds = CGRect(x: 0, y: 0, width: size/4, height: size/4)
        animationView.center = view.center
        animationView.play()
        view.addSubview(animationView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "signIn") as? ViewController else { print("signIn vc id not set"); return }
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    

   

}
