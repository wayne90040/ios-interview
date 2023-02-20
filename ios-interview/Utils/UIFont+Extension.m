//
//  UIFont+Extension.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/17.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extensions)

+ (UIFont *)pingFangMediumWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangTC-Medium" size:fontSize];
}

+ (UIFont *)pingFangRegularWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangTC-Regular" size:fontSize];
}

@end
