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
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var codeNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var registeration: UILabel!
    
    var pickerData = [String]()
    var flag = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerView.isHidden = true
        changeUI()
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
        pickerData.removeAll()
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
        pickerData.removeAll()
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
        pickerData.removeAll()
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
        pickerData.removeAll()
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
    
    func changeUI() {
        if Language.currentLanguage() == "en" {
            codeBu.setBackgroundImage(UIImage(named: "list_small_en"), for: .normal)
            countryBu.setBackgroundImage(UIImage(named: "list_en"), for: .normal)
            cityBu.setBackgroundImage(UIImage(named: "list_en"), for: .normal)
            areaBu.setBackgroundImage(UIImage(named: "list_en"), for: .normal)
        } else {
            codeBu.setBackgroundImage(UIImage(named: "list_small_ar"), for: .normal)
            countryBu.setBackgroundImage(UIImage(named: "list_ar"), for: .normal)
            cityBu.setBackgroundImage(UIImage(named: "list_ar"), for: .normal)
            areaBu.setBackgroundImage(UIImage(named: "list_ar"), for: .normal)
            fullName.font = UIFont(name: "GEDinarOne", size: 14)
            password.font = UIFont(name: "GEDinarOne", size: 14)
            codeNumber.font = UIFont(name: "GEDinarOne", size: 14)
            email.font = UIFont(name: "GEDinarOne", size: 14)
            registeration.font = UIFont(name: "GEDinarOne", size: 14)
        }
    }
    
    
    @IBAction func languageAction(_ sender: UIButton) {
        changeUI()
        LocalizationHandler.doTheExchange()
        if Language.currentLanguage() == "ar" {
            Language.setAppLanguage(language: "en-US")
        }else {
            Language.setAppLanguage(language: "ar")
        }
        
        let window = UIApplication.shared.delegate?.window
        let sb = UIStoryboard(name: "Main", bundle: nil)
        window??.rootViewController = sb.instantiateViewController(withIdentifier: "RegisterVC")
    }
}

