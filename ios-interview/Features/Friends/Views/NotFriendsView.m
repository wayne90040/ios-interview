//
//  NotFriendsView.m
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/19.
//

#import "NotFriendsView.h"
#import "UIColor+ColorExtensions.h"
#import "UIFont+Extension.h"

@interface NotFriendsView () {
    
    UIImageView *avaterImage;
    
    UILabel *nameLabel;
    
    UILabel *subLabel;
    
    UIButton *okButton;
    
    UIButton *cancelButton;
}

- (void) setup;

@end

@implementation NotFriendsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:6];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.1];
    [self.layer setShadowOffset:CGSizeMake(0.0, 4.0)];
    [self.layer setShadowRadius:6];
    [self.layer setMasksToBounds:NO];
    
    avaterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-avatar"]];
    [avaterImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:avaterImage];
    [NSLayoutConstraint activateConstraints:@[
        [avaterImage.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [avaterImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15],
        [avaterImage.widthAnchor constraintEqualToConstant:40],
        [avaterImage.heightAnchor constraintEqualToConstant:40]
    ]];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [nameLabel setFont:[UIFont pingFangRegularWithSize:16]];
    [nameLabel setTextColor:[UIColor greyishBrown]];
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [subLabel setText:@"邀請你成為好友：）"];
    [subLabel setFont:[UIFont pingFangRegularWithSize:13]];
    [subLabel setTextColor:[UIColor brownGrey]];
    [subLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIStackView *labelStack = [[UIStackView alloc] initWithFrame:CGRectZero];
    [labelStack setAxis:UILayoutConstraintAxisVertical];
    [labelStack setAlignment:UIStackViewAlignmentFill];
    [labelStack setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [labelStack addArrangedSubview:nameLabel];
    [labelStack addArrangedSubview:subLabel];
    [self addSubview:labelStack];
    
    [NSLayoutConstraint activateConstraints:@[
        [labelStack.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [labelStack.leadingAnchor constraintEqualToAnchor:avaterImage.trailingAnchor constant:15],
    ]];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [cancelButton setImage:[UIImage imageNamed:@"icon-cancel"] forState:UIControlStateNormal];
    [cancelButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:cancelButton];
    [NSLayoutConstraint activateConstraints:@[
        [cancelButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [cancelButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-15],
        [cancelButton.widthAnchor constraintEqualToConstant: 30],
        [cancelButton.heightAnchor constraintEqualToConstant: 30]
    ]];
    
    okButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [okButton setImage:[UIImage imageNamed:@"icon-ok"] forState:UIControlStateNormal];
    [okButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:okButton];
    [NSLayoutConstraint activateConstraints:@[
        [okButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [okButton.trailingAnchor constraintEqualToAnchor:cancelButton.leadingAnchor constant:-15],
        [okButton.widthAnchor constraintEqualToConstant: 30],
        [okButton.heightAnchor constraintEqualToConstant: 30]
    ]];
}

- (void) configureWithFriend:(Friend *)friend {
    [nameLabel setText:friend.name];
}

@end
