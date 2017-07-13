//
//  SubTabBar.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/11/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class SubTabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var tabTwoCell: TabTwoCell?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        collectionView.register(SubTabCell.self, forCellWithReuseIdentifier: cellId)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        
        setupTopHorizontalBarView()
    }
    
    let horizontalBarView: UIView = {
        let hbv = UIView()
        hbv.backgroundColor = UIColor.red
        hbv.translatesAutoresizingMaskIntoConstraints = false
        return hbv
    }()
    
    var horizontalBarLeftAnchorLayout: NSLayoutConstraint?
    
    func setupTopHorizontalBarView(){
        addSubview(horizontalBarView)
        
        horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        horizontalBarLeftAnchorLayout = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor)
        horizontalBarLeftAnchorLayout?.isActive = true
        
        horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    let cellId = "cellId"
    let subTabNames = ["SUB TAB ONE", "SUB TAB TWO", "SUB TAB THREE"]

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SubTabCell
        cell.tabsLable.text = subTabNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabTwoCell?.switchSubTabView(index: indexPath.item)
    }
    
}

class SubTabCell: BaseCell {
    
    let tabsLable: UILabel = {
        let lable = UILabel()
        lable.text = "SUB TAB ONE"
        lable.font = UIFont.systemFont(ofSize: 11)
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override var isHighlighted: Bool{
        didSet{
            tabsLable.font = isHighlighted ? UIFont.boldSystemFont(ofSize: 12) : UIFont.systemFont(ofSize: 12)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            tabsLable.font = isSelected ? UIFont.boldSystemFont(ofSize: 12) : UIFont.systemFont(ofSize: 12)
        }
    }
    
    override func setupTabView() {
        super.setupTabView()
        
        backgroundColor = UIColor.white
        
        addSubview(tabsLable)
        
        tabsLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tabsLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tabsLable.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tabsLable.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
}

