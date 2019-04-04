//
//  BrandsCell.swift
//  HardTask
//
//  Created by Mohamed Nagi on 4/2/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class BrandsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCollectionViewCell", for: indexPath) as! BrandsCollectionViewCell
        instance.getBrands { (returnedArray) in
            let url = URL(string: returnedArray[indexPath.row].image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, _) in
                if data != nil {
                DispatchQueue.main.async {
                    cell.brandsImage.image = UIImage(data: data!)
                }
                }
            }).resume()
        }
            return cell
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()

        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
        instance.getBrands {(returnedArray) in
            brandCollection = returnedArray
            DispatchQueue.main.async {
                self.brandsCollectionView.reloadData()
            }
        }
    }
}
