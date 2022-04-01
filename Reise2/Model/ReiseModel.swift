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
    
    var uid:String
    init(dic:[String:Any]) {
        
        self.uid = dic["uid"] as? String ?? ""
        
    }
    
    
    
}
