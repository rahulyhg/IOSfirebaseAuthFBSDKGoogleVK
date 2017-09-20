//
//  HomeSignInViewController.swift
//  MyDok
//
//  Created by User1 on 20.09.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import VK_ios_sdk

class HomeSignInViewController: UIViewController ,GIDSignInUIDelegate,VKSdkDelegate, VKSdkUIDelegate {
    
    
    @IBOutlet weak var labelAppName: UILabel!
    
    //!!!!! VK Auth
    private var accessToken : VKAccessToken?
    private let appId: String = "6169895"
    private var scope: [Any]? = nil
    
    //!!!!!!!!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        //google
        GIDSignIn.sharedInstance().uiDelegate = self
  
        
//        //   sign in автоматом
//
//        if (UserDefaults.standard.bool(forKey: "remember") && UserDefaults.standard.string(forKey: "userId") != "") {
//
//
//            performSegue(withIdentifier: "buttonView", sender: "")
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
               VKSdk.initialize(withAppId: appId).register(self)
        VKSdk.instance().uiDelegate = self
        VKSdk.instance().register(self)
        
            }
    
    
    @IBAction func vKButton(_ sender: UIButton) {
        
       
        AppDelegate.checkerFG = 3
        scope = [VK_PER_FRIENDS, VK_PER_EMAIL]
        VKSdk.authorize(scope)
           }
    
    
    // MARK: - VKSdkDelegate, VKSdkUIDelegate//  при успеш авторизац
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        let vkUserEmail =  "vk" + result.token.email
        let vkUserPass =  result.token.userId
        if (result.token != nil) {
            
            
            //regisration in Firebase Firabase.google.com
            Auth.auth().createUser(withEmail: vkUserEmail, password: vkUserPass! , completion:  { (user, error) in
                //check that user not nil
                if (user != nil) {
                    
                    
                    // save email+ pass in Firebase Users and UserDefault
                  //  UsersFirebase.init().setUserData(userId : (user?.uid)! , profession: "", placeOfWork: "", userEmail: result.token.email , name: "", surname: "", phone: "", yearB : "")
                    
                    //для авто входа
                 //   UserDefaults.standard.set(true, forKey:"remember")
                    
                    //!!!!!!!переходит на основную страницу!!!!!!!!!!!
                    self.performSegue(withIdentifier: "buttonView", sender: self)
                    
                 
                }
                else {
                    
                    //                      //signin in Firebase.google.com
                    Auth.auth().signIn(withEmail: vkUserEmail, password: vkUserPass!, completion: { (user, error) in
                        
                        if user != nil {
                            
                            
                            //  !!!!!!!переходит на основную страницу!!!!!!!!!!!
                            self.performSegue(withIdentifier: "buttonView", sender: self)
                            
                            
                        }
                        else{
                            //error: check error and show message
                            displayAlertMessage(messageToDisplay: "Неудачная попытка авторизации попробуйте еще раз", viewController: self)
                            
                            
                        }
                     //   stopActivityIndicator()
                    
                    })//            END          //signin in Firebase.google.com
                    
                }
            })
            
        }
        
    }
    
    
    func vkSdkUserAuthorizationFailed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //  авториз через safari
    func vkSdkShouldPresent(_ controller: UIViewController) {
                present(controller, animated: true, completion: nil)
        
    }
    //
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        let vc = try? VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: navigationController?.topViewController)
    }
    
    
    //    func vkSdkAcceptedUserToken(token: VKAccessToken!) {
    //        print("ACCEPTED", appendNewline: true)
    //    }
    //    var uid = "some-uid";
    //    var customToken = firebase.auth().createCustomToken(uid);
    //!!!!!!!!!!
    
    
    
    
    
    
    
    
    
    @IBAction func signInGoogleButton(_ sender: Any) {
        let signIn = GIDSignIn.sharedInstance()
        signIn?.signOut()
        signIn?.signIn()
    }
    
    @IBAction func facebookButton(_ sender: AnyObject) {
      //  startActivityIndicator(viewController: self)
        
        AppDelegate.checkerFG = 1
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (facebookResult, facebookError) in
            if facebookError != nil {
                
//                displayAlertMessage(messageToDisplay: "There was an error logging in to Facebook. Error: \(facebookError)", viewController: self)
            } else
                if (facebookResult?.isCancelled)!
                {
                    print("Facebook login was cancelled!")
                }
                else {
                    // self.startActivityIndicator()
                    
                    let credential = (FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString))
                    
                    //signin in Firebase
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                        print("user signed into firebase")
                        if user != nil{
                            //запись польз в Firebase и userdef
                            if user?.email != nil && user?.uid != nil {
                                
//                                UsersFirebase.init().setUserData(userId: (user?.uid)!, userEmail: (user?.email)!)
//                                UsersFirebase.init().readUserData(email: (user?.email)!)
                            }
//                            //для авто входа
//                            UserDefaults.standard.set(true, forKey:"remember")
                            
                            //  !!!!!!!переходит на основную страницу!!!!!!!!!!!
                            self.performSegue(withIdentifier: "buttonView", sender: self)
//                            stopActivityIndicator()
                            
                        }else{
                            //error: check error and show message
                            displayAlertMessage(messageToDisplay: "Проверьте подключение к интернету ", viewController: self )
                            
                        }
                    })
            }
        }
    }
    
    
    
    
    
}
