//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var messages : [Message] = [
        Message(senderEmail: "giovanna@mail.com", body: "Hey"),
        Message(senderEmail: "giovanna@mail.com", body: "Just testing my app"),
        Message(senderEmail: "gioclone@mail.com", body: "Well, I guess this makes us 2 Hahahahhahahahhahha")
    ]
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        title = Constants.appName
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField : messageSender, Constants.FStore.bodyField : messageBody]) { (error) in
                if let err = error{
                    print("There was a problem saving the data to FireStore: \(err.localizedDescription)")
                }
                else {
                    print("Data successfully saved")
                }
            }
            
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
    
}
