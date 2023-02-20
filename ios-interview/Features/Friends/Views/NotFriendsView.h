//
//  NotFriendsView.h
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/19.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotFriendsView : UIView

- (void) configureWithFriend:(Friend*)friend;

@end

NS_ASSUME_NONNULL_END
