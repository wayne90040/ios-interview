//
//  EmptyFriendView.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/16.
//

#import "EmptyFriendView.h"
#import "UIColor+ColorExtensions.h"
#import "UIFont+Extension.h"

@interface EmptyFriendView () {
    
    UIButton *addFriendsButton;
    
    CAGradientLayer *buttonLayer;
}
@end

@implementation EmptyFriendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [buttonLayer setFrame:addFriendsButton.bounds];
}

- (void) setup {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-friend-empty"]];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[
       [imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:30],
       [imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setText:@"就從加好友開始吧：）"];
    [titleLabel setFont:[UIFont pingFangMediumWithSize:21]];
    [titleLabel setTextColor:[UIColor greyishBrown]];
    [titleLabel sizeToFit];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:titleLabel];
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.topAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:40],
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [subLabel setText:@"與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"];
    [subLabel setFont:[UIFont pingFangMediumWithSize:14]];
    [subLabel setTextColor:[UIColor brownGrey]];
    [subLabel setNumberOfLines:0];
    [subLabel sizeToFit];
    [subLabel setTextAlignment:NSTextAlignmentCenter];
    [subLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:subLabel];
    [NSLayoutConstraint activateConstraints:@[
        [subLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:8],
        [subLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
    
    addFriendsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [addFriendsButton setTitle:@"加好友" forState:UIControlStateNormal];
    [addFriendsButton setImage:[UIImage imageNamed:@"icon-add-friend"] forState:UIControlStateNormal];
    [addFriendsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [addFriendsButton.layer setCornerRadius:20];
    [addFriendsButton setClipsToBounds:YES];
    [addFriendsButton.layer setShadowColor:[UIColor appleGreen40].CGColor];
    [addFriendsButton.layer setShadowOffset:CGSizeMake(0.0, 4.0)];
    [addFriendsButton.layer setShadowOpacity:1];
    [addFriendsButton.layer setShadowRadius:20];
    [addFriendsButton.layer setMasksToBounds:NO];
    [addFriendsButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    
    buttonLayer = [CAGradientLayer layer];
    [buttonLayer setFrame:addFriendsButton.bounds];
    [buttonLayer setCornerRadius:20];
    [buttonLayer setMasksToBounds:YES];
    [buttonLayer setColors:@[
        (id)[UIColor frogGreen].CGColor,
        (id)[UIColor booger].CGColor
    ]];
    
    [addFriendsButton.layer addSublayer:buttonLayer];
    [self addSubview:addFriendsButton];
    [addFriendsButton bringSubviewToFront:addFriendsButton.imageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [addFriendsButton.topAnchor constraintEqualToAnchor:subLabel.bottomAnchor constant:25],
        [addFriendsButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [addFriendsButton.widthAnchor constraintEqualToConstant:192],
        [addFriendsButton.heightAnchor constraintEqualToConstant:40]
    ]];
    
    UILabel *helpLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [helpLabel setText:@"幫助好友更快找到你？"];
    [helpLabel setFont:[UIFont pingFangMediumWithSize:13]];
    [helpLabel setTextColor:[UIColor brownGrey]];
    
    NSMutableAttributedString *kokoIdString = [[NSMutableAttributedString alloc] initWithString:@"設定 KOKO ID"];
    [kokoIdString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(0, [kokoIdString length])];
    
    UIButton *kokoIdButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [kokoIdButton setAttributedTitle:kokoIdString forState:UIControlStateNormal];
    [kokoIdButton.titleLabel setFont:[UIFont pingFangMediumWithSize:13]];
    [kokoIdButton setTitleColor:[UIColor hotPink] forState:UIControlStateNormal];
    [kokoIdButton sizeToFit];
    
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectZero];
    [stack setAxis:UILayoutConstraintAxisHorizontal];
    [stack addArrangedSubview:helpLabel];
    [stack addArrangedSubview:kokoIdButton];
    [stack setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-24],
        [stack.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
    ]];
}

@end
