import UIKit

final class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayVC = UIViewController()
        todayVC.view.backgroundColor = .white
        todayVC.navigationItem.title = "Today"
        
        let todayNC = UINavigationController(rootViewController: todayVC)
        todayNC.tabBarItem.title = "Today"
        todayNC.tabBarItem.image = UIImage(named: "today_icon")
        todayNC.navigationBar.prefersLargeTitles = true
        
        let redVC = UIViewController()
        redVC.view.backgroundColor = .white
        redVC.navigationItem.title = "Apps"
        
        let redNC = UINavigationController(rootViewController: redVC)
        redNC.tabBarItem.title = "Apps"
        redNC.tabBarItem.image = UIImage(named: "apps")
        redNC.navigationBar.prefersLargeTitles = true
        
        let blueVC = UIViewController()
        blueVC.view.backgroundColor = .white
        blueVC.navigationItem.title = "Search"
        
        let blueNC = UINavigationController(rootViewController: blueVC)
        blueNC.tabBarItem.title = "Search"
        blueNC.tabBarItem.image = UIImage(named: "search")
        blueNC.navigationBar.prefersLargeTitles = true
        
        // tabBar.tintColor = .orange
        // tabBar.barTintColor = .gray
        
        viewControllers = [
            todayNC,
            redNC,
            blueNC
        ]
    }
}
