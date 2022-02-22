//
//  NetworkSpeed.swift
//  NetworkModule
//
//  Created by 朱杰 on 2022/1/24.
//  

import Foundation

public class NetworkSpeed :NSObject {
    
    @objc public static let networkSpeed = NetworkSpeed()
    
    typealias speedBlock = (_ speed: String) -> ()

    //默认获取下行速度
    func downloadSpeed(block: @escaping((_ speed: String) -> ())){
        start()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10){
            self.stop()
        }
        //回调赋值 OC回调函数  再次回调Network
        downloadBlock = { speed in
            block(speed)
        }

    }

    //下行
     var downloadBlock:speedBlock?

    //上行
     var uploadBlock:speedBlock?

    //开始监听网速
    func start() -> Void {
        NetworkSpeedOC.share().startNetworkSpeedMonitor()
    }

    //结束监听网速
    func stop() -> Void {
        NetworkSpeedOC.share().stopNetworkSpeedMonitor()
    }


    //OC回调 赋值下行
    @objc public func setDownloadNetworkSpeed(speed:String){
        downloadBlock?(speed)
    }

    //OC回调 赋值上行
    @objc public func setUploadNetworkSpeed(speed:String){
        uploadBlock?(speed)
    }
    
}
