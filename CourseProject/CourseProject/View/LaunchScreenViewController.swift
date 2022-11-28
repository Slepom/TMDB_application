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

        animationView = .init(name: "movie")
        animationView?.frame = view.bounds
        view.addSubview(animationView)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            
//        }
        
    }
    

   

}
