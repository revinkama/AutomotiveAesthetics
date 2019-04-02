//
//  ProfileViewController.swift
//  AutomotiveAesthetics
//
//  Created by Kevin Rama on 3/7/19.
//  Copyright © 2019 Kevin Rama. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import GoogleSignIn

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    
    
    
    
    var registeredUser = RegisterViewController();
    
    var titles = ["Name:",
                  "Email:",
                  "Phone Number:"]
    
    var ref: DatabaseReference!;
    let user = Auth.auth().currentUser;
    var data = [String]();
    var selectedImage: UIImage?;


    func setUpProfilePicture() {
        
        let uid = Auth.auth().currentUser?.uid;
        let ref = Database.database().reference(fromURL: "https://automotiveaestheticsdetailing.firebaseio.com/")
        let googleUser = GIDSignIn.sharedInstance()?.currentUser
        if   (((GIDSignIn.sharedInstance()?.currentUser)) != nil) {
            
            if ((googleUser?.profile.hasImage)!){
                let dimension = round(250.0)
                let picURL = googleUser?.profile.imageURL(withDimension: UInt(dimension));
                
                let storage = Storage.storage().reference(forURL: "gs://automotiveaestheticsdetailing.appspot.com/").child(uid!).child("ProfilePicture.png");
                
                let profileDatabaseRef = ref.child("users").child(uid!).child("ProfilePic");
                let data = try? Data(contentsOf: picURL!);
                let image = UIImage(data: data! as Data);
                self.profileImage.image = image
                self.profileImage.layer.cornerRadius = 125;
                
                if let imagePNG = self.profileImage.image?.pngData(){
                    storage.putData(imagePNG, metadata: nil, completion: {(metadata, error) in
                        storage.downloadURL(completion: { (url, error) in
                            
                            if let urlText = url?.absoluteString{
                                profileDatabaseRef.setValue(urlText)
                            }
                            
                            
                        })
                    })
                }
            }
        }
        
        
        else {
            
            let userRef = ref.child("users").child(uid!);
            userRef.observeSingleEvent(of: .value) { (snapshot) in
                if !snapshot.exists() {return};
                let userInfo = snapshot.value as! NSDictionary;
                let profileURL = userInfo["ProfilePic"] as! String
                let storageRef = Storage.storage().reference(forURL: profileURL);
                storageRef.downloadURL(completion: { (url, error) in
                print(url as Any);
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data! as Data);
                    self.profileImage.image = image;
                    self.profileImage.layer.cornerRadius = 125;
                })
            }
        }
    }
 
    
 
    
 
 
 
    
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth();
        let googleUser = GIDSignIn.sharedInstance();
        do {
            try firebaseAuth.signOut(); googleUser?.signOut(); print("Signed Out!")
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC");
        self.present(signInVC, animated: true, completion: nil);
        
    }
    
    func setUpProfilePage() {
        let dataRef = Database.database().reference(fromURL: "https://automotiveaestheticsdetailing.firebaseio.com/")
        let uid = Auth.auth().currentUser!.uid;
        let userRef = dataRef.child("users");
        let userUid = userRef.child(uid);
        
        userUid.child("Name").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? String ?? "";
            self.data.append(value);
        }
        
        userUid.child("Email").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? String ?? "";
            self.data.append(value)
        }
        
        userUid.child("PNumber").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? String ?? "";
            self.data.append(value);
        }
        
        
    }
 
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell;
        cell.profileHeaderLabels.text = self.titles[indexPath.row];
        let user = Auth.auth().currentUser;
        
        self.data.append(user!.displayName ?? name);
        self.data.append(user!.email ?? "");
        self.data.append(user!.phoneNumber ?? phone)

        cell.profileInfoLabels.text = self.data[indexPath.row];
        
        return cell;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfilePicture();
        profileTableView.delegate = self;
        profileTableView.dataSource = self;
        self.profileImage.clipsToBounds = true;
        self.profileImage.layer.cornerRadius = 125;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpProfilePage();
        self.profileImage.clipsToBounds = true;
        self.profileImage.layer.cornerRadius = 125;
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



