//
//  ViewController.swift
//  MyNewApp
//
//  Created by Stuti on 28/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    let path = "https://private-91146-mobiletask.apiary-mock.com/realestates"
    var arrData = [ItemsModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResponse()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! CollectionViewCell
        cell.contentView.backgroundColor = UIColor.red
        cell.imgView.backgroundColor = UIColor.blue
        let obj = arrData[indexPath.row]
        cell.lblTitle.text = "Title: \(obj.title ?? "")"
        cell.lblPrice.text = "Price: \(obj.price ?? 0)"
        cell.lblAddress.text = "Address: U.S.A."
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    
    func getResponse() {
        
        let url = URL(string: path)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                return
            }
            
            guard let content = data else {
                print("Data not available")
                return
            }
            
            do {
                if let dict = try JSONSerialization.jsonObject(with: content, options: []) as? [String: Any] {
                    if let arr = dict["items"] as? [[String: Any]] {
                        for items in arr {
                            let itemsObj = ItemsModel()
//                            itemsObj.imageName = items[""] as? String
                            itemsObj.title = items["title"] as? String
                            itemsObj.price = items["price"] as? Int
//                            itemsObj.address = items[""] as? String
                            self.arrData.append(itemsObj)
                        }
                    }
                }
            }
            catch {
                
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        task.resume()
        
        
    }
    
    
    

}

