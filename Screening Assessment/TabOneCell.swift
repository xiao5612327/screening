//
//  TabOneCell.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/11/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

var users = [User]()
var currentUser = User()

class TabOneCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //this avariable is for tab one main screen view
    lazy var collectionMainView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        return cv
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        return button
    }()
    
    let bottomLine: UIView = {
        let line = UIView()
        //line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0.6, alpha: 1)
        return line
    }()
    
    var currentIndex: Int = 0
    
    func handleSubmit(){

        endEditing(true)
        let info = User()
        info.name = MainTabOneViewOneCell.user.name
        info.color = MainTabOneViewOneCell.user.color
        info.code = MainTabOneViewOneCell.user.code

        users.append(info)
        let section = Section(name: info.name!, color: info.color!, code: info.code!, expanded: false)
        sections.append(section)
        currentIndex = currentIndex + 1
        
        switchToNextView(index: currentIndex)
        resetAfterSubmit()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newUserInfoAdded"), object: nil)

    }
    
    func resetAfterSubmit(){
        submitButton.alpha = 0
        NotificationCenter.default.post(name: NSNotification.Name("resetTextField"), object: nil)
        submitButton.isEnabled = false
        submitButton.backgroundColor = UIColor.lightGray
        colorCheck = false
        codeCheck = false
        nameCheck = false
    }
    
    func handleBack(){
        if currentIndex != 0{
            currentIndex = currentIndex - 1
            switchToNextView(index: currentIndex)
            if currentIndex == 0{
                submitButton.alpha = 1
            }
        }
    }
    
    override func setupTabView() {
        tabOneCell = self
        addSubview(collectionMainView)
        addSubview(backButton)
        addSubview(submitButton)
        addSubview(bottomLine)
        
        collectionMainView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        collectionMainView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionMainView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionMainView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        collectionMainView.register(MainTabOneViewOneCell.self, forCellWithReuseIdentifier: viewOneId)
        collectionMainView.register(MainTabOneViewTwoCell.self, forCellWithReuseIdentifier: viewTwoId)
        collectionMainView.register(MainTabOneViewThreeCell.self, forCellWithReuseIdentifier: viewThreeId)
        
        backButton.leftAnchor.constraint(equalTo: collectionMainView.leftAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: collectionMainView.topAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        submitButton.centerXAnchor.constraint(equalTo: collectionMainView.centerXAnchor).isActive = true
        submitButton.centerYAnchor.constraint(equalTo: collectionMainView.centerYAnchor, constant: 50).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottomLine.bottomAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomLine.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        collectionMainView.isPagingEnabled = true
        handleSubmitAndBack()
        
        handleUserInputObserverCenter()
    }
    
    func handleUserInputObserverCenter(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(nameGoodCheck), name: NSNotification.Name("nameGood"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(nameBadCheck), name: NSNotification.Name("nameBad"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(colorGoodCheck), name: NSNotification.Name("colorGood"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(colorBadCheck), name: NSNotification.Name("colorBad"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(codeGoodCheck), name: NSNotification.Name("codeGood"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(codeBadCheck), name: NSNotification.Name("codeBad"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleSelectedUser(_:)), name: NSNotification.Name("selectedUser"), object: nil)
        
    }
    func handleSelectedUser(_ notification: Notification){
        switchToNextView(index: 2)
        currentIndex = currentIndex + 1
    }
    
    var nameCheck = false, colorCheck = false, codeCheck = false
    
    func nameGoodCheck(){
        nameCheck = true
        changeColorCheck(name: nameCheck, color: colorCheck, code: codeCheck)
    }
    func nameBadCheck(){
        nameCheck = false
        changeColorCheck(name: nameCheck, color: colorCheck, code: codeCheck)
    }
    func colorGoodCheck(){
        colorCheck = true
        changeColorCheck(name: nameCheck, color: colorCheck, code: codeCheck)
    }
    func colorBadCheck(){
        colorCheck = false
        changeColorCheck(name: nameCheck, color: colorCheck, code: codeCheck)
    }
    func codeGoodCheck(){
        codeCheck = true
        changeColorCheck(name: nameCheck, color: colorCheck, code: codeCheck)
    }
    func codeBadCheck(){
        codeCheck = false
        changeColorCheck(name: nameCheck, color: colorCheck, code: codeCheck)
    }
    
    func changeColorCheck(name: Bool, color: Bool, code: Bool){
        if name && color && code{
            submitButton.isEnabled = true
            submitButton.backgroundColor = UIColor.blue
        }else{
            submitButton.isEnabled = false
            submitButton.backgroundColor = UIColor.lightGray
        }
    }
    
    func handleSubmitAndBack(){
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    func switchToNextView(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        collectionMainView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        currentIndex = IndexPath(item: Int(targetContentOffset.pointee.x / frame.width), section: 0).item
    }
    
    let viewOneId = "viewOneId"
    let viewTwoId = "viewTwoId"
    let viewThreeId = "viewThreeId"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        
        if indexPath.item == 0{
            identifier = viewOneId
        }else if indexPath.item == 1{
            identifier = viewTwoId
        }else{
            identifier = viewThreeId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    
}

