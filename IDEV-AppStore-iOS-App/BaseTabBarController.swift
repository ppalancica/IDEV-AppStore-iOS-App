import UIKit

final class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redVC = UIViewController()
        // redVC.view.backgroundColor = .red
        redVC.navigationItem.title = "Apps"
        
        let redNC = UINavigationController(rootViewController: redVC)
        redNC.tabBarItem.title = "Apps"
        redNC.tabBarItem.image = UIImage(named: "apps")
        redNC.navigationBar.prefersLargeTitles = true
        
        let blueVC = UIViewController()
        // blueVC.view.backgroundColor = .blue
        blueVC.navigationItem.title = "Search"
        
        let blueNC = UINavigationController(rootViewController: blueVC)
        blueNC.tabBarItem.title = "Search"
        blueNC.tabBarItem.image = UIImage(named: "search")
        blueNC.navigationBar.prefersLargeTitles = true
        
        // tabBar.tintColor = .orange
        // tabBar.barTintColor = .gray
        
        viewControllers = [
            redNC,
            blueNC
        ]
    }
}
