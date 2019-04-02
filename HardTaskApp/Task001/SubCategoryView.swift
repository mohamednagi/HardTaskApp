//
//  SubCategoryView.swift
//  HardTask
//
//  Created by Mohamed Nagi on 3/31/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class SubCategoryView: CategoryView {
    
    @IBOutlet weak var subCategoriesCollection: UICollectionView!
    
    var recieved:SentModel?
    
    override func viewDidLoad() {
        drawingBar()
        subCategoriesCollection.delegate = self
        subCategoriesCollection.dataSource = self
        
    }
    
    override func drawingBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "top_bar_bg"), for: .default)
        navigationItem.title = recieved?.name
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryCellCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoriesCollectionCell", for: indexPath) as! SubCategoriesCollectionCell
        
        instance.setUpSubcategoryCell(index: (recieved?.id)!) { (returnedArray) in
            cell.textLabel.text = returnedArray[indexPath.row].text
            let url = URL(string: returnedArray[indexPath.row].image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, _) in
                if (data?.count)! > 0 {
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                }
                }
            }).resume()
        }
        return cell
    }
    
}
