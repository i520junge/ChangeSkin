//
//  ViewController.swift
//  ChangeSkin
//
//  Created by 刘军 on 2016/11/19.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

private let kSkinBtnKey = "kSkinBtnKey"

enum KSkinType:String {
    case ChunJie = "chunjie"
    case GuoQing = "guoqing"
    case ZhongQiu = "zhongqiu"
}

class ViewController: UIViewController {
//MARK:- 属性
    @IBOutlet weak var skinBtns: UIStackView!
    @IBOutlet weak var skinViewTopCon: NSLayoutConstraint!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var iconBtn: UIButton!
    
    var selectBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 从偏好设置中取出保存的按钮tag
        let skinBtnTag = UserDefaults.standard.object(forKey: kSkinBtnKey) as? Int ?? 0
        let btns = skinBtns.subviews
        for btn in btns {
            guard btn.tag == skinBtnTag else {
                continue
            }
            //将偏好设置中存的 设置主题类型
            skinBtnClick(btn as! UIButton)
        }
    }

}

//MARK:- 监听换肤
extension ViewController{
    /// 点击换肤，弹出皮肤选项
    @IBAction func changeSkinClick(_ sender: UIBarButtonItem) {
        skinViewTopCon.constant = skinViewTopCon.constant == 0 ? -44 : 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    /// 点击不同皮肤进行换肤
    @IBAction func skinBtnClick(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 0:
            changeImage(.ChunJie)
        case 1:
            changeImage(.ZhongQiu)
        case 2:
            changeImage(.GuoQing)
        default:
            print("没换")
        }
        
        // 选中按钮
        selectBtn.isSelected = false
        sender.isSelected = true
        selectBtn = sender
        
        
        //将被选中按钮保存至偏好设置
        UserDefaults.standard.set(sender.tag, forKey: kSkinBtnKey)
        //设置这个可立即保存至偏好设置，不管主线程是否繁忙
        UserDefaults.standard.synchronize()
    }
    
    /// 切换图片
    func changeImage(_ skinType:KSkinType) {
        //1、切换皮肤图片
        iconBtn.setBackgroundImage(UIImage.init(named: "Skin/\(skinType)/icon.png"), for: .normal)
        backImageView.image = UIImage(named: "Skin/\(skinType)/back.png")
    }
    
}






