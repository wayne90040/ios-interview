//
//  CustomHeader.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/15.
//

#import "CustomHeader.h"
#import "UIColor+ColorExtensions.h"
#import "UIFont+Extension.h"

@interface CustomHeader () {
    UILabel *nameLabel;
    UILabel *kokoLabel;
}
@end

@implementation CustomHeader

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteTwo]];
        [self setup];
    }
    return self;
}

- (void) setup {
    UIStackView *kokoStack = [[UIStackView alloc] init];
    [kokoStack setAxis:UILayoutConstraintAxisHorizontal];
    
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectZero];
    [left setImage:[UIImage imageNamed:@"icon-left-back"] forState:UIControlStateNormal];
    
    kokoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [kokoLabel setFont:[UIFont pingFangRegularWithSize:13]];
    [kokoStack addArrangedSubview:kokoLabel];
    [kokoStack addArrangedSubview:left];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [nameLabel setFont:[UIFont pingFangMediumWithSize:17]];
    UIStackView *stack = [[UIStackView alloc] init];
    [stack setAxis:UILayoutConstraintAxisVertical];
    [stack setSpacing:8];
    [stack addArrangedSubview:nameLabel];
    [stack addArrangedSubview:kokoStack];
    [stack setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [stack.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:30]
    ]];
    
    UIImageView *avatarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-avatar"]];
    [avatarImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:avatarImage];
    
    [NSLayoutConstraint activateConstraints:@[
        [avatarImage.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [avatarImage.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-30]
    ]];
}

- (void) configure:(NSString *)name setKoKoId:(NSString *)kokoId {
    [nameLabel setText:name];
    [kokoLabel setText:[NSString stringWithFormat:@"KOKO ID : %@", kokoId]];
}

@end
