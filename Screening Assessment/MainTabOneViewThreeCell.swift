//
//  MainTabOneViewThreeCell.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/12/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class MainTabOneViewThreeCell: BaseCell {
    
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Name: " + currentUser.name!
        lable.textAlignment = .center
        return lable
    }()
    
    let codeLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Code: " + currentUser.code!
        lable.textAlignment = .center
        return lable
    }()
    
    let colorLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "color: " + currentUser.color!
        lable.textAlignment = .center
        return lable
    }()
    
    override func setupTabView() {
        super.setupTabView()
        
        backgroundColor = UIColor.white
        addSubview(nameLable)
        addSubview(codeLable)
        addSubview(colorLable)
        
        nameLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLable.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200).isActive = true
        nameLable.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        codeLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        codeLable.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        codeLable.widthAnchor.constraint(equalToConstant: 200).isActive = true
        codeLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        colorLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        colorLable.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100).isActive = true
        colorLable.widthAnchor.constraint(equalToConstant: 200).isActive = true
        colorLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        receiveUserInfo()
    }
    
    func receiveUserInfo(){
        NotificationCenter.default.addObserver(self, selector: #selector(fecthUser(_:)), name: NSNotification.Name("selectedUser"), object: nil)
    }
    
    func fecthUser(_ notification: Notification){
        if let index = notification.userInfo?["index"] {
            
            var user = User()
            user = users[index as! Int]
            
            nameLable.text = "Name: " + user.name!
            colorLable.text = "color: " + user.color!
            codeLable.text = "code: " + user.code!
            
        }
    }

}




