////
////  LocalizationHandler.swift
////  HardTaskApp
////
////  Created by Mohamed Nagi on 4/2/19.
////  Copyright © 2019 Mohamed Nagi. All rights reserved.
////
//
import UIKit

class LocalizationHandler: UIViewController {
    class func doTheExchange() {
        exchangeMethodsForClass(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.customLocalizedString(forKey:value:table:)))
    }
    
}


extension Bundle {
   @objc func customLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {
    let currentLanguage =  Language.currentLanguage()
    var bundle = Bundle()
    if let path = Bundle.main.path(forResource: currentLanguage , ofType: "lproj") {
        bundle = Bundle(path: path)!
    } else {
        let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
        bundle = Bundle(path: path!)!
    }
        return bundle.customLocalizedString(forKey: key, value: value, table: tableName)
    }
}

func exchangeMethodsForClass(className:AnyClass, originalSelector:Selector, overrideSelector:Selector) {
    let originalMethod: Method = class_getInstanceMethod(className, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(className, overrideSelector)!
    
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)) {
        class_replaceMethod(className, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod)
    }
}
