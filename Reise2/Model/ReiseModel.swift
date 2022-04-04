//
//  ReiseModel.swift
//  Reise2
//
//  Created by 酒匂竜也 on 2022/03/10.
//

import Foundation

struct ReiseModel {
    
//    var profileModel:ProfileModel?
    
    
    let imageURLString:String?
    let price:String?
    let ReiseName:String?
    var ReisePrefecture:String?
    let review:String?
    let userNameString:String?
    let userID:String?
    var sender:String?
    let rate:Double?
    
}

struct ReisedPostModel {
    var ReiseName:String
    var uid:String
    var sender:[String]
    var ReiseImageData:String
    var prefecture:String
    var price:String
    var Review:String
    
    init(dic:[String:Any]) {
        
        self.ReiseName = dic["ReiseName"] as? String ?? ""
        self.uid = dic["uid"] as? String ?? ""
        self.sender = dic["sender"] as? [String] ?? []
        self.ReiseImageData = dic["ReiseImageData"] as? String ?? ""
        self.prefecture = dic["ReisePrefecture"] as? String ?? ""
        self.price = dic["price"] as? String ?? ""
        self.Review = dic["review"] as? String ?? ""
        
    }
    
    
    
}
