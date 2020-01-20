
import UIKit
import WebKit
import SafariServices

class WebViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openSafariVC()
    }
    
    func openSafariVC() {
        guard let url = url else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

