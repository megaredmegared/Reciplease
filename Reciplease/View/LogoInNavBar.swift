//
//  LogoInNavBar.swift
//  Reciplease
//
//  Created by megared on 04/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import UIKit

func LogoInNavBar() {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    imageView.contentMode = .scaleAspectFit
    
    // 4
    let image = UIImage(named: "logoReciplease")
    imageView.image = image
    
    // 5
    //navigationItem.titleView = imageView
}
