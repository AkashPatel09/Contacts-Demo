//
//  ViewController.swift
//  Contacts-Demo
//
//  Created by Akash Patel on 22/12/17.
//  Copyright © 2017 Akash Patel. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnGetContacts: UIButton!
    
    var arraySelectedContacts : [CNContact]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnGetContactsPressed(_ sender: Any) {
        
        
        let contactPickerController = CNContactPickerViewController.init()
        contactPickerController.delegate = self
        self.present(contactPickerController, animated: true, completion: nil)
    }
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arraySelectedContacts != nil ? (self.arraySelectedContacts?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let lblContactName = cell?.viewWithTag(100) as! UILabel
        let lblContactNumber = cell?.viewWithTag(101) as! UILabel
        let lblContactEmail = cell?.viewWithTag(102) as! UILabel
        
        let selectedContact = self.arraySelectedContacts![indexPath.row]
        
        let fullName = "\(selectedContact.givenName) \(selectedContact.familyName)"
        let contactNumber = "Contact: \(String(describing: (selectedContact.phoneNumbers[0].value ).value(forKey: "digits") as! String))"
        let emailAddress = "Email: \(selectedContact.emailAddresses.count <= 0 ? "Not Available" : selectedContact.emailAddresses[0].value)"
        
        lblContactName.text = fullName
        lblContactNumber.text = contactNumber
        lblContactEmail.text = emailAddress
        
        return cell!
    }
    
    
    
    //MARK: - ContactPicker Delegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        self.arraySelectedContacts = contacts
        self.tableView.reloadData()
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

