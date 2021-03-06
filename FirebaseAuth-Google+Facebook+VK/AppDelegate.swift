//
//  AppDelegate.swift
//  FirebaseAuth-Google+Facebook+VK
//
//  Created by User1 on 20.09.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import Firebase
import VK_ios_sdk

////import SwiftyVK



import GoogleSignIn
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate{
    
    var window: UIWindow?
    var databaseRef: DatabaseReference!
    
    static var checkerFG : Int = 0

    
    static var ref: DatabaseReference? = Database.database().reference()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
      
        
        FirebaseApp.configure()
        
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        
        if AppDelegate.checkerFG == 1{
            
            return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        }else{
            return true
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        switch AppDelegate.checkerFG {
        case 1: return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
            
        case 0 :   return GIDSignIn.sharedInstance().handle(url,
                                                            sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                            annotation: [:])
            
        default : VKSdk.processOpen(url as URL!, fromApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String)
        return true
            
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            print("Ошибка входа в Google аккаунт попробуйте попозже")
            //  displayAlertMessage(messageToDisplay: "Ошибка входа в Аккаунт Google попробуйте позже ", viewController: )
            return
        }
        //        print("user sign in google")
        
        guard let authentication = user.authentication else {  print("Ошибка входа в Google ")
            return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            
            
            print("user signed into firebase")
            
            
            //запись польз в Firebase и userdef
            if user?.email != nil && user?.uid != nil {
                
//                UsersFirebase.init().setUserData(userId: (user?.uid)!, userEmail: (user?.email)!)
//                UsersFirebase.init().readUserData(email: (user?.email)!)
//
                
                
                //для авто входа
//               / UserDefaults.standard.set(true, forKey:"remember")
                
                // Access the storyboard and fetch an instance of the view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ButtonVC")
                
                // Then push that view controller onto the navigation stack
                let rootViewController = self.window!.rootViewController as! UINavigationController
                rootViewController.pushViewController(viewController, animated: true)
                
                
            }else{
                print("Ошибка входа в Google аккаунт попробуйте попозже")
                
            }
            
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //выход из google
        
        let firebaseAuth = Auth.auth()
        do {
            print("выход из Google")
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            
            
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        // self.saveContext()
    }
    
    
}

