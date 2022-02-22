//
//  Card.swift
//  Alamofire
//
//  Created by 朱杰 on 2021/10/22.
//

import Foundation

struct Card: Codable, CustomDebugStringConvertible {
  let deletehash: String
  let link: URL

  var debugDescription: String {
    return "<UploadResult:\(deletehash)> \(link)"
  }
}
