//
//  ViewController.swift
//  Reise2
//
//  Created by 酒匂竜也 on 2022/03/04.
//

import UIKit
import Lottie
import SnapKit

class ViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ESCButton: UIButton!
    
    
    var  AnimationArray = ["1","2","3","4","5"]
    var AnimationStringArray = ["あなたの投稿で観光地や地元を盛り上げよう","楽しい、綺麗な夜景や背景をみんなで共有","いいなぁと思った場所にはどんどん行ってみよう","あなたの投稿が輪を広げる","さぁ登録して始めよう！"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ESCButton.frame = CGRect(x:280, y: 100, width: 100, height: 30)
        
        // Do any additional setup after loading the view.
        ScrollView.isPagingEnabled = true
        SetScroll()
        
        for i in 0...4{
            
            let animationView = AnimationView()
            let animation = Animation.named(AnimationArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            ScrollView.addSubview(animationView)
           
        }
    }
    
   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = false
      
       
        view.addSubview(ESCButton)
        

    }
   
    
    
    func SetScroll() {
        
        ScrollView.delegate = self
        
        
        ScrollView.contentSize = CGSize(width: view.frame.width * 5, height: ScrollView.frame.size.height)
        
        ScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()//Scroll画面全画面固定
            
        }
       
        
        for i in 0...4 {
            
            let animationLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height/3, width: ScrollView.frame.size.width, height: ScrollView.frame.size.height))
            
            animationLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            animationLabel.textAlignment = .center
            animationLabel.text = AnimationStringArray[i]
            ScrollView.addSubview(animationLabel)
        }
        
    }


}

