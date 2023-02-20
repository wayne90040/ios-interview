//
//  Man.h
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Man : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *kokoId;

- (instancetype)initWithDictionary: (NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
