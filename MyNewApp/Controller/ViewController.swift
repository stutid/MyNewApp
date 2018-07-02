//
//  ViewController.swift
//  MyNewApp
//
//  Created by Stuti on 28/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var pageIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    var arrData = [MyItemNewsProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResponse()
        getNewsResponse(for: pageIndex)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! CollectionViewCell
        
        
        
        
        if let obj = arrData[indexPath.row] as? ItemsModelStruct {
//        do {
//            let imageURL = URL(string: obj.imageData?.url ?? "")
//            let dataImage = try Data(contentsOf: imageURL!)
//            cell.imgView.image = UIImage(data: dataImage)
//        }
//        catch {
//            print("Error converting image URL to image Data")
//        }
        
        cell.lblTitle.text = "Title: \(obj.title)"
        cell.lblPrice.text = "Price: \(obj.price)"
        cell.lblAddress.text = "Address: \(obj.desc)"
        }
        else if let obj = arrData[indexPath.row] as? NewsModelStruct
        {
            cell.lblTitle.text = "Main: \(obj.title)"
            cell.lblPrice.text = "Snippet: \(obj.subTitle)"
            cell.lblAddress.text = "Source: \(obj.desc)"
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageIndex = pageIndex + 1
        getNewsResponse(for: pageIndex)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0 {
//            return CGSize(width: 100, height: 100)
//        }
//        return CGSize(width: 200, height: 200)
//    }
    
    
    
    
    
    func getResponse() {
        
        let flatPath = "https://private-91146-mobiletask.apiary-mock.com/realestates"
        let url = URL(string: flatPath)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                return
            }
            
            guard let content = data else {
                print("Data not available")
                return
            }
            
            do {
                
                let jsonData = try JSONDecoder().decode(Items.self, from: content)
                for item in jsonData.items {
                    self.arrData.append(item)
                }
            }
            catch {
                print("Error while decoding data from JSON")
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        task.resume()
    }
    
    
    func getNewsResponse(for pageNumber: Int) {
        let newsPath = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=5763846de30d489aa867f0711e2b031c&q=singapore&page=\(pageIndex)"
        let url = URL(string: newsPath)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                return
            }
            
            guard let content = data else {
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(News.self, from: content)
                for news in jsonData.docs {
                    self.arrData.append(news)
                }
            }
            catch {
                print("Error while decoding news data")
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        task.resume()
        
        
        
        
        
    }
    
    
    
    
    
}

