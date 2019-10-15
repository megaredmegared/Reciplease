
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup of the tabBar apearance
        tabBar.tintColor = .mainColor
        tabBar.unselectedItemTintColor = UIColor.contrastSecondColor
        tabBar.barTintColor = UIColor.secondColor
    }
}
