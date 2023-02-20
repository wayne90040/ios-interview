//
//  ViewController.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/15.
//

#import "ViewController.h"
#import "UIColor+ColorExtensions.h"

@interface ViewController () {
    
}

- (void) setupWithFriendCase:(Case)friendCase;

- (void) setupKoKoButton;

- (UIViewController*) createTabBarItem:(UIViewController *)root setBarName:(NSString *)barName setBarImage:(NSString *)imageName;

@end

@implementation ViewController

- (instancetype)initWithFriendCase:(Case)friendCase {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self setupWithFriendCase:friendCase];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor systemBackgroundColor]];
    [self.tabBar setBackgroundColor:[UIColor whiteTwo]];
    [self.tabBar setTintColor:[UIColor hotPink]];
    [self setupKoKoButton];
}

- (void) setupWithFriendCase:(Case)friendCase {
    [self setViewControllers:[NSArray arrayWithObjects:
                              [self createTabBarItem:[[MoneyViewController alloc] init] setBarName:@"" setBarImage:@"icon-money"],
                              [self createTabBarItem:[[FriendViewController alloc] initWithFriendCase:friendCase] setBarName:@"" setBarImage:@"icon-friends"],
                              [self createTabBarItem:[[KoKoViewController alloc] init] setBarName:@"" setBarImage:@""],
                              [self createTabBarItem:[[RecordViewController alloc] init] setBarName:@"" setBarImage:@"icon-record"],
                              [self createTabBarItem:[[SettingViewController alloc] init] setBarName:@"" setBarImage:@"icon-setting"],
                              nil]];
}

- (void) setupKoKoButton {
    UIButton *kokoButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [kokoButton setImage:[UIImage imageNamed:@"icon-koko"] forState:UIControlStateNormal];
    [kokoButton setCenter:[self.tabBar center]];
    [kokoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:kokoButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [kokoButton.widthAnchor constraintEqualToConstant:85],
        [kokoButton.heightAnchor constraintEqualToConstant:85],
        [kokoButton.centerXAnchor constraintEqualToAnchor:self.tabBar.centerXAnchor],
        [kokoButton.topAnchor constraintEqualToAnchor:self.tabBar.topAnchor constant:-20]
    ]];
}

- (UIViewController*) createTabBarItem:(UIViewController *)root setBarName:(NSString *)barName setBarImage:(NSString *)imageName {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    [nav.tabBarItem setTitle:barName];
    [nav.tabBarItem setImage:[UIImage imageNamed:imageName]];
    return nav;
}

@end
