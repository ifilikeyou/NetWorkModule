//
//  NetworkConfig.swift
//  NetworkModule
//
//  Created by 朱杰 on 2022/1/26.
//

import UIKit

/// app 类型
@objc public enum AppType: Int {
    case jtmmManager = 0    // 买买友
    case jtmmGlobal  = 1    // 海外JTMM
    case jtmmAnchor  = 2    // 主播端
    case jtmmSpectator = 3  // 今天买买 观众端
    case vShare = 4         // Vshare
    case cloudShop = 5      // 天狮云购
    case jtmmYHY = 6        // 易瀚永
}

@objc public enum requestSerializerMethod: Int {
    case JSONRequestSerializer = 0
    case HTTPRequestSerializer = 1
}

@objcMembers
public final class NetWorkConfig: NSObject {

    private override init(){}
    
    public override class func copy() -> Any {return NetWorkConfig.shared}
    
    public override class func mutableCopy() -> Any {return NetWorkConfig.shared}
    
    public static let shared: NetWorkConfig = NetWorkConfig()
    
    /// baseURL
    public var baseUrl: String = ""
    
    /// token
    public var userToken: String = ""
    
    /// uid
    public var uid: String = ""
    
    /// Content_Type
    public var Content_Type: String = "application/json"
    
    /// requestSerializer
    public var requestSerializer: requestSerializerMethod = .JSONRequestSerializer
    
    /// appkey
    public var appKey: String = ""
    /// 会议直播appkey
    public var meetingAppKey: String = ""
    
    /// app 类型
    public var appType: AppType = .jtmmManager
    
    /// 直播 baseURL
    public var liveBaseUrl: String = ""
    
    /// HUD
    public var showHUD: () ->(Void) = {()->(Void) in }
    public var dismissHUD: ()->(Void) = {() ->(Void) in}
    
    
    /****************   直销请求头  *************************/
    /// 天狮云购 sign
    public var sign: String = ""
    /// 天狮云购 finalUserId
    public var finalUserId: String = ""
    /// 天狮云购 post.raw paramsJsonString
    public var paramsJsonString: String = ""
    /// accid 加密
    public var encryptAccid: String = ""
    /****************   直销请求头  *************************/
    
    
    /**************** 海外请求头额外需要参数  **********************/
    /// 国家 (海外必传)
    public var shipto: String = ""
    /// 用户选择语言 (海外必传)
    public var language: String = ""
    /// 用户选择货币  (海外必传)
    public var currency: String = ""
    /// 站点 code   (海外必传)
    public var storeCode: String = ""
    /// 默认国家  (海外必传)
    public var defaultshipto: String = ""
    /// 默认语言  (海外必传)
    public var defaultlanguage: String = ""
    /// 默认货币  (海外必传)
    public var defaultcurrency: String = ""
    /// 分享site url (非必传)
    public var siteUrl: String = ""
    /**************** 海外请求头额外需要参数  **********************/
 
    /// 海外请求头配置
    /// - Parameters:
    ///   - shipto: 国家
    ///   - language: 语言
    ///   - currency: 货币
    ///   - storeCode: 站点code
    ///   - defaultshipto: 默认国家
    ///   - defaultlanguage: 默认语言
    ///   - defaultcurrency: 默认货币
    ///   - siteUrl: 分享url
    public func initialized(shipto: String,
                            language: String,
                            currency: String,
                            storeCode: String,
                            defaultshipto: String,
                            defaultlanguage: String,
                            defaultcurrency: String,
                            siteUrl:String = "") {
                             
        NetWorkConfig.shared.shipto = shipto
        NetWorkConfig.shared.language = language
        NetWorkConfig.shared.currency = currency
        NetWorkConfig.shared.storeCode = storeCode
        NetWorkConfig.shared.defaultshipto = defaultshipto
        NetWorkConfig.shared.defaultlanguage = defaultlanguage
        NetWorkConfig.shared.defaultcurrency = defaultcurrency
        NetWorkConfig.shared.siteUrl = siteUrl
    }
}
