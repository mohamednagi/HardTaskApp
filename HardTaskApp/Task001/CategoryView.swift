//
//  ViewController.swift
//  HardTask
//
//  Created by Mohamed Nagi on 3/31/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class CategoryView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var CategoriesCollection: UICollectionView!
    
   override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func drawingBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "top_bar_bg"), for: .default)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let titleIcon = UIImage(named: "top_bar_logo")
        imageView.image = titleIcon
        navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingBar()

        instance.setUpCategoryCell {(returnedArray) in
            categoryCellCollection = returnedArray
            DispatchQueue.main.async {
                self.CategoriesCollection.reloadData()
            }
        }
        
        CategoriesCollection.delegate = self
        CategoriesCollection.dataSource = self
        CategoriesCollection.reloadData()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCellCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            instance.setUpCategoryCell { (returnedArray) in
            cell.categoryText.text = returnedArray[indexPath.row].text
            let url = URL(string: returnedArray[indexPath.row].image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, _) in
                if data != nil {
                DispatchQueue.main.async {
                    cell.categoryImage.image = UIImage(data: data!)
                }
                }
            }).resume()
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sentObject = SentModel(id: instance.categoriesCollectionId[indexPath.row], name: instance.categoriesCollectionText[indexPath.row])
        performSegue(withIdentifier: "showDetails", sender: sentObject)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dis = segue.destination as? SubCategoryView {
        if let sub = sender as? SentModel {
            dis.recieved = sub
        }
    }
    }


}

