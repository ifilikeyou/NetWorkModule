//
//  MarvelResponse.swift
//  NetworkModule
//
//  Created by 朱杰 on 2021/10/17.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
  let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
  let results: [T]
}
