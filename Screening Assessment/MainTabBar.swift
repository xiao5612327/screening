//
//  MainTabBar.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/10/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class MainTabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    let tabNames = ["TAB ONE", "TAB TWO", "TAB THREE"]
    
    var mainTabOneConroller: MainTabOneController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        collectionView.register(TabCell.self, forCellWithReuseIdentifier: cellId)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabCell
        
        cell.tabsLable.text = tabNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainTabOneConroller?.switchToMainTabIndex(tabIndex: indexPath.item)
    }
    
}

class TabCell: BaseCell {

    let tabsLable: UILabel = {
        let lable = UILabel()
        lable.text = "TAB ONE"
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override var isHighlighted: Bool{
        didSet{
            tabsLable.font = isHighlighted ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 14)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            tabsLable.font = isSelected ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 14)
        }
    }
    
    override func setupTabView() {
        super.setupTabView()
        
        backgroundColor = UIColor.white
        
        addSubview(tabsLable)
        
        tabsLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tabsLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tabsLable.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tabsLable.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
}








