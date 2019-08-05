//
//  TabBarViewController.swift
//  Reciplease
//
//  Created by megared on 04/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    @IBOutlet var customTabBarView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBarView.frame.size.width = self.view.frame.width
        customTabBarView.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 50)
        self.view.addSubview(customTabBarView)
        //customTabBarView.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 50)
   
        searchButton.setTitleColor(#colorLiteral(red: 0.2078431373, green: 0.8431372549, blue: 0.003921568627, alpha: 1), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeTab(_ sender: UIButton) {
        self.selectedIndex = sender.tag
        if sender.tag == 0 {
            searchButton.setTitleColor(#colorLiteral(red: 0.2078431373, green: 0.8431372549, blue: 0.003921568627, alpha: 1), for: .normal)
            favoriteButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        } else {
            favoriteButton.setTitleColor(#colorLiteral(red: 0.2078431373, green: 0.8431372549, blue: 0.003921568627, alpha: 1), for: .normal)
            searchButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        }
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
