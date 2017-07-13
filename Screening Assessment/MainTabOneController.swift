//
//  ViewController.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/10/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class MainTabOneController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, -20, 0)
        
        setupTabsView()
        setupTabsBar()
        
        self.viewWillDisappear(true)
    }
    
    let tabOneId = "tabOneId"
    let tabTwoId = "tabTwoId"
    let tabThreeId = "tabThreeId"
    
    func setupTabsView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(TabOneCell.self, forCellWithReuseIdentifier: tabOneId)
        collectionView?.register(TabTwoCell.self, forCellWithReuseIdentifier: tabTwoId)
        collectionView?.register(TabThreeCell.self, forCellWithReuseIdentifier: tabThreeId)
        
        collectionView?.isScrollEnabled = false
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 0 {
            identifier = tabOneId
        }else if indexPath.item == 1{
            identifier = tabTwoId
        }else{
            identifier = tabThreeId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    lazy var mainTabBar: MainTabBar = {
        let tabs = MainTabBar()
        tabs.translatesAutoresizingMaskIntoConstraints = false
        tabs.mainTabOneConroller = self
        return tabs
    }()
    
    let mainTabBarLineSaprator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0.5, alpha: 1)
        return line
    }()
    
    private func setupTabsBar(){
        view.addSubview(mainTabBar)
        
        mainTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainTabBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(mainTabBarLineSaprator)
        
        mainTabBarLineSaprator.bottomAnchor.constraint(equalTo: mainTabBar.topAnchor).isActive = true
        mainTabBarLineSaprator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTabBarLineSaprator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainTabBarLineSaprator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func switchToMainTabIndex(tabIndex: Int){
        
        let indexPath = IndexPath(item: tabIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidDisappear(animated)
    }

}

