//
//  RegisterationView.swift
//  HardTask
//
//  Created by Mohamed Nagi on 4/1/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class RegisterationView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var codeBu: UIButton!
    @IBOutlet weak var countryBu: UIButton!
    @IBOutlet weak var cityBu: UIButton!
    @IBOutlet weak var areaBu: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData = [String]()
    var flag = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        hideKeyboardWhenTappedAround()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch flag {
        case "code":
            codeBu.setTitle(pickerData[row], for: .normal)
        case "country":
            countryBu.setTitle(pickerData[row], for: .normal)
        case "city":
            cityBu.setTitle(pickerData[row], for: .normal)
        case "area":
            areaBu.setTitle(pickerData[row], for: .normal)
        default:
            codeBu.setTitle("", for: .normal)
            countryBu.setTitle("", for: .normal)
            cityBu.setTitle("", for: .normal)
            areaBu.setTitle("", for: .normal)
        }
        pickerView.isHidden = true
    }
    
    /// keyboard hide when user tap any where of screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    ///end editing with keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
        pickerView.isHidden = true
    }
    
    @IBAction func codeAction(_ sender: UIButton) {
        flag = "code"
        instance.getCode { (returnedArray) in
            self.pickerData = returnedArray
            DispatchQueue.main.async {
                self.pickerView.reloadComponent(0)
            }
        }
        pickerView.isHidden = false
    }
    @IBAction func countryAction(_ sender: UIButton) {
        flag = "country"
        instance.getCountry { (returnedArray) in
            self.pickerData = returnedArray
            DispatchQueue.main.async {
                self.pickerView.reloadComponent(0)
            }
        }
        pickerView.isHidden = false
    }
    @IBAction func cityAction(_ sender: UIButton) {
        flag = "city"
        instance.getCity { (returnedArray) in
            self.pickerData = returnedArray
            DispatchQueue.main.async {
                self.pickerView.reloadComponent(0)
            }
        }
        pickerView.isHidden = false
    }
    @IBAction func areaAction(_ sender: UIButton) {
        flag = "area"
        instance.getArea { (returnedArray) in
            self.pickerData = returnedArray
            DispatchQueue.main.async {
                self.pickerView.reloadComponent(0)
            }
        }
        pickerView.isHidden = false
        
    }
    @IBAction func termsAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = storyboard.instantiateViewController(withIdentifier: "WebView") as! WebView
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    
    @IBAction func languageAction(_ sender: UIButton) {
        
    }
    
}

