//
//  BaseCell.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/10/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabView(){
        
    }
    
}
