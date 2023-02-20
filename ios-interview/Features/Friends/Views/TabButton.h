//
//  TabButton.h
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabButton : UIButton

@property (nonatomic, assign) bool isHiddenBadge;

- (void) configureWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
