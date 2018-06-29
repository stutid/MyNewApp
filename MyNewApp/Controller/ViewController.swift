//
//  ViewController.swift
//  MyNewApp
//
//  Created by Stuti on 28/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrData = [ItemsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getResponse()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! CollectionViewCell
        let obj = arrData[indexPath.row]
        
        do {
            let imageURL = URL(string: obj.imageData?.url ?? "")
            let dataImage = try Data(contentsOf: imageURL!)
            cell.imgView.image = UIImage(data: dataImage)
        }
        catch {
            print("Error converting image URL to image Data")
        }
        
        cell.lblTitle.text = "Title: \(obj.title ?? "")"
        cell.lblPrice.text = "Price: \(obj.price ?? 0)"
        cell.lblAddress.text = "Address: \(obj.address ?? "")"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    
    func getResponse() {
        let path = "https://private-91146-mobiletask.apiary-mock.com/realestates"
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
                            let itemsObj = ItemsModel(items)
                            self.arrData.append(itemsObj)
                        }
                    }
                }
            }
            catch {
                print("Error while serializing data from JSON to Dictionary")
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        task.resume()
    }
}

