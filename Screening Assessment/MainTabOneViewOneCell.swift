//
//  MainTabOneViewOneCell.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/12/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class MainTabOneViewOneCell: BaseCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    static var user = User()
    
    let selectColorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Color", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.isEnabled = true
        return button
    }()
    
    var mainTabOneController: MainTabOneController?
    
    lazy var codeInputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter 4 Digit Code"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else{
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 4
    }
    
    
    let nameInputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
        
    //this avariable is for select color button
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    override func setupTabView() {
        super.setupTabView()
        
        backgroundColor = UIColor.white
        
        setupTapOneInputForms()
        
        selectColorButton.addTarget(self, action: #selector(handleSelectColor), for: .touchUpInside)
        
        codeInputTextField.addTarget(self, action: #selector(handleCodeEdited), for: .editingChanged)
        nameInputTextField.addTarget(self, action: #selector(handleNameEdited), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetTextField), name: NSNotification.Name(rawValue: "resetTextField"), object: nil)
        
    }
    
    func resetTextField(){
        nameInputTextField.text = ""
        codeInputTextField.text = ""
        
        colorPickerView.selectRow(0, inComponent: 0, animated: false)
        colorPickerView.reloadAllComponents()
        selectColorButton.setTitle(colors[0], for: .normal)
    }
    
    func handleCodeEdited(){
        MainTabOneViewOneCell.user.code = codeInputTextField.text
        if codeInputTextField.text?.characters.count == 4{
            let name = Notification.Name("codeGood")
            NotificationCenter.default.post(name: name, object: nil)
        }else{
            let name = Notification.Name("codeBad")
            NotificationCenter.default.post(name: name, object: nil)
        }
        
    }
    
    func handleNameEdited(){
        MainTabOneViewOneCell.user.name = nameInputTextField.text
        
        if nameInputTextField.text?.characters.count != 0 {
            
            let name = Notification.Name("nameGood")
            NotificationCenter.default.post(name: name, object: nil)
        }else{
            
            let name = Notification.Name("nameBad")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
    let colors = ["Select Color", "Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    
    lazy var colorPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor.white
        picker.showsSelectionIndicator = true
        return picker
    }()
    
    let blackView = UIView()
    let blackCoverView = UIView()
    
    func handleSelectColor() {
        
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackCoverView.backgroundColor = UIColor.black
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            collectionView.addSubview(blackCoverView)
            collectionView.addSubview(doneButton)
            
            let height: CGFloat = 300
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackCoverView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 40)
            doneButton.frame = CGRect(x: window.frame.width - 60, y: -5, width: 60, height: 40)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        }
        
        presentColorsListPicker()
    }
    
    func presentColorsListPicker() {
        collectionView.addSubview(colorPickerView)
        
        colorPickerView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        colorPickerView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        colorPickerView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        colorPickerView.heightAnchor.constraint(equalTo: collectionView.heightAnchor, constant: -60).isActive = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        MainTabOneViewOneCell.user.color = colors[row]
        
        if row != 0{
            let name = Notification.Name("colorGood")
            NotificationCenter.default.post(name: name, object: nil)
        }else{
            let name = Notification.Name("colorBad")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
    func handleDoneButton(){
        handleDismiss()
    }
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        
        return button
    }()
    
    func handleDismiss(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
                
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }, completion: nil)
        
        let index = colorPickerView.selectedRow(inComponent: 0)
        
        selectColorButton.setTitle(colors[index], for: .normal)
    }
    
    let textBottomLineOne: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let textBottomLineTwo: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    func setupTapOneInputForms(){
        
        addSubview(selectColorButton)
        addSubview(nameInputTextField)
        addSubview(codeInputTextField)
        addSubview(textBottomLineOne)
        addSubview(textBottomLineTwo)
        
        selectColorButton.topAnchor.constraint(equalTo: centerYAnchor, constant: -250).isActive = true
        selectColorButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectColorButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        selectColorButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        codeInputTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        codeInputTextField.topAnchor.constraint(equalTo: selectColorButton.bottomAnchor, constant: 50).isActive = true
        codeInputTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -150).isActive = true
        codeInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textBottomLineOne.bottomAnchor.constraint(equalTo: codeInputTextField.bottomAnchor).isActive = true
        textBottomLineOne.leftAnchor.constraint(equalTo: codeInputTextField.leftAnchor).isActive = true
        textBottomLineOne.widthAnchor.constraint(equalTo: codeInputTextField.widthAnchor).isActive = true
        textBottomLineOne.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        nameInputTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameInputTextField.topAnchor.constraint(equalTo: codeInputTextField.bottomAnchor, constant: 50).isActive = true
        nameInputTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -150).isActive = true
        nameInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textBottomLineTwo.bottomAnchor.constraint(equalTo: nameInputTextField.bottomAnchor).isActive = true
        textBottomLineTwo.leftAnchor.constraint(equalTo: nameInputTextField.leftAnchor).isActive = true
        textBottomLineTwo.widthAnchor.constraint(equalTo: nameInputTextField.widthAnchor).isActive = true
        textBottomLineTwo.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
}
