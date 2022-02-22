//
//  Comic.swift
//  NetworkModule
//
//  Created by 朱杰 on 2021/10/16.
//

import Foundation

struct Comic: Codable{
    let ID: Int
    var title: String
    let description: String?
    let thumbnail: Thumbnail
    let characters: CharactersInfo
    
    enum Comic: String, CodingKey {
        case ID = "id"
        case title
        case description
        case thumbnail
        case characters
        case dates
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Comic.self)
        try container.encode(ID, forKey: .ID)
        try container.encode(title, forKey: .title)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Comic.self)
        ID = try container.decode(Int.self, forKey: .ID)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String?.self, forKey: .description)
        thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        characters = try container.decode(CharactersInfo.self, forKey: .characters)
    }
}

extension Comic: CustomDebugStringConvertible {
  var debugDescription: String {
    return "<Comic:\(ID)> \(title)"
  }
}

extension Comic {
  struct Thumbnail: Codable {
    let path:String
    let despath: String

    var url: URL {
      return URL(string: path + "" + despath)!
    }
  }
}

extension Comic {
  struct CharactersInfo: Codable {
    let available: Int
    let items: [Character]
  }

  struct Character: Codable {
    let resourceURL: String
    let name: String
  }
}
