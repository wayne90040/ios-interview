//
//  Man.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import "Man.h"

@implementation Man

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"] ? dictionary[@"name"] : @"";
        self.kokoId = dictionary[@"kokoid"] ? dictionary[@"kokoid"] : @"";
    }
    return self;
}

@end
