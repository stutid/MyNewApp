//
//  ItemsModel.swift
//  MyNewApp
//
//  Created by Stuti on 29/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation

protocol MyItemNewsProtocol {
    var title: String {get set}
//    var subTitle: String {get set}
//    var desc: String {get set}
}

struct Items: Decodable {
    let items: [ItemsModelStruct]
}

struct ItemsModelStruct: Decodable, MyItemNewsProtocol {
    var title: String //title
    var desc: String //address
    var price: Int //price


    private enum CodingKeys: String, CodingKey {
        case title
        case price = "price"
        case desc = "address"
        case location
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Int.self, forKey: .price)
        
        let locations = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        desc = try locations.decode(String.self, forKey: .desc)
    }
}


struct News: Decodable {

    let docs: [NewsModelStruct]
    
    private enum CodingKeys: String, CodingKey {
        case response
        case docs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responses = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        docs = try responses.decode([NewsModelStruct].self, forKey: .docs)
    }
}



struct NewsModelStruct: Decodable, MyItemNewsProtocol {
    var title: String //main
    var desc: String //source
    var subTitle: String //snippet

    private enum CodingKeys: String, CodingKey {
        case title = "main"
        case subTitle = "snippet"
        case desc = "source"
        case headline
    }
    
    init(from decoder: Decoder) throws {

    let container = try decoder.container(keyedBy: CodingKeys.self)

    subTitle = try container.decode(String.self, forKey: .subTitle)
//    desc = try container.decode(String.self, forKey: .desc)
    if let localDescription = try? container.decode(String.self, forKey: .desc)
    {
        desc = localDescription
    }
    else
    {
        desc = "Default Source"
    }
        
        
        
        
    let headlines = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .headline)
    title = try headlines.decode(String.self, forKey: .title)

    }
    
    
}



























