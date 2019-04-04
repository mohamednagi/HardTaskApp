//
//  BestSellerCellModel.swift
//  HardTask
//
//  Created by Mohamed Nagi on 4/1/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class BestSellerCellModel {
    
    var image:String?
    var name:String?
    var price:String?
    var symbol:String?
    
    init(image:String,name:String,price:String,symbol:String) {
        self.image=image
        self.name=name
        self.price=price
        self.symbol=symbol
    }
    
}
