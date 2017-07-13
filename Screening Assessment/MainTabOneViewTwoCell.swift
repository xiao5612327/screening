//
//  MainTabOneViewTwo.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/12/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class MainTabOneViewTwoCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupTabView() {
        super.setupTabView()
        backgroundColor = UIColor.white
        addSubview(collectionview)
        collectionview.backgroundColor = UIColor.white
        collectionview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionview.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        collectionview.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionview.heightAnchor.constraint(equalTo: heightAnchor, constant: -100).isActive = true
        
        collectionview.register(userCell.self, forCellWithReuseIdentifier: cellId)
        observeUserInput()
    }
    
    func observeUserInput(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("newUserInfoAdded"), object: nil)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    let cellId = "cellId"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! userCell
        cell.nameLable.text = users[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionview.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index:[String: Int] = ["index": indexPath.item]
        let name = Notification.Name("selectedUser")
        currentUser = users[indexPath.item]
        NotificationCenter.default.post(name: name, object: nil, userInfo: index)
    }
}

class userCell: BaseCell {
    
    let nameLable: UILabel = {
        let labal = UILabel()
        labal.text = "hello"
        labal.translatesAutoresizingMaskIntoConstraints = false
        labal.textAlignment = .center
        return labal
    }()
    
    let bottomLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0.6, alpha: 1)
        return line
    }()
    
    override func setupTabView() {
        super.setupTabView()
        
        addSubview(nameLable)
        addSubview(bottomLine)
        
        nameLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLable.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomLine.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

    }

}

