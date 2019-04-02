//
//  RegisterViewController.swift
//  AutomotiveAesthetics
//
//  Created by Kevin Rama on 3/7/19.
//  Copyright © 2019 Kevin Rama. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn
import FirebaseStorage;


var name: String = "";
var phone: String = "";


class RegisterViewController: UIViewController, GIDSignInUIDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var ref = DatabaseReference();
    var register = false;
    
    @IBOutlet weak var picLabel: UILabel!
    @IBOutlet weak var FName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ReEnterPassword: UITextField!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    
    
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        if FName.text != "" &&  Email.text != "" && phoneNumber.text != "" && Password.text != "" && ReEnterPassword.text != ""
        {
            if(Password.text == ReEnterPassword.text)
            {
                
                Auth.auth().createUser(withEmail: Email.text!, password: Password.text!) { (user, error) in
                    
                    if error != nil
                    {
                        
                        print(error?.localizedDescription as Any);
                        
                        let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .actionSheet);
                        
                        let doNun = UIAlertAction(title: "OK", style: .default, handler: nil);
                        let recover = UIAlertAction(title: "Recover Password", style: .default, handler: { (recovery) in
                            Auth.auth().sendPasswordReset(withEmail: self.Email.text!, completion: { (error) in
                                if error != nil {
                                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert);
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                                    self.present(alert, animated: true, completion: nil);
                                }
                            })
                            
                            let alert = UIAlertController(title: "UPDATE!", message: "Recovery Email Sent To: \(String(describing: (self.Email.text)))", preferredStyle: .alert);
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                        })
                        
                        alert.addAction(doNun);
                        alert.addAction(recover);
                        
                        self.present(alert, animated: true, completion: nil);
                        
                    }
                    
                    
                    else{
                        let uid = Auth.auth().currentUser?.uid;
                        //Success
                        
                        let storageRef = Storage.storage().reference().child(uid!).child("ProfilePicture.png");
                        let imageChose = Data();
                        if let imageChosen = self.profileImageView.image?.pngData() {
                            storageRef.putData(imageChosen, metadata: nil, completion: { (metadata, error) in storageRef.downloadURL(completion: { (url, error) in
                                
                                if let urlText = url?.absoluteString {
                                    
                                    self.setUserInformation(self.FName.text!, email: self.Email.text!, phone: self.phoneNumber.text!, profileImage: urlText, uid: uid!);
                                    
                                    name = self.FName.text!;
                                    phone = self.phoneNumber.text!;
                                }
                            })
                                
                                if error != nil {
                                    print(error?.localizedDescription as Any)
                                    return;
                                }
                                
                            })
                        }
                        
                        self.performSegue(withIdentifier: "segue2", sender: nil);
                    }
                    
                    
                }
            }
            else
            {
                let alert = UIAlertController(title: "Password MisMatch", message: "Match Passwords Please", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
            }
        }
        else
        {
            let alert = UIAlertController(title: "Input Error", message: "Fill In All Inputs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
        
        
    }
    
    
    
    func setUpProfileImageView() {
        
        let picker = UIImagePickerController();
        picker.delegate = self;
        
        present(picker, animated: true, completion: nil);
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        var selectedImage: UIImage?;
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            selectedImage = originalImage
        }
        
        if let select = selectedImage
        {
            profileImageView.image = select;
            
        }
        self.picLabel.text = " ";
        dismiss(animated: true, completion: nil);
    }
    
    
    
    func setUserInformation(_ fullName: String, email: String, phone: String, profileImage: String, uid: String)
    {
        let ref = Database.database().reference();
        let userRef = ref.child("users")
        let uid = Auth.auth().currentUser?.uid;
        let newUserRef = userRef.child(uid!);
        
        
        newUserRef.updateChildValues((["Name" : fullName,
                                       "Email" : email,
                                       "PNumber" : phone,
                                       "ProfilePic" : profileImage]));
        
    }
    
    
    @IBAction func inputAction(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    
    @objc func handleProfileImage(){
        let pickerController = UIImagePickerController();
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil);
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.clipsToBounds = true;
        profileImageView.layer.cornerRadius = 125;
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.handleProfileImage))
        profileImageView.addGestureRecognizer(tapGesture);
        profileImageView.isUserInteractionEnabled = true;
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
