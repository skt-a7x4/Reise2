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
import Nuke


class ReiseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GetReise{
 
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 665
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        
       
        
       let profileImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let profileImage = self.Posts[indexPath.row].sender[0]
        if let url = URL(string: profileImage) {

            Nuke.loadImage(with: url, into: profileImageView)
        }


        let userName = cell.contentView.viewWithTag(2) as! UILabel
        userName.text = self.Posts[indexPath.row].sender[1]

        let ReiseImageView = cell.viewWithTag(3) as! UIImageView

        let ReiseImage = self.Posts[indexPath.row].ReiseImageData
        if let url = URL(string: ReiseImage) {

            Nuke.loadImage(with: url, into: ReiseImageView)


        }
        let Reise = cell.contentView.viewWithTag(4) as! UILabel
        Reise.text = self.Posts[indexPath.row].ReiseName

        let prefecture = cell.contentView.viewWithTag(5) as! UILabel
        prefecture.text = self.Posts[indexPath.row].prefecture

        let price = cell.contentView.viewWithTag(6) as! UILabel
        price.text = self.Posts[indexPath.row].price


        let review = cell.contentView.viewWithTag(7) as! UILabel
        review.text = self.Posts[indexPath.row].Review

        let rate = cell.contentView.viewWithTag(8) as! CosmosView

        return cell
    }
    
    func getReise(dataArray: [ReiseModel]) {
        reiseModelArray = []
        reiseModelArray = dataArray
        ReiseTableView.reloadData()
        
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
