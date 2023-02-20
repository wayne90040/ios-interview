//
//  CustomTableViewCell.m
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/16.
//

#import "CustomTableViewCell.h"
#import "UIColor+ColorExtensions.h"
#import "UIFont+Extension.h"
#import "Friend.h"

@interface CustomTableViewCell () {
    
    UIImageView *startIcon;
    
    UIImageView *avaterImage;
    
    UILabel *nameLabel;
    
    UILabel *invitingLabel;
    
    UIButton *transferButton;
    
    UIButton *moreButton;

}

@end

@implementation CustomTableViewCell

+ (NSString *)identifier {
    return @"CustomTableViewCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void) setup {
    
    startIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-star"]];
    [startIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:startIcon];
    [NSLayoutConstraint activateConstraints:@[
        [startIcon.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [startIcon.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:30],
        [startIcon.widthAnchor constraintEqualToConstant:14],
        [startIcon.heightAnchor constraintEqualToConstant:14]
    ]];
    
    avaterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-avatar"]];
    [avaterImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:avaterImage];
    [NSLayoutConstraint activateConstraints:@[
        [avaterImage.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [avaterImage.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:50],
        [avaterImage.widthAnchor constraintEqualToConstant:40],
        [avaterImage.heightAnchor constraintEqualToConstant:40]
    ]];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [nameLabel setFont:[UIFont pingFangRegularWithSize:16]];
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:nameLabel];
    [NSLayoutConstraint activateConstraints:@[
        [nameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [nameLabel.leadingAnchor constraintEqualToAnchor:avaterImage.trailingAnchor constant:15],
    ]];
    
    UIStackView *stack = [[UIStackView alloc] init];
    [stack setAxis:UILayoutConstraintAxisHorizontal];
    [stack setSpacing:10];
    
    transferButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [transferButton setTitle:@"轉帳" forState:UIControlStateNormal];
    [transferButton.titleLabel setFont:[UIFont pingFangMediumWithSize:14]];
    [transferButton setTitleColor:[UIColor hotPink] forState:UIControlStateNormal];
    [transferButton.layer setBorderColor:[UIColor hotPink].CGColor];
    [transferButton.layer setBorderWidth:2];
    [transferButton.layer setCornerRadius:2];
    [transferButton.layer setMasksToBounds:YES];
    [transferButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stack addArrangedSubview:transferButton];
    [NSLayoutConstraint activateConstraints:@[
        [transferButton.widthAnchor constraintEqualToConstant:47],
        [transferButton.heightAnchor constraintEqualToConstant:24]
    ]];
    
    invitingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [invitingLabel setText:@"邀請中"];
    [invitingLabel setFont:[UIFont pingFangMediumWithSize:14]];
    [invitingLabel setTextColor:[UIColor brownGrey]];
    [invitingLabel setTextAlignment:NSTextAlignmentCenter];
    [invitingLabel.layer setBorderColor:[UIColor veryLightPinkTwo].CGColor];
    [invitingLabel.layer setBorderWidth:2];
    [invitingLabel.layer setCornerRadius:2];
    [invitingLabel.layer setMasksToBounds:YES];
    [invitingLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stack addArrangedSubview:invitingLabel];
    [NSLayoutConstraint activateConstraints:@[
        [invitingLabel.widthAnchor constraintEqualToConstant:60],
        [invitingLabel.heightAnchor constraintEqualToConstant:24]
    ]];
    
    moreButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [moreButton setImage:[UIImage imageNamed:@"icon-more"] forState:UIControlStateNormal];
    [moreButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stack addArrangedSubview:moreButton];
    
    [self.contentView addSubview:stack];
    [stack setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [stack.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
    ]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureWithFriend:(Friend *)friend {
    [nameLabel setText:friend.name];
    [startIcon setHidden:!friend.isTop];
    
    switch (friend.status) {
        case StatusSend:
            break;
            
        case StatusDone:
            [invitingLabel setHidden:YES];
            [moreButton setHidden:NO];
            break;
            
        case StatusInviting:
            [invitingLabel setHidden:NO];
            [moreButton setHidden:YES];
            break;
            
        default:
            break;
    }
}


@end
