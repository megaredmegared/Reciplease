//
//  DetailsView.swift
//  Reciplease
//
//  Created by megared on 01/10/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

protocol ButtonActionDelegate {
    func triggerWebButton(sender: UIButton)
}

@IBDesignable
class DetailsView: UIView {
    
    let nibName = "DetailsView"
    var contentView: UIView?
    var delegate: ButtonActionDelegate?
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeIngredientsList: UITextView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    @IBAction func triggerWebButton(_ sender: UIButton) {
        self.delegate?.triggerWebButton(sender: sender)
    }
    
}
