//
//  TabButton.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/17.
//

#import "TabButton.h"
#import "UIColor+ColorExtensions.h"
#import "UIFont+Extension.h"

@interface TabButton () {
    UILabel *badgeLabel;
}
@end

@implementation TabButton


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self.titleLabel setFont:[UIFont pingFangMediumWithSize:13]];
    }
    return self;
}

- (void) setup {
    badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [badgeLabel setFont:[UIFont pingFangMediumWithSize:12]];
    [badgeLabel setBackgroundColor:[UIColor softPink]];
    [badgeLabel setTextColor:[UIColor whiteColor]];
    [badgeLabel setTextAlignment:NSTextAlignmentCenter];
    [badgeLabel setHidden:YES];
    [badgeLabel.layer setCornerRadius:9];
    [badgeLabel.layer setMasksToBounds:YES];
    [badgeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:badgeLabel];
    [NSLayoutConstraint activateConstraints:@[
        [badgeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:18],
        [badgeLabel.widthAnchor constraintGreaterThanOrEqualToConstant:18],
        [badgeLabel.heightAnchor constraintGreaterThanOrEqualToConstant:18]
    ]];
}

- (void)configureWithCount:(NSInteger)count {
    
    if (count > 0) {
        [badgeLabel setHidden:NO];
        [badgeLabel setText:count > 99 ? @"+99" : @(count).stringValue];
        [badgeLabel sizeToFit];
    } else {
        [badgeLabel setHidden:YES];
    }
}

@end
