//
//  ToukouViewController.swift
//  Reise2
//
//  Created by 酒匂竜也 on 2022/03/07.
//

import UIKit
import Cosmos
import Firebase
import Photos

class ToukouViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,ReiseSendDone{
    
    
   
    
    var privateCamera = false
    
    @IBOutlet weak var Toukouimage: UIImageView!
    @IBOutlet weak var Todoufuken: UITextField!
    @IBOutlet weak var Reise: UITextField!
    @IBOutlet weak var Money: UITextField!
    @IBOutlet weak var Rate: CosmosView!
    @IBOutlet weak var Review: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    var userDefaltsEX = UserDefaultsEX()
    var TodoufukenPicker = UIPickerView()
    var MoneyPicker = UIPickerView()
    
    var TodoufukenString = [String]()
    var MoneyString = [String]()
    
    var sendDB = SendDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Toukouimage.layer.cornerRadius = 20
        Todoufuken.inputView = TodoufukenPicker
        Money.inputView = MoneyPicker
        
        TodoufukenPicker.delegate = self
        TodoufukenPicker.dataSource = self
        MoneyPicker.delegate = self
        MoneyPicker.dataSource = self
        
        Reise.delegate = self
        Todoufuken.delegate = self
        Money.delegate = self
        
        
        TodoufukenPicker.tag = 1
        MoneyPicker.tag = 2
        
        
        Review.text = "感想を入力してください"
        Review.delegate = self
        Review.textColor = UIColor.lightGray
    
//        Review.placeHolder = "ここに入力"
//               Review.placeHolderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
        
        sendDB.reiseSendDone = self
        // Do any additional setup after loading the view.
    }
    
    
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
      self.navigationController?.isNavigationBarHidden = false
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            TodoufukenString = Util.prefectures()
            return TodoufukenString.count
        case 2:
            MoneyString = Util.Moneys2()
            return MoneyString.count
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 1:
            Todoufuken.text = TodoufukenString[row]
                Todoufuken.resignFirstResponder()
            case 2:
            Money.text = MoneyString[row]
            Money.resignFirstResponder()
        default:
            break
        }
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return TodoufukenString[row]
            
        case 2:
            return
            MoneyString[row]
            
        default:
            return ""
            
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if Reise.text?.count ?? 0 > 0 && Money.text?.count ?? 0 > 0 && Todoufuken.text?.count ?? 0 > 0 && Review.text?.count ?? 0 > 0 && privateCamera == true {
            
            doneButton.isEnabled = true
            
        }else {
            
            doneButton.isEnabled = false
        }
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        let userData:UserDataModel? = userDefaltsEX.codable(forKey: "profile")
        
        self.sendDB.sendDB(ReiseName: Reise.text!, price: Money.text!, userName: (userData?.name)!, ReisePrefecture: Todoufuken.text!, review: Review.text!, rate: self.Rate.rating, ReiseImageData: (Toukouimage.image?.jpegData(compressionQuality: 0.01))!, sender: userData!)//FireBaseに飛ばす
        
        self.navigationController?.popViewController(animated: true)//画面を閉じる
    }
    
    func reiseSendDone() {
        self.dismiss(animated: true,completion: nil)
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
            Toukouimage.image = pickedImage
            //閉じる処理
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
