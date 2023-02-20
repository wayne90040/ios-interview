//
//  FriendViewModel.h
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import <Foundation/Foundation.h>
#import "Man.h"
#import "Friend.h"
#import "Case.h"

typedef void (^NSBoolBlock)(BOOL success);

NS_ASSUME_NONNULL_BEGIN

@interface FriendViewModel : NSObject

@property (nonatomic, strong) Man *man;

@property (nonatomic, strong) NSMutableArray<Friend*> *notFriends;

@property (nonatomic, strong) NSMutableArray<Friend*> *friends;

- (instancetype) initWithFriendCase:(Case)friendCase;

/// 使用者資料
- (void) fetchManWithCompletion:(NSBoolBlock)completionHandler;

/// 好友列表
- (void) fetchFriendsWithCompletion:(NSBoolBlock)completionHandler;

/// 搜尋
- (void) searchFriendsWithString:(NSString*)searchText completionHandler:(NSBoolBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
