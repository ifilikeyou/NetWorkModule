//
//  Marvel.swift
//  NetworkModule
//
//  Created by 朱杰 on 2021/10/16.
//

import Foundation

public enum Marvel {
  static private let privateKey = "YOUR PRIVATE KEY"
  static private let publicKey = "YOUR PUBLIC KEY"

  case comics
}


extension Marvel: TargetType {
    public var baseURL: URL {
        return URL(string: "https://live-dev.jtmm.com")!
    }
    
    public var path: String {
        switch self {
        case .comics: return "/comics"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .comics: return .get
        }
    }
    
    public var sampleData: Data {
      return Data()
    }
    
    public var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5

        let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash] as [String : Any]
        switch self {
        case .comics:
          return .requestParameters(parameters: ["format": "comic",
                                                 "formatType": "comic",
                                                 "orderBy": "-onsaleDate",
                                                 "dateDescriptor": "lastWeek",
                                                 "limit": 50] + authParams,
                                    encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType{
        return .successCodes;
    }
    
}
