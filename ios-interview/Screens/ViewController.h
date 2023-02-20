//
//  ViewController.h
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/15.
//

#import <UIKit/UIKit.h>
#import "MoneyViewController.h"
#import "FriendViewController.h"
#import "KoKoViewController.h"
#import "RecordViewController.h"
#import "SettingViewController.h"
#import "Case.h"

@interface ViewController : UITabBarController

@property (assign, nonatomic) Case friendCase;

- (instancetype)initWithFriendCase:(Case)friendCase;

@end

