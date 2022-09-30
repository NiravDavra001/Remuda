//
//  AppDelegate.swift
//  remuda
//
//  Created by mac on 31/03/21.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import GooglePlaces
import AWSCognito
import AWSS3
var appKeyWindow : UIWindow? {
    if #available(iOS 13, *) {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    } else {
        return UIApplication.shared.keyWindow
    }
}
@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        FirebaseApp.configure()
        //MARK:- for In-App purchase.
        IAPManager.shared.fetchProductIdentifiers()
        
        NetworkStatus.shared.startNetworkReachabilityObserver()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        ApplicationDelegate.initializeSDK(nil)
        GIDSignIn.sharedInstance().clientID = "831360111538-e24pu7hemom76j2dm0r3jnpjsg7g7210.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GMSPlacesClient.provideAPIKey("AIzaSyBqEYzXwCdPsQbxw-0xOlg3k6dFzQHuga0")
        initializeAWSS3()
        return true
    }
    //MARK:- AWS credebtialProvider
    func initializeAWSS3() {
        let poolId = "us-east-2:4246d5bf-6de7-4a1d-bb97-336d28b3117b"
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast2, identityPoolId: poolId)
        let configuration = AWSServiceConfiguration(region: .USEast2, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {   
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
   


}
