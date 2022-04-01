//
//  ReiseViewController.swift
//  Reise2
//
//  Created by 酒匂竜也 on 2022/03/10.
//

import UIKit
import SDWebImage
import Cosmos
import Firebase
import FirebaseAuth


class ReiseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
//,GetReise {

    
    
    @IBOutlet weak var ReiseTableView: UITableView!
    
   var Posts = [ReisedPostModel]()
  let db = Firestore.firestore()
  var reiseModelArray = [ReiseModel]()
  var loadModel = LoadDBModel()
  var index = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        ReiseTableView.dataSource = self
        ReiseTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func ReiseFirebase() {
        
        let Ref = Firestore.firestore().collection("Users").document("Reise")
        
        Ref.getDocument() { (snapShot,error) in
            if let error = error {
                
                print(error)
                return
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    func getreise() {
        let Ref = Firestore.firestore().collection("Users").document("Reise")
        Ref.getDocument { (querySnapShot, error) in
            if let error = error{
                
                print(error)
                return
                
            }
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        
        let profileImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let userName = cell.contentView.viewWithTag(2) as! UILabel
        let ReiseImageView = cell.viewWithTag(3) as! UIImageView
        let Reise = cell.contentView.viewWithTag(4) as! UILabel
        let prefecture = cell.contentView.viewWithTag(5) as! UILabel
        let price = cell.contentView.viewWithTag(6) as! UILabel
        let review = cell.contentView.viewWithTag(7) as! UILabel
        let rate = cell.contentView.viewWithTag(8) as! CosmosView

        return cell
    }
    
    
    
//    func getReise(dataArray: [ReiseModel]) {
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
