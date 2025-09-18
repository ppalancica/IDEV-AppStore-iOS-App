import UIKit

final class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tabBar.tintColor = .orange
        // tabBar.barTintColor = .gray
        
        viewControllers = [
            createNavigationController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavigationController(viewController: AppsController(), title: "Apps", imageName: "apps"),
            createNavigationController(viewController: AppsSearchController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavigationController(viewController vc: UIViewController,
                                                title: String,
                                                imageName: String) -> UIViewController {
        
        let nc = UINavigationController(rootViewController: vc)
        
        nc.navigationBar.prefersLargeTitles = true
        nc.tabBarItem.title = title
        nc.tabBarItem.image = UIImage(named: imageName)
        
        vc.navigationItem.title = title
        vc.view.backgroundColor = .white
        
        return nc
    }
}
