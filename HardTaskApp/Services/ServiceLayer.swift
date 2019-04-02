//
//  ServiceLayer.swift
//  HardTask
//
//  Created by Mohamed Nagi on 3/31/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit
import WebKit

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

class ServiceLayer {
    
    var categoriesCollectionText = [String]()
    var categoriesCollectionId = [Int]()
    
    func setUpCategoryCell(completionHandler: @escaping (_ array:[CategoryCellModel]) -> ()) {
        let api = "http://souq.hardtask.co/app/app.asmx/GetCategories?categoryId=0&countryId=1"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        DispatchQueue.main.async {
                            for result in json {
                                guard let englishTitle = result["TitleEN"] as? String else {return}
                                guard let categoryImage = result["Photo"] as? String else {return}
                                guard let categoryId = result["Id"] as? Int else {return}
                                self.categoriesCollectionText.append(englishTitle)
                                self.categoriesCollectionId.append(categoryId)
                                let obj = CategoryCellModel(image: categoryImage, text: englishTitle, id: categoryId)
                                categoryCellCollection.append(obj)
                            }
                            completionHandler(categoryCellCollection)
                        }
                    } else {
                        print("No Data Returned")
                        return
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    
    func setUpSubcategoryCell(index:Int, completionHandler: @escaping (_ array:[SubCategoryCellModel]) -> ()) {
        let api = "http://souq.hardtask.co/app/app.asmx/GetCategories?categoryId=\(index)&countryId=1"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        DispatchQueue.main.async {
                            for result in json {
                                
                                guard let subCategories = result["SubCategories"] as? [String:AnyObject] else {return}
                                guard let englishSubTitle = subCategories["TitleEN"] as? String else {return}
                                guard let subCategoryImage = subCategories["Photo"] as? String else {return}
                                self.categoriesCollectionText.append(englishSubTitle)
                                let obj = SubCategoryCellModel(image: subCategoryImage, text: englishSubTitle)
                                subCategoryCellCollection.append(obj)
                            }
                            completionHandler(subCategoryCellCollection)
                        }
                    } else {
                        print("No Data Returned")
                        return
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    func getCode(completionHandler: @escaping (_ array:[String]) -> ()) {
        let api = "https://www.salonidepot.com/app/app.asmx/GetCountries"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        for result in json {
                            guard let code = result["Code"] as? String else {return}
                            codes.append(code)
                        }
                        completionHandler(codes)
                    } else {
                        print("No data")
                        return
                    }
                } catch {
                    print(error.localizedDescription as Any)
                }
            }
            }.resume()
    }
    
    func getCountry(completionHandler: @escaping (_ array:[String]) -> ()) {
        let api = "https://www.salonidepot.com/app/app.asmx/GetCountries"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        for result in json {
                            guard let country = result["TitleEN"] as? String else {return}
                            countries.append(country)
                        }
                        completionHandler(countries)
                    } else {
                        print("No data")
                        return
                    }
                } catch {
                    print(error.localizedDescription as Any)
                }
            }
            }.resume()
    }
    
    func getCity(completionHandler: @escaping (_ array:[String]) -> ()) {
        let api = "https://www.salonidepot.com/app/app.asmx/GetCities?countryId=1"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        for result in json {
                            guard let city = result["TitleEN"] as? String else {return}
                            cities.append(city)
                        }
                        completionHandler(cities)
                    } else {
                        print("No data")
                        return
                    }
                } catch {
                    print(error.localizedDescription as Any)
                }
            }
            }.resume()
    }
    
    func getArea(completionHandler: @escaping (_ array:[String]) -> ()) {
        let api = "https://www.salonidepot.com/app/app.asmx/GetAreas?cityId=1"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        for result in json {
                            guard let area = result["TitleEN"] as? String else {return}
                            areas.append(area)
                        }
                        completionHandler(areas)
                    } else {
                        print("No data")
                        return
                    }
                } catch {
                    print(error.localizedDescription as Any)
                }
            }
            }.resume()
    }
    
    func getTerms(webView:WKWebView) {
        let api = "https://www.termsfeed.com/blog/sample-terms-and-conditions-template/"
        let url = URL(string: api)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func getBestSellers(completionHandler: @escaping (_ array:[BestSellerCellModel]) -> ()) {
        let api = "https://www.salonidepot.com/app/app.asmx/GetBestSellers?pageIndex=-1&loginUserId=0&countryId=1&currencyId=1"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        DispatchQueue.main.async {
                            for result in json {
                                guard let englishTitle = result["TitleEN"] as? String else {return}
                                guard let price = result["Price"] as? String else {return}
                                guard let SymbolEN = result["SymbolEN"] as? String else {return}
                                guard let Photo = result["Photo"] as? String else {return}
                                let obj = BestSellerCellModel(image: Photo, name: englishTitle, price: price, symbol: SymbolEN)
                                bestSellerCellCollection.append(obj)
                            }
                            completionHandler(bestSellerCellCollection)
                        }
                    } else {
                        print("No data")
                        return
                    }
                } catch {
                    print(error.localizedDescription as Any)
                }
            }
            }.resume()
    }
    
    func getBrands(completionHandler: @escaping (_ array:[BrandModel]) -> ()) {
        let api = "https://www.salonidepot.com/app/app.asmx/GetBrands?pageIndex=-1&userId=0&countryId=1&currencyId=1"
        let url = URL(string: api)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    if (data?.count)! > 0 {
                        guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] else {return}
                        DispatchQueue.main.async {
                            for result in json {
                                guard let Photo = result["Photo"] as? String else {return}
                                let obj = BrandModel(image: Photo)
                                brandCollection.append(obj)
                            }
                            completionHandler(brandCollection)
                        }
                    } else {
                        print("No data")
                        return
                    }
                } catch {
                    print(error.localizedDescription as Any)
                }
            }
            }.resume()
    }
}

