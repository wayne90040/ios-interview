//
//  FriendSearchText.h
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FriendSearchBarDelegate <NSObject>

@optional

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar;

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar;

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface FriendSearchBar : UIView

@property (nonatomic, weak) id <FriendSearchBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
