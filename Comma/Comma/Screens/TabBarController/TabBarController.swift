//
//  TabBarController.swift
//  Comma
//
//  Created by Period Sis. on 3/6/21.
//

import UIKit
import PTCardTabBar
import Foundation

class TabBarController: PTCardTabBarController {

    override func viewDidLoad() {
        
        let vc1 = ProductRecognitionVC()
        let vc2 = HomepageVC()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc3 = storyboard.instantiateViewController(withIdentifier: "main") as! ViewController
        
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "imagerec-icon"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Supply-Icon"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "learnmore-icon"), tag: 3)
        tintColor = .primaryMaroon
        selectedIndex = 2
        tabBarBackgroundColor = .white
        
        self.viewControllers = [vc1, vc2, vc3]
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
