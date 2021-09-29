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
    var messages : [Message] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        title = Constants.appName
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMessages()

    }
    
    func loadMessages(){
        
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let sender = document.data()[Constants.FStore.senderField] as? String, let body = document.data()[Constants.FStore.bodyField] as? String{
                        let message = Message(senderEmail: sender, body: body)
                        self.messages.append(message)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(
                data: [Constants.FStore.senderField : messageSender,
                       Constants.FStore.bodyField : messageBody,
                       Constants.FStore.dateField : Date().timeIntervalSince1970]) { (error) in
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
