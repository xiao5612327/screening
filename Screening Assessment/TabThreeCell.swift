//
//  TabThreeCell.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/11/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//


import UIKit

class TabThreeCell: BaseCell, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    var sections = [Section(genre: "bad",movies:["good", "bad"], expanded: false), Section(genre: "bad", movies:["good", "bad"], expanded: false), Section(genre: "bad", movies:["good", "bad"], expanded: false)]
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.yellow
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func setupTabView() {
        super.setupTabView()
        addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: heightAnchor, constant: -70).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(sections[indexPath.section].expanded){
            return 44
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        cell?.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        return cell!
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].movies.count{
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
//    var selectedIndex = -1
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.blue
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.delegate = self
//        cv.dataSource = self
//        return cv
//    }()
//    
//    override func setupTabView() {
//        super.setupTabView()
//        addSubview(collectionView)
//        
//        backgroundColor = UIColor.white
//        
//        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//        collectionView.heightAnchor.constraint(equalTo: heightAnchor, constant: -70).isActive = true
//        
//        collectionView.register(displayCell.self, forCellWithReuseIdentifier: cellId)
//        
//    }
//    
//    let cellId = "cellId"
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        return cell
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! displayCell
//        
//        
//        let index = selectedIndex != -1 ? IndexPath(item: selectedIndex, section: 0) : indexPath
//        let currentCell = collectionView.cellForItem(at: index) as! displayCell
//        
//        if selectedIndex == indexPath.item{
//            selectedIndex = -1
//            cell.botView.isHidden = true
//            
//        }else{
//            if selectedIndex != -1 {
//                currentCell.botView.isHidden = true
//            }
//            selectedIndex = indexPath.item
//            cell.botView.isHidden = false
//        }
//
//        UIView.animate(withDuration: 0.5) {
//
//        }
//        collectionView.reloadData()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if selectedIndex == indexPath.item {
//            return CGSize(width: frame.width, height: 100)
//        }else{
//            return CGSize(width: frame.width, height: 50)
//        }
//    }
}

class displayCell: BaseCell {
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let botView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    let topLabal: UILabel = {
        let lable = UILabel()
        lable.text = "top"
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let botLabal: UILabel = {
        let lable = UILabel()
        lable.text = "bot"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override func setupTabView() {
        super.setupTabView()
        
        addSubview(topView)
        topView.addSubview(topLabal)
        addSubview(botView)
        botView.addSubview(botLabal)
        
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topLabal.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topLabal.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        topLabal.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        topLabal.heightAnchor.constraint(equalTo: topView.heightAnchor).isActive = true
        
        botView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        botView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        botView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        botView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        botLabal.centerXAnchor.constraint(equalTo: botView.centerXAnchor).isActive = true
        botLabal.centerYAnchor.constraint(equalTo: botView.centerYAnchor).isActive = true
        botLabal.widthAnchor.constraint(equalTo: botView.widthAnchor).isActive = true
        botLabal.heightAnchor.constraint(equalTo: botView.heightAnchor).isActive = true
    }
}





