//
//  UserList.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/12/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class UserList: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.brown
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func showUserList(users: [User]){
        
        
        if let keyWindow = UIApplication.shared.keyWindow {
//            let view = UIView(frame: keyWindow.frame)
            
//            view.backgroundColor = UIColor.white
//            view.addSubview(backButton)
//            
//            view.frame = CGRect(x: keyWindow.frame.width - 10, y: 20, width: 10, height: keyWindow.frame.height - 60)
//            keyWindow.addSubview(view)
            keyWindow.addSubview(collectionView)
            collectionView.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor).isActive = true
            collectionView.centerYAnchor.constraint(equalTo: keyWindow.centerYAnchor).isActive = true
            collectionView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//            collectionView.addSubview(backButton)
//            collectionView.frame = CGRect(x: 0, y: 20, width: keyWindow.frame.width, height: keyWindow.frame.height - 60)
            
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                  view.frame = CGRect(x: 0, y: 20, width: keyWindow.frame.width, height: keyWindow.frame.height - 60)
//                
//            }, completion: nil)

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}
