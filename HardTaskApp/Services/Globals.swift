//
//  Globals.swift
//  HardTaskApp
//
//  Created by Mohamed Nagi on 4/2/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit


let instance = ServiceLayer()
let appDelegate = UIApplication.shared.delegate as! AppDelegate
var categoryCellCollection = [CategoryCellModel]()
var subCategoryCellCollection = [SubCategoryCellModel]()
var bestSellerCellCollection = [BestSellerCellModel]()
var brandCollection = [BrandModel]()


var codes = [String]()
var countries = [String]()
var cities = [String]()
var areas = [String]()

let defaults = UserDefaults.standard
