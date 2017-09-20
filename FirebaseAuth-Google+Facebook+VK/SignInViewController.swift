//
//  SignInViewController.swift
//  MyDok
//
//  Created by User1 on 20.09.17.
//  Copyright © 2017 User1. All rights reserved.//

import UIKit
import FirebaseAuth
import Firebase


class SignInViewController: UIViewController, UITextFieldDelegate {
    
  
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    //для убирания клавы с экрана/////////
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        
//        if (UserDefaults.standard.bool(forKey: "remember") && UserDefaults.standard.string(forKey: "userId") != "") {
//            performSegue(withIdentifier: "diagnosisZone", sender: "")
//        }
        
    }
    
    
    //для убирания клавы с экрана/////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
        return true
    }
    /////////--------//////
    
    
    @IBAction func okButton(_ sender: UIButton) {
      //  startActivityIndicator(viewController: self)
        
        
      
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        
        // FIRAuth.auth()?.signOut()throws
        
        
        //signin in Firebase.google.com
        Auth.auth().signIn(withEmail: userEmail!, password: userPassword!, completion: { (user, error) in
            
            if user != nil {
                
//                //для авто входа
//                UserDefaults.standard.set(true, forKey:"remember")
                
//                //1 чтение данных польз из firebase и сразу запись в userdefault
//                UsersFirebase.init().readUserData(email: userEmail!)
                
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                //  !!!!!!!переходит на основную страницу!!!!!!!!!!!
                self.performSegue(withIdentifier: "buttonView", sender: self)
                
                
            }
            else{
                //error: check error and show message
                displayAlertMessage(messageToDisplay: "Не правильный пароль или логин ", viewController: self )
                
            }
           // stopActivityIndicator()
        })
        
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        //dismiss(animated: true, completion: nil)
    }
    @IBAction func forgetPassButton(_ sender: UIButton) {
        
        //восстановдение пароля send user reset password on email
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!, completion: { (error) in
            if error != nil{
                displayAlertMessage(messageToDisplay: "Заполните правильно поле E-mail ", viewController: self )
            }
            else{
                displayAlertMessage(messageToDisplay: "Инструкция для сброса пароля отправлена на \(self.emailTextField.text!)", viewController: self )
            }
        })
          }
    
}
