//
//  Friend.h
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Status) {
    StatusSend = 0,
    StatusDone,
    StatusInviting
};

NS_ASSUME_NONNULL_BEGIN

@interface Friend : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) Status status;

@property (nonatomic, assign) BOOL isTop;

@property (nonatomic, strong) NSString *fid;

@property (nonatomic, assign) NSInteger updateDate;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
