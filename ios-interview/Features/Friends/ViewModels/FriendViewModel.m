//
//  FriendViewModel.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import "FriendViewModel.h"
#import "NetworkManager.h"


@interface FriendViewModel() {
    
    NSMutableArray<Friend*> *originalFriends;
    
    Case friendCase;
    
}

- (void) reset;

- (void) fetchFriends1n2WithCompletion:(NSBoolBlock)completionHandler;

- (void) fetchFriends3WithCompletion:(NSBoolBlock)completionHandler;

- (void) fetchFriends4WithCompletion:(NSBoolBlock)completionHandler;

@end

@implementation FriendViewModel

- (instancetype)initWithFriendCase:(Case)friendCase {
    self = [super init];
    if (self) {
//        self.friendCase = friendCase;
        self.friends = [[NSMutableArray alloc] init];
        self.notFriends = [[NSMutableArray alloc] init];
        originalFriends = [[NSMutableArray alloc] init];
        self->friendCase = friendCase;
    }
    return self;
}

/// 使用者資料
- (void)fetchManWithCompletion:(NSBoolBlock)completionHandler {
    __weak FriendViewModel *weakSelf = self;
    [[NetworkManager sharedInstance] fetchManWithCompletion:^(NSDictionary *d, NSError *e) {
        @try {
            Man *man = [[Man alloc] initWithDictionary:d[@"response"][0]];
            weakSelf.man = man;
            completionHandler(true);
        } @catch (NSException *exception) {
            // TODO:
        } @finally {
            // TODO:
        }
    }];
}

- (void)fetchFriendsWithCompletion:(NSBoolBlock)completionHandler {
    switch (friendCase) {
        case CaseOne:
            [self fetchFriends4WithCompletion:completionHandler];
            break;
        case CaseTwo:
            [self fetchFriends1n2WithCompletion:completionHandler];
            break;;
        case CaseThree:
            [self fetchFriends3WithCompletion:completionHandler];
            break;
    }
}

/// Case 1:  無邀請好友列表
- (void) fetchFriends4WithCompletion:(NSBoolBlock)completionHandler {
    
    __weak FriendViewModel *weakSelf = self;
    [[NetworkManager sharedInstance] fetchFriends4WithCompletion:^(NSDictionary *dictionary, NSError *error) {
        FriendViewModel *strongSelf = weakSelf;
        
        if (error != nil || !strongSelf) {
            completionHandler(false);
            return;
        }
        
        NSArray *friends = dictionary[@"response"];
        if ([friends isKindOfClass:[NSArray class]]) {
            for (int i = 0; i < friends.count; i++) {
                Friend *friend = [[Friend alloc] initWithDictionary:friends[i]];
                [strongSelf->originalFriends addObject:friend];
            }
        }
        completionHandler(true);
    }];
}

/// Case 2: 好友列表 1 & 2
- (void) fetchFriends1n2WithCompletion:(NSBoolBlock)completionHandler {
    
    dispatch_group_t group = dispatch_group_create();
    
    NSMutableArray<Friend *> *allFriends = [[NSMutableArray alloc] init];

    dispatch_group_enter(group);
    [[NetworkManager sharedInstance] fetchFriends1WithCompletion:^(NSDictionary *dictionary, NSError *error) {
        
        if (error != nil) {
            dispatch_group_leave(group);
            return;
        }
        
        NSArray *friends = dictionary[@"response"];
        for (int i = 0; i < friends.count; i++) {
            Friend *friend = [[Friend alloc] initWithDictionary:friends[i]];
            [allFriends addObject:friend];
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)));
    
    dispatch_group_enter(group);
    [[NetworkManager sharedInstance] fetchFriends2WithCompletion:^(NSDictionary *dictionary, NSError *error) {
        NSArray *friends = dictionary[@"response"];
        BOOL isSame = NO;
        for (int i = 0; i < friends.count; i++) {
            
            isSame = NO;
            
            Friend *friend = [[Friend alloc] initWithDictionary:friends[i]];
        
            if (allFriends.count == 0) {
                [allFriends addObject:friend];
                continue;
            }
            
            for (int j = 0; j < allFriends.count; j++) {
                if ([allFriends[j].fid isEqual:friend.fid]) {
                    if (allFriends[j].updateDate < friend.updateDate) {
                        allFriends[j] = friend;
                    }
                    isSame = YES;
                    break;
                }
            }
            
            if (!isSame) {
                [allFriends addObject:friend];
            }
        }
        
        dispatch_group_leave(group);
    }];

    __weak FriendViewModel *weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        FriendViewModel *strongSelf = weakSelf;
        
        if (!strongSelf) {
            completionHandler(false);
            return;
        }
        
        [strongSelf reset];
        
        for (int i = 0; i < allFriends.count; i++) {
            if (allFriends[i].status == StatusSend) {
                [strongSelf.notFriends addObject:allFriends[i]];
            } else {
                [strongSelf->originalFriends addObject:allFriends[i]];
                [strongSelf.friends addObject:allFriends[i]];
            }
        }
        
        completionHandler(true);
    });
}

/// Case 3: 好友列表含邀請
- (void) fetchFriends3WithCompletion:(NSBoolBlock)completionHandler {
    
    __weak FriendViewModel *weakSelf = self;
    [[NetworkManager sharedInstance] fetchFriends3WithCompletion:^(NSDictionary *dictionary, NSError *error) {
        FriendViewModel *strongSelf = weakSelf;
        if (error != nil || !strongSelf) {
            completionHandler(false);
            return;
        }
        NSArray *friends = dictionary[@"response"];
        [strongSelf reset];
        for (int i = 0; i < friends.count; i++) {
            Friend *friend = [[Friend alloc] initWithDictionary:friends[i]];
            if (friend.status == StatusSend) {
                [strongSelf.notFriends addObject:friend];
            } else {
                [strongSelf->originalFriends addObject:friend];
                [strongSelf.friends addObject:friend];
            }
        }
        completionHandler(true);
    }];
}

- (void) searchFriendsWithString:(NSString *)searchText completionHandler:(NSBoolBlock)completionHandler {
    if ([searchText isEqualToString:@""]) {
        self.friends = originalFriends;
    } else {
        NSString *filter = [NSString stringWithFormat:@"(name BEGINSWITH[c] '%@')", searchText];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
        self.friends = [NSMutableArray arrayWithArray:[originalFriends filteredArrayUsingPredicate:predicate]];
    }
    completionHandler(true);
}

- (void) reset {
    [self.notFriends removeAllObjects];
    [self.friends removeAllObjects];
    [originalFriends removeAllObjects];
}

@end
