//
//  Extensions.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/11/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder(color: UIColor){
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        let width = CGFloat(1.0)
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width))
        
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}

