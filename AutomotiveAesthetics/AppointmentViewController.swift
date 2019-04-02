//
//  AppointmentViewController.swift
//  AutomotiveAesthetics
//
//  Created by Kevin Rama on 3/9/19.
//  Copyright © 2019 Kevin Rama. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseAuth
import FirebaseMessaging
import FirebaseDatabase

class AppointmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate{
    
    
    
    @IBOutlet weak var servicesPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setAppointmentButton: UIButton!
    @IBOutlet weak var detailLocation: UITextField!

    
    let user = Auth.auth().currentUser;
    
    let services = [
        "Odor Removal     $34.99",
        "Headlight Restoration     $34.99",
        "Basic Interior Detail     $59.99",
        "Deluxe Interior Detail     $99.99",
        "Basic Exterior Detail     $59.99",
        "Deluxe Exterior Detail     $99.99",
        "Basic Interior & Exterior     $99.99",
        "Deluxe Interior & Exterior    $189.99"
    ]
    
    
    func configMailController(_ email: String, service: String, date: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController();
        
        mailComposerVC.mailComposeDelegate = self;
        mailComposerVC.setToRecipients(["\(email)"]);
        mailComposerVC.setSubject("Automotive Aesthetics Booking Conformation");
        mailComposerVC.setMessageBody("Your appointment has been booked for \(service) on \(date)", isHTML: false);
        return mailComposerVC;
    }
    
    @IBAction func bookNow(_ sender: UIButton) {
        let alert = UIAlertController(title: "Booking Details", message: "You have selected \(services[servicesPicker.selectedRow(inComponent: 0)]) \n For the date of \(datePicker.date) \n At the location of \(detailLocation.text!)", preferredStyle: .alert);
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil);
        let confirm = UIAlertAction(title: "Confirm", style: .default, handler: nil);
        alert.addAction(cancel);
        alert.addAction(confirm);
        present(alert, animated: true, completion: nil);
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil);
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return services.count;
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return services[row];
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
