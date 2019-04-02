//
//  CellModel.swift
//  HardTask
//
//  Created by Mohamed Nagi on 3/31/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class CategoryCellModel {
    let image:String
    let text:String
    let id:Int
    
    init(image:String,text:String,id:Int) {
        self.image=image
        self.text=text
        self.id=id
    }
}
