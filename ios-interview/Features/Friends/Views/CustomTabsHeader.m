//
//  CustomTabsHeader.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import "CustomTabsHeader.h"
#import "UIColor+ColorExtensions.h"
#import "TabButton.h"

@interface CustomTabsHeader () {
    TabButton *friendButton;
    
    TabButton *chatButton;
    
    UIView *pickBottomLine;
    
    NSLayoutConstraint *pickBottomLineCenterXConstraint;
}
@end

@implementation CustomTabsHeader

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteTwo]];
        [self setup];
    }
    return self;
}

- (void) setup {
    
    // MARK: Friend Button
    friendButton = [[TabButton alloc] initWithFrame:CGRectZero];
    [friendButton addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [friendButton setTitle:@"好友" forState:UIControlStateNormal];
    [friendButton setTitleColor:[UIColor greyishBrown] forState:UIControlStateNormal];
    [friendButton sizeToFit];
    [friendButton configureWithCount:2];
    [friendButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:friendButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [friendButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:32],
        [friendButton.topAnchor constraintEqualToAnchor:self.topAnchor],
        [friendButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    
    // MARK: Chat Button
    chatButton = [[TabButton alloc] initWithFrame:CGRectZero];
    [chatButton addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [chatButton setTitle:@"聊天" forState:UIControlStateNormal];
    [chatButton setTitleColor:[UIColor greyishBrown] forState:UIControlStateNormal];
    [chatButton configureWithCount:100];
    [chatButton sizeToFit];
    [chatButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:chatButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [chatButton.leadingAnchor constraintEqualToAnchor:friendButton.trailingAnchor constant:36],
        [chatButton.topAnchor constraintEqualToAnchor:self.topAnchor],
        [chatButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];

    pickBottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    [pickBottomLine setBackgroundColor: [UIColor hotPink]];
    [pickBottomLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pickBottomLine.layer setCornerRadius:2];
    [pickBottomLine.layer setMasksToBounds:YES];
    
    [self addSubview:pickBottomLine];
    pickBottomLineCenterXConstraint = [pickBottomLine.centerXAnchor constraintEqualToAnchor:friendButton.centerXAnchor];
    [NSLayoutConstraint activateConstraints:@[
        pickBottomLineCenterXConstraint,
        [pickBottomLine.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [pickBottomLine.heightAnchor constraintEqualToConstant:4],
        [pickBottomLine.widthAnchor constraintEqualToAnchor:friendButton.widthAnchor constant:-6]
    ]];
}

-(void) onButtonTapped:(UIButton*)sender {
    [pickBottomLineCenterXConstraint setActive:NO];
    pickBottomLineCenterXConstraint = [pickBottomLine.centerXAnchor constraintEqualToAnchor: sender.centerXAnchor];
    [pickBottomLineCenterXConstraint setActive:YES];
    
    __weak CustomTabsHeader *weakSelf = self;
    UIViewPropertyAnimator *animate = [[UIViewPropertyAnimator alloc] initWithDuration:0.3
                                                                                 curve:UIViewAnimationCurveEaseInOut
                                                                            animations:^{
        [weakSelf layoutIfNeeded];
    }];
    
    [animate startAnimation];
}

@end
