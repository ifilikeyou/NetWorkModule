//
//  ImgurResponse.swift
//  Alamofire
//
//  Created by 朱杰 on 2021/10/22.
//

import Foundation

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
