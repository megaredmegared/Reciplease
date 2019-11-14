
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
