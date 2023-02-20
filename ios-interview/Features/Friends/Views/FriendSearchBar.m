//
//  FriendSearchText.m
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/19.
//

#import "FriendSearchBar.h"
#import "UIColor+ColorExtensions.h"
#import "UIFont+Extension.h"

@interface FriendSearchBar () <UISearchBarDelegate>{
    
}

- (void) setup;

@end

@implementation FriendSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"icon-add-friend2"] forState:UIControlStateNormal];
    [addButton setTintColor:[UIColor hotPink]];
    [addButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:addButton];
    [NSLayoutConstraint activateConstraints:@[
        [addButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
        [addButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20],
        [addButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-30],
        [addButton.widthAnchor constraintEqualToAnchor:addButton.heightAnchor]
    ]];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [searchBar setPlaceholder:@"想轉一筆給誰呢？"];
    [searchBar.searchTextField setFont:[UIFont pingFangRegularWithSize:14]];
    [searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [searchBar setDelegate:self];
    [self addSubview:searchBar];
    [NSLayoutConstraint activateConstraints:@[
        [searchBar.topAnchor constraintEqualToAnchor:self.topAnchor constant:15],
        [searchBar.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15],
        [searchBar.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:30],
        [searchBar.trailingAnchor constraintEqualToAnchor:addButton.leadingAnchor constant:-15],
    ]];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES];
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO];
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:searchBar textDidChange:searchText];
    }
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
