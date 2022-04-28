//
//  SentakuViewController.swift
//  ReiseApp1
//
//  Created by sako tatsuya on 2022/03/02.
//

import UIKit
import Firebase




class SentakuViewController: UIViewController {

    @IBOutlet weak var ichiranImage: UIImageView!
    @IBOutlet weak var satueiImage: UIImageView!
    @IBOutlet weak var ichiranButton: UIButton!
    @IBOutlet weak var satueiButton: UIButton!
    
    
    var userDataModelArray = [UserDataModel]()
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
       
        if Auth.auth().currentUser?.uid != nil {
            
           
            
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

