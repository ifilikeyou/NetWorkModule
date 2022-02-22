//
//  NetworkSpeedOC.h
//  NetworkModule
//
//  Created by 朱杰 on 2022/1/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const DownloadNetworkSpeedNotificationKey;
extern NSString *const UploadNetworkSpeedNotificationKey;
extern NSString *const NetworkSpeedNotificationKey;

@interface NetworkSpeedOC : NSObject

@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;

+ (NetworkSpeedOC *)share;

- (void)startNetworkSpeedMonitor;
- (void)stopNetworkSpeedMonitor;

@end

NS_ASSUME_NONNULL_END
