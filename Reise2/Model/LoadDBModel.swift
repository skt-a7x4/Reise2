//
//  LoadDBModel.swift
//  Reise2
//
//  Created by 酒匂竜也 on 2022/03/10.
//

import Foundation
import Firebase
import Cosmos

protocol GetReise {
    
    func getReise(dataArray:[ReiseModel])
    
}

class LoadDBModel {
    
    let db = Firestore.firestore()
    var getReise:GetReise?
    
    var ReiseModelArray:[ReiseModel] = []
    
    func loadReise(Reise:String) {
        
        db.collection("Users").document(Reise).collection("Reise").order(by:"date").addSnapshotListener { (snapShot,error) in
            self.ReiseModelArray = []
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {                    
                    let data = doc.data()
                    
                    if let userID = data["userID"] as? String,let userName = data["userName"] as? String,let image = data["image"] as? String,let ReiseName = data["ReiseName"] as? String,let review = data["review"] as? String,let sender = data["sender"] as? String,let price = data["price"] as? String,let ReisePrefecture = data["ReisePrefecture"] as? String,let rate = data["rate"] as? Double,let date = data["date"] as? Double {
                        
                        let reiseModel = ReiseModel(imageURLString: image, price: price, ReiseName: ReiseName, ReisePrefecture: ReisePrefecture, review: review, userNameString: userName, userID: userID, sender: sender, rate: rate)
                        
                        
                        self.ReiseModelArray.append(reiseModel)
                        
                        self.getReise?.getReise(dataArray: self.ReiseModelArray)
                        
                    }
                    
                }
            }
        }
        
    }
    
}
