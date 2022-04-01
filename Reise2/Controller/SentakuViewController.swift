//
//  SentakuViewController.swift
//  ReiseApp1
//
//  Created by sako tatsuya on 2022/03/02.
//

import UIKit
import Firebase

class SentakuViewController: UIViewController {

    var userDataModelArray = [UserDataModel]()
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser?.uid != nil {
            
            let userData = KeyChainConfig.getKeyData(key: "userData")
            
            
        }else{
            performSegue(withIdentifier: "profileVC", sender: nil)
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
