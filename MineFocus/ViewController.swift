//
//  ViewController.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var layoutType: UITextField!

    @IBOutlet weak var buttonSize: UITextField!
    
    var layoutPicker: UIPickerView?
    var buttonSizePicker: UIPickerView?
    
    var keyboardTool: PacteraPickerTool?
    var layoutArray = ["TwoColumnWithoutMerge","TwoColumnWithFristMerge"]
    var buttonSizeArray = ["Big","Medium","Small"]
    
    var selectedValue: String?
    var selectedPickerViewTag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ポータルタイプの設置
        let portalView = PortalTypeView.portalTypeView(layoutType: PortalTypeButtonLayoutType.TwoColumnWithoutMerge)
//        portalView.backgroundColor = UIColor.lightGray
        portalView.frame = CGRect(origin: CGPoint(x: 0, y: 200), size: portalView.frame.size)
        
        view.addSubview(portalView)
        
        // For Testing
        layoutPicker = UIPickerView()
        layoutPicker?.showsSelectionIndicator = true
        layoutPicker?.delegate = self
        layoutPicker?.dataSource = self
        layoutPicker?.tag = 1
        
        buttonSizePicker = UIPickerView()
        buttonSizePicker?.showsSelectionIndicator = true
        buttonSizePicker?.delegate = self
        buttonSizePicker?.dataSource = self
        buttonSizePicker?.tag = 2
        
        keyboardTool = PacteraPickerTool(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        keyboardTool?.delegate = self
        
        buttonSize.isHidden = true
        
        layoutType.inputView = layoutPicker
        buttonSize.inputView = buttonSizePicker
        
        layoutType.inputAccessoryView = keyboardTool
        buttonSize.inputAccessoryView = keyboardTool
        
    }
}

// MARK: - For tesing
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = selectedValue
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return layoutArray.count
        }else {
            return buttonSizeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        selectedPickerViewTag = pickerView.tag
        
        if pickerView.tag == 1 {
            return layoutArray[row]
        }else{
            return buttonSizeArray[row]
        }
    }
}

extension ViewController: KeyboardToolDelegate{
    func buttonClick(keyboardToolButtonType: KeyboardToolButtonType) {
        
        switch keyboardToolButtonType {
        case KeyboardToolButtonType.KeyboardToolButtonDone:
            if selectedPickerViewTag == 1 {
                selectedValue = layoutArray[(layoutPicker?.selectedRow(inComponent: 0))!]
            }else{
                selectedValue = buttonSizeArray[(layoutPicker?.selectedRow(inComponent: 0))!]
            }
        case KeyboardToolButtonType.KeyboardToolButtonCancel:
            break
        }
        
        view.endEditing(true)
    }
}

