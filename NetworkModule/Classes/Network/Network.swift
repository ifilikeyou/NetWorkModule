//
//  Network.swift
//  NetworkModule
//
//  Created by 朱杰 on 2021/10/22.
//

import Foundation
//全局引用swift文件到此模块
@_exported import UIKit
@_exported import Alamofire
@_exported import Moya
@_exported import CryptoSwift
@_exported import Reusable
@_exported import Kingfisher
@_exported import SnapKit


public class Network: NSObject {
    //网络请求单利对象
    public static var share = Network.init()
    
    //是否转圈 失败是否吐司 没有更多数据是否吐司 错误是否日报信息
    public func config(appType app: AppType) {
        
    }
}



//网络连接状态 网速等

public extension Network {
    // MARK: 是否连接到网络  isReachableOnCellular:是否蜂窝网   isReachableOnEthernetOrWiFi:以太网或WiFi
    var isConnectNetwork: Bool {get{return NetworkReachabilityManager()?.isReachable ?? false}}
    
    // MARK: 网络带宽检测
    func downloadSpeed(block: @escaping((_ speed: String) -> ())){
        NetworkSpeed.networkSpeed.downloadSpeed(block: block)
    }
    
}
