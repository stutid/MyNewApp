//
//  ViewModel.swift
//  MyNewApp
//
//  Created by Stuti on 05/07/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation

class ViewModel {
    
    private var pageIndex: Int = 0
    private var arrData = [MyItemNewsProtocol]()
    var onDataUpdate: (() -> Void)?
    
    init() {
        getNewsResponse(for: pageIndex)
    }
    
    func numberOfItems() -> Int {
        return arrData.count
    }
    
    func getObject(at index: Int) -> MyItemNewsProtocol {
        return arrData[index]
    }
    
    func getNewsResponse(for pageNumber: Int) {
        let newsPath = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=5763846de30d489aa867f0711e2b031c&q=singapore&page=\(pageIndex)"
        let url = URL(string: newsPath)
        Networking().fetchRequest(url: url!) { (data, error) in
            
            guard let content = data else {
                return
            }
            do {
                let jsonDict = try JSONDecoder().decode(News.self, from: content)
                for news in jsonDict.docs {
                    self.arrData.append(news)
                }
                self.onDataUpdate?()
            }
            catch {
            }
        }
    }
    
    func updatePageIndex() {
        pageIndex = pageIndex + 1
        getNewsResponse(for: pageIndex)
    }
    
    
}
