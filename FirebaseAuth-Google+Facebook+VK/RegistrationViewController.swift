//
//  RegistrationViewController.swift
//  MyDok
//
//  Created by User1 on 20.09.17.
//  Copyright © 2017 User1. All rights reserved.//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController , UITextFieldDelegate{
    
    
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var acceptOkB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
              
        //для убирания клавы с экрана/////////
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        self.rePasswordTextField.delegate = self
        
        
        self.navigationItem.setHidesBackButton(true, animated:true)
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

    @IBAction func okButton(_ sender: Any) {
        
        
        
        if acceptOkB.alpha == 1  {
           displayAlertMessage(messageToDisplay: "Нажмите на согласие с правилами", viewController: self)
          

            return
        }
        //
        let userPassword = passwordTextField.text!
        
        let email = emailTextField.text!.lowercased()//приводит все к нижнему регистру
        
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)//убирает лишние пробелы и абзацы
        
        let isEmailAddresValid = isValidEmailAddress(emailAddressString: finalEmail)
        guard isEmailAddresValid else{
            displayAlertMessage(messageToDisplay: "Email addres is not valid",viewController: self)
            return
        }
        //проверка на идентичность паролей
        guard (passwordTextField.text == rePasswordTextField.text) else{
            displayAlertMessage(messageToDisplay: "Не совпадение пароля",viewController: self)
            return
        }
        // провеока на count  симв в пароле for Firebase
        guard (passwordTextField.text?.characters.count)! > 5 else{
            displayAlertMessage(messageToDisplay: "Пароль должен быть более 6 символов", viewController: self)
            return
        }
     //   startActivityIndicator(viewController: self)
        
        //regisration in Firebase Firabase.google.com
        Auth.auth().createUser(withEmail: finalEmail, password: userPassword, completion:  { (user, error) in
            //check that user not nil
            if (user != nil) {
                
                //обнуление userDefault
          //      UserDefD.init().emptyUserData()
                
//                UserDefD.init().saveUserDataUD(userId: "", userEmail: "", profession: "", placeOfWork: "", phone: "", name: "", surname: "", yearB: "")
//                UserDefD.init().saveUserImgUD(img: "")
                
                
//                // save email+ pass in Firebase Users and UserDefault
//                UsersFirebase.init().setUserData(userId : (user?.uid)! , profession: "", placeOfWork: "", userEmail: finalEmail , name: "", surname: "", phone: "", yearB : "")
                
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.rePasswordTextField.text = ""
                
                //!!!!!!!переходит на основную страницу!!!!!!!!!!!
                self.performSegue(withIdentifier: "buttonView", sender: self)
                
            //    stopActivityIndicator()
            }
            else {
                //error: check error and show mess
                displayAlertMessage(messageToDisplay: "Такой пользователь уже есть" , viewController: self)
            }
        })
        
    }
    
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
      
    }
    
    
    @IBAction func acceptOkButton(_ sender: UIButton) {
        //        var myActionSheet = UIAlertController(title: "Пользовательское соглашение", message: "текст пользовательского соглашения", preferredStyle: UIAlertControllerStyle.ActionSheet)
        //        let acceptDogovorAction = UIA
        displayActionSheet(self, acceptOkB)
        
        
        
    }
    
    
    
    
    
}



