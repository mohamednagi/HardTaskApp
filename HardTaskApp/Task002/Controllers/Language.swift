//
//  Language.swift
//  HardTaskApp
//
//  Created by Mohamed Nagi on 4/2/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import Foundation


class Language {
    
    class func currentLanguage() -> String {
        let languages = defaults.object(forKey: "AppleLanguages") as! [String]
        let firstLanguage = languages.first
        return firstLanguage!
    }
    
    class func setAppLanguage(language:String) {
        defaults.set([language, currentLanguage()], forKey: "AppleLanguages")
        defaults.synchronize()
    }
    
}
