//
//  TabTwoCell.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/11/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class TabTwoCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
 
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    lazy var subTabBar: SubTabBar = {
        let stb = SubTabBar()
        stb.translatesAutoresizingMaskIntoConstraints = false
        stb.tabTwoCell = self
        return stb
    }()
    
    let subTopBarLineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.5, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    
    let cellId = "cellId"
    
    override func setupTabView() {
        
        addSubview(collectionView)
        addSubview(subTabBar)
        addSubview(subTopBarLineSeparator)
        
        collectionView.topAnchor.constraint(equalTo: subTabBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        collectionView.register(SubTabView.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        
        setupTopSubBar()
        setupTopLineSeparator()
    }
    
    func setupTopLineSeparator(){
        subTopBarLineSeparator.topAnchor.constraint(equalTo: subTabBar.bottomAnchor).isActive = true
        subTopBarLineSeparator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subTopBarLineSeparator.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        subTopBarLineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func switchSubTabView(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
 
    func setupTopSubBar(){
        
        subTabBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subTabBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subTabBar.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        subTabBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    let balabalaWord = ["Spicy Food","Dog","Light Blue"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SubTabView
        cell.balabalaLable.text = balabalaWord[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        subTabBar.horizontalBarLeftAnchorLayout?.constant = scrollView.contentOffset.x / 3
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = IndexPath(item: Int(targetContentOffset.pointee.x / frame.width), section: 0)
        subTabBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }

}



class SubTabView: BaseCell {
    
    let balabalaLable: UILabel = {
        let lable = UILabel()
        lable.text = "Helle"
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        return lable
    }()
    
    override func setupTabView() {
        setupMidLable()
    }
    
    func setupMidLable(){
        
        backgroundColor = UIColor.white
        addSubview(balabalaLable)
        
        balabalaLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        balabalaLable.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        balabalaLable.widthAnchor.constraint(equalToConstant: 300).isActive = true
        balabalaLable.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
}




