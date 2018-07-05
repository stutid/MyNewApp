//
//  ViewController.swift
//  MyNewApp
//
//  Created by Stuti on 28/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModelObj = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelObj.onDataUpdate = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! CollectionViewCell
        
        if let obj = viewModelObj.getObject(at: indexPath.row) as? NewsModelStruct
        {
            cell.lblTitle.text = "Main: \(obj.title)"
            cell.lblPrice.text = "Snippet: \(obj.subTitle)"
            cell.lblAddress.text = "Source: \(obj.desc)"
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelObj.numberOfItems()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModelObj.updatePageIndex()
    }
}

