//
//  SellersAndBrands.swift
//  HardTask
//
//  Created by Mohamed Nagi on 4/1/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class SellersAndBrands: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instance.getBestSellers {(returnedArray) in
            bestSellerCellCollection = returnedArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bestSellerCellCollection.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "BEST SELLERS"
        }else {
            return "BRANDS"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SellersCell", for: indexPath) as! SellersCell
            instance.getBestSellers {(returnedArray) in
                cell.sellerName.text = returnedArray[indexPath.row].name
                cell.sellerPrice.text = returnedArray[indexPath.row].price! + returnedArray[indexPath.row].symbol!
                let url = URL(string: returnedArray[indexPath.row].image!)
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, _) in
                    if data != nil {
                    DispatchQueue.main.async {
                        cell.sellerImage.image = UIImage(data: data!)
                    }
                    }
                }).resume()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandsCell", for: indexPath) as! BrandsCell
            return cell
        }
        
    }
}
