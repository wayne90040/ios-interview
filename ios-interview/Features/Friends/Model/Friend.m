//
//  Friend.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"] ? dictionary[@"name"] : @"";
        self.isTop = [dictionary[@"isTop"] isEqual: @"1"] ? YES : NO;
        self.fid = dictionary[@"fid"] ? dictionary[@"fid"]  : @"";
        
        NSInteger status = [dictionary[@"status"] integerValue];
        if (status == 0) {
            self.status = StatusSend;
        } else if (status == 1) {
            self.status = StatusDone;
        } else {
            self.status = StatusInviting;
        }
        
        NSString *updateDate = dictionary[@"updateDate"];
        updateDate = [updateDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
        self.updateDate = updateDate ? [updateDate integerValue] : 0;
    }
    return self;
}

@end
