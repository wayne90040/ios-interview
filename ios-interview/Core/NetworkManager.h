//
//  NetworkManager.h
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/16.
//

#import <Foundation/Foundation.h>
typedef void (^NSDictionaryNSErrorBlock)(NSDictionary *dictionary, NSError *error);

@interface NetworkManager: NSObject

+ (NetworkManager*)sharedInstance;

/// 使用者資料
- (void) fetchManWithCompletion:(NSDictionaryNSErrorBlock)completionHandler;

/// 無邀請好友列表
- (void) fetchFriends4WithCompletion:(NSDictionaryNSErrorBlock)completionHandler;

/// 好友列表 1
- (void) fetchFriends1WithCompletion:(NSDictionaryNSErrorBlock)completionHandler;

/// 好友列表 2
- (void) fetchFriends2WithCompletion:(NSDictionaryNSErrorBlock)completionHandler;


/// 好友列表含邀請
- (void) fetchFriends3WithCompletion:(NSDictionaryNSErrorBlock)completionHandler;

@end
