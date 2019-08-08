//
//  CustomButton.swift
//  Reciplease
//
//  Created by megared on 08/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        roundedCorner()
    }
    
    private func roundedCorner() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}
