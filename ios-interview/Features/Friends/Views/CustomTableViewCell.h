//
//  CustomTableViewCell.h
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/16.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell

+ (NSString*) identifier;

- (void) configureWithFriend:(Friend*)friend;

@end

NS_ASSUME_NONNULL_END
