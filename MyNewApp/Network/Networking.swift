//
//  Networking.swift
//  MyNewApp
//
//  Created by Stuti on 05/07/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation


class Networking {
    
    let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let urlSession = URLSession(configuration: config)
        return urlSession
    }()

    
    func fetchRequest(url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    {
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}
