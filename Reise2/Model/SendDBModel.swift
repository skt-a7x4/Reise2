//
//  SendDBModel.swift
//  ReiseApp1
//
//  Created by sako tatsuya on 2022/03/02.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol ProfileSendDone {
    
    func profileSendDone()
    
}

protocol ReiseSendDone {
    
    func reiseSendDone()
    
}


class SendDBModel {
    
    let db = Firestore.firestore()
    
    var profileSendDone:ProfileSendDone?
    var reiseSendDone:ReiseSendDone?
    var userDefaltsEX = UserDefaultsEX()
    var myProfile = [String]()
    
    
    func sendProfileData(userData:UserDataModel,profileimageData:Data){
        
        let imageRef = Storage.storage().reference().child("ProfileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpeg")
        imageRef.putData(profileimageData,metadata: nil) { metadata,error in
            if error != nil {
                return
                
            }
            
            imageRef.downloadURL { url, error in
                if error != nil {
                    
                    return
                    
                }
                
                
                
                if url != nil {
                    //                   ？　UserDataModel書き直した方がいいかも
                    //                    もしくはKeyChainの引き出し
                    let userData = UserDataModel(name: userData.name, age: userData.age, prefecture: userData.prefecture, profileImageString: url?.absoluteString, uid: Auth.auth().currentUser!.uid, date: Date().timeIntervalSince1970)
                    
                    //アプリ内に自分のプロフィールを保存しておく。そのためUserDefaultsEXのElementを使いたい為ここでこのように記述する
                    
                    self.userDefaltsEX.set(value: userData, forKey: "profile")
                    
                    self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData(["name" : userData.name as Any,"age":userData.age as Any,"prefecture": userData.prefecture as Any,"profileImageString": url?.absoluteString as Any,"uid":Auth.auth().currentUser!.uid as Any,"Date":Date().timeIntervalSince1970]) { error in
                        if let error = error {
                            
                            print(error)
                            
                        }
                        self.profileSendDone?.profileSendDone()
                        
                        
                        KeyChainConfig.setKeyData(value: ["name" : userData.name as Any,"age":userData.age as Any,"prefecture": userData.prefecture as Any,"profileImageString": url?.absoluteString as Any,"uid":Auth.auth().currentUser!.uid as Any], key: "userData")
                    }
                    
                    
                    
                    
                    
                }
                
            }
            
            
        }
    }
    
    //    投稿時にFirebaseに送信される処理
    func sendDB(ReiseName:String,price:String,userName:String,ReisePrefecture:String,review:String,rate:Double,ReiseImageData:Data,sender:UserDataModel) {
        
        let imageRef = Storage.storage().reference().child("ReiseImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpeg")
        imageRef.putData(ReiseImageData,metadata: nil) { metadata,error in
            if error != nil {
                return
                
            }
            
            imageRef.downloadURL { url, error in
                if error != nil {
                    
                    return
                    
                }
                
                if url != nil {
                    
                    
                    self.myProfile.append(sender.profileImageString!)
                    self.myProfile.append(sender.name!)
                    self.myProfile.append(sender.uid!)
                    
                    self.db.collection("Posts").document().setData(["name" : userName as Any,"uid":Auth.auth().currentUser!.uid as Any,"ReiseName":ReiseName,"price":price,"ReisePrefecture":ReisePrefecture,"rate":rate,"review":review,"ReiseImageData":url?.absoluteString as Any,"sender":self.myProfile,"Date":Timestamp()]){
                        
                        error in
                        if let error = error {
                            
                            print(error)
                            
                        }
                        self.reiseSendDone?.reiseSendDone()
                    }
                    
                    
                    
                }
                
            }
        }
    }
    
}

