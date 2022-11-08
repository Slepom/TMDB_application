//
//  TabBarViewController.swift
//  CourseProject
//
//  Created by Полина Жарова on 8.11.22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let secondVC = SecondViewController()
        let searchVC = SearchViewController()
        let watchListVC = WatchListViewController()
        self.setViewControllers([secondVC, searchVC, watchListVC], animated: false)
        
    }
    

   

}
