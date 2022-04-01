//
//  UserDataModel.swift
//  ReiseApp1
//
//  Created by sako tatsuya on 2022/03/02.
//

import Foundation
//比較可能なプロトコルに準拠させておく
struct UserDataModel:Codable {
    
    let name:String?
    let age:String?
    let prefecture:String?
    let profileImageString:String?
    let uid:String?
    let date:Double?
}
