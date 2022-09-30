//
//  SceneDelegate.swift
//  remuda
//
//  Created by mac on 31/03/21.
//

import UIKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    static let shared = SceneDelegate()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let urlContext = connectionOptions.urlContexts.first {
            let sendingAppID = urlContext.options.sourceApplication
            let url = urlContext.url
            print("source application = \(sendingAppID ?? "Unknown")")
            print("url = \(url)")
            deepLink(url: url)
        }else{
            guard let _ = (scene as? UIWindowScene) else { return }
            
            
            self.setUpRootViewController()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        self.checkAppVersion()
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            deepLink(url: url)
        }
    }
    
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        print("Continue User Activity called: ")
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let url = userActivity.webpageURL!
            print(url.absoluteString)
            //handle url and open whatever page you want to open.
        }
        return true
    }
   
    //MARK:-  //MARK:- This methode for check App version latest or not
    func checkAppVersion(){
        
        let version : String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"]   as? String
        NetworkManager.share.getVersionApp { (result) in
            switch result{
            case .success(let resData) :
                print("versionData  ---->",resData)
                if resData.data != version{
                    UserDefaultManager.share.setBoolUserDefaultValue(value: false, key: .isVersionUpadted)
                    appKeyWindow?.rootViewController?.present(self.goToHomeAlert("Please update App before use.", Title: "Ok"), animated: true, completion: nil)
                }else{
                    UserDefaultManager.share.setBoolUserDefaultValue(value: true, key: .isVersionUpadted)
                }
            case .failure(let err) :
                appKeyWindow?.rootViewController?.showAlert(message: err.localizedDescription)
            //return
            }
        }
    }
    //MARK:- popUp open for update App
    func goToHomeAlert(_ msg: String, Title: String) -> UIAlertController{
        
        let alert = UIAlertController(title: "Remuda", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Title, style: UIAlertAction.Style.default, handler: { (alert) in
            UserDefaultManager.share.clearAllUserDataAndModel()
            UserDefaultManager.share.removeUserDefualtsModels(key: .storePreviousSearch)
            let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Main.rawValue, bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.mainVC.rawValue)
            let navContller = UINavigationController(rootViewController: homeViewController)
            sceneDelegate?.window?.rootViewController = navContller
            sceneDelegate?.window?.makeKeyAndVisible()
        }))
        
        return alert
    }
    func setTabBarControllerAsRootViewController() {
        let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Home.rawValue, bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.TabBarController.rawValue)
        let navContller = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navContller
        window?.makeKeyAndVisible()
    }
    func setMainViewControllerRootViewController() {
        let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Main.rawValue, bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.mainVC.rawValue)
        let navContller = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navContller
        window?.makeKeyAndVisible()
    }
    func setPersonalInformationAsRootViewController(){
        let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Profile.rawValue, bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.ProfileInformationVC.rawValue)
        let navContller = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navContller
        window?.makeKeyAndVisible()
    }
    func setUpRootViewController(){
        if (UserDefaultManager.share.getBoolUserDefaultValue(key: .isUserLogin))
        {
            if isValidProfile(){
                setTabBarControllerAsRootViewController()
            }else{
                setPersonalInformationAsRootViewController()
            }
        }else{
            setMainViewControllerRootViewController()
        }
    }
    func deepLink(url: URL) {
        
        print(url)
        let urlString = url.absoluteString
        let component = urlString.components(separatedBy: "/")
        print(component)
        if (UserDefaultManager.share.getBoolUserDefaultValue(key: .isUserLogin))
        {
            let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Home.rawValue, bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.TabBarController.rawValue) as! TabBarController
            
            if component.count > 1, let product = component.last {
                switch component[3] {
                case "home-posts":
                    homeViewController.setSelectedIndex = 0
                    homeViewController.postId = Int(product) ?? 0
                case "horse":
                    homeViewController.setSelectedIndex = 1
                    homeViewController.categoryId = Int(product) ?? 0
                    homeViewController.categoryName = .horse
                case "equipmment":
                    homeViewController.setSelectedIndex = 1
                    homeViewController.categoryId = Int(product) ?? 0
                    homeViewController.categoryName = .equipmment
                case "tack":
                    homeViewController.setSelectedIndex = 1
                    homeViewController.categoryId = Int(product) ?? 0
                    homeViewController.categoryName = .tack
                default:
                    break
                }
            }
            let navContller = UINavigationController(rootViewController: homeViewController)
            window?.rootViewController = navContller
            window?.makeKeyAndVisible()
        }
        else
        {
            setMainViewControllerRootViewController()
        }
        
    }
}
