
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

class CustomRoundView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedCorner()
    }
    
    private func roundedCorner() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
