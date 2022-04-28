import UIKit
import FirebaseFirestore
import Photos


class KensakuViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate {
    

    @IBOutlet weak var prefecture: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var db = Firestore.firestore()
    var prefecturepicker = UIPickerView()
    var prefectureString = [String]()
    var Posts = [ReisedPostModel]()
    var sendDBModdel = SendDBModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
        
        // Do any additional setup after loading the view.
        prefecture.inputView = prefecturepicker
        prefecturepicker.delegate = self
        prefecturepicker.dataSource = self
        
        prefecturepicker.tag = 1
        doneButton.isEnabled = true
        
       
        
//        fetchpostDataby(Todofuken: "沖縄県")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
    case 1:
        prefectureString = Util.prefectures()
        return prefectureString.count
        
    default:
        return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
            
        case 1: prefecture.text = prefectureString[row]
            prefecture.resignFirstResponder()
            break
        default:
            break
            
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
            
        case 1:
            return prefectureString[row]
            
        default:
            return ""
            
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if prefecture.text?.count ?? 0 > 0 {
            
            doneButton.isEnabled = true
            
        }else {
            doneButton.isEnabled = false
            
        }
    }
    
    func fetchpostDataby(Todofuken:String,complision:@escaping([ReisedPostModel]?)->()) {
        
        self.db.collection("Posts").whereField("ReisePrefecture", isEqualTo: Todofuken).getDocuments { snapShots, error in
            if let error = error {
                
                print(error)
                complision(nil)
                
            }
            
            guard let documents = snapShots?.documents else{
                complision(nil)
                return
                
            }
            documents.forEach { snapShot in
                print(snapShot.data())
                
                self.Posts.append(ReisedPostModel(dic: snapShot.data()))
                
                
            }
            complision(self.Posts)
        }
        
    }
    
    

    @IBAction func done(_ sender: Any) {
        
//        非同期処理
        fetchpostDataby(Todofuken:prefecture.text! ) { Posts in
            if let Posts = Posts{
                
                DispatchQueue.main.async {
                    let storyBoard = UIStoryboard(name:"Main" , bundle: nil)
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "ReiseViewController") as! ReiseViewController
                    nextVC.Posts = Posts
                
    self.present(nextVC, animated: true, completion: nil)
                }
                
            }else{
                
                print("通信に失敗しました")
                
            }
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
