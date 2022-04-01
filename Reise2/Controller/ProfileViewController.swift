//
//  ProfileViewController.swift
//  ReiseApp1
//
//  Created by sako tatsuya on 2022/03/01.
//

import UIKit
import Firebase
import Photos
import FirebaseFirestoreSwift
class ProfileViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ProfileSendDone {

    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var prefectureText: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var privateCamera = false
    var agePicker = UIPickerView()
    var PrefecturePicker = UIPickerView()
//    北海道-沖縄
    var PrefectureString = [String]()
//    年齢
    var AgeIntArray = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileImage.layer.cornerRadius = 20
        ageText.inputView = agePicker
        prefectureText.inputView = PrefecturePicker
        
        agePicker.delegate = self
        agePicker.dataSource = self
        PrefecturePicker.delegate = self
        PrefecturePicker.dataSource = self
        
        nameText.delegate = self
        ageText.delegate = self
        prefectureText.delegate = self
        
        agePicker.tag = 1
        PrefecturePicker.tag = 2
        
        doneButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            AgeIntArray = ([Int])(12...80)
            return AgeIntArray.count
        case 2:
            PrefectureString = Util.prefectures()
            return PrefectureString.count
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1: ageText.text = String(AgeIntArray[row]) + "歳"
            ageText.resignFirstResponder()
            break
        case 2: prefectureText.text = PrefectureString[row]
            prefectureText.resignFirstResponder()
            break
        default:
            break
        }
    }
    
    //    行に記載する文字列
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch pickerView.tag {
            case 1:
                return String(AgeIntArray[row]) + "歳"
            case 2:
                return PrefectureString[row]
            default:
                return ""
            }
        }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if nameText.text?.count ?? 0  > 0 && ageText.text?.count ?? 0 > 0 && prefectureText.text?.count ?? 0 > 0 && privateCamera == true {
            
            doneButton.isEnabled = true
            
        }else {
            
            doneButton.isEnabled = false
        }
        
        
    }
    
    @IBAction func done(_ sender: Any) {
        
        let maneger  = Manager.shared.profile
        
        Auth.auth().signInAnonymously { result, error in
            if error != nil {
                
                print(error.debugDescription)
                return
                
            }
            
        
            let userdata = UserDataModel(name: self.nameText.text, age: self.ageText.text, prefecture: self.prefectureText.text, profileImageString: "", uid: Auth.auth().currentUser?.uid, date: Date().timeIntervalSince1970)
          
            let sendDBModel = SendDBModel()
            sendDBModel.profileSendDone = self
            sendDBModel.sendProfileData(userData: userdata, profileimageData: (self.ProfileImage.image?.jpegData(compressionQuality: 0.4))!)
        }
        
        
    
    }
    
    func profileSendDone() {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func tap(_ sender: Any) {
        
        openCamera()
        
    }
    
    
    
    func openCamera(){
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            privateCamera = true
            //            cameraPicker.showsCameraControls = true
            present(cameraPicker, animated: true, completion: nil)
            
        }else{
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[.editedImage] as? UIImage
        {
            ProfileImage.image = pickedImage
            //閉じる処理
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
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
