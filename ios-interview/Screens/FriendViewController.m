//
//  FriendViewController.m
//  ios-interview
//
//  Created by WEI LUN HSU on 2023/2/15.
//

#import "FriendViewController.h"
#import "CustomHeader.h"
#import "CustomTabsHeader.h"
#import "EmptyFriendView.h"
#import "NetworkManager.h"
#import "FriendViewModel.h"
#import "CustomTableViewCell.h"
#import "UIColor+ColorExtensions.h"
#import "FriendSearchBar.h"
#import "NotFriendsView.h"

@interface FriendViewController () <UITableViewDelegate, UITableViewDataSource, FriendSearchBarDelegate> 

@property (strong, nonatomic) CustomHeader *customHeader;

@property (strong, nonatomic) CustomTabsHeader *customTabsHeader;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) FriendSearchBar *friendSearchBar;

@property (strong,nonatomic) UITableView *mainTableView;

@property (strong, nonatomic) EmptyFriendView *emptyFriendView;

@property (strong, nonatomic) FriendViewModel *viewModel;

@property (strong, nonatomic) UIStackView *notFriendsStack;

@property (strong, nonatomic) UIView *notFriendsContainer;

@property (strong, nonatomic) NSMutableArray<NotFriendsView*> *notFriendsViews;

@property (strong, nonatomic) NSLayoutConstraint *searchBarTopConstraint;

@property (strong, nonatomic) NSLayoutConstraint *notFriendHightConstraint;

@property (assign, nonatomic) BOOL isExpandNotFriends;

@property (assign, nonatomic) Case friendCase;

/// set nav bar item
- (void) setupNavItem;

/// set man header
- (void) setupHeader;

/// set friends / chats tab
- (void) setupTabsHeader;

/// set empty view
- (void) setupEmptyView;

/// set searchbar
- (void) setupSearchBar;

/// set table view
- (void) setupTableView;

/// set not friend view
- (void) setupNotFriendContainer;

/// fetch api
- (void) fetch;

/// hide tabview or empty view
- (void) setBody;

/// Re-layout not friend container
- (void) layoutNotFriendContainer;

/// Create Not Friends View
- (void) createNotFriendViews;

@end

@implementation FriendViewController


- (instancetype)initWithFriendCase:(Case)friendCase {
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        self.viewModel = [[FriendViewModel alloc] initWithFriendCase:friendCase];
        [self setFriendCase:friendCase];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteTwo]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteTwo]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tabBarController.tabBar setTranslucent:NO];
    //    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self setupNavItem];
    [self setupHeader];
    [self setupNotFriendContainer];
    [self setupTabsHeader];
    [self setupEmptyView];
    [self setupSearchBar];
    [self setupTableView];
    [self fetch];
}

// MARK: - Set up UI
- (void) setupNavItem {
    UIBarButtonItem *scanItem = ^UIBarButtonItem*() {
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-scan"]
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:NULL];
        
        [bar setTintColor:[UIColor hotPink]];
        return bar;
    }();
    
    UIBarButtonItem *transferItem = ^UIBarButtonItem*() {
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-transfer"]
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:NULL];
        [bar setTintColor:[UIColor hotPink]];
        return bar;
    }();
    
    UIBarButtonItem *atmItem = ^UIBarButtonItem*() {
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-atm"]
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:NULL];
        [bar setTintColor:[UIColor hotPink]];
        return bar;
    }();
    [self.navigationItem setRightBarButtonItem:scanItem];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:atmItem, transferItem, nil]];
}

- (void) setupHeader {
    self.customHeader = [[CustomHeader alloc] initWithFrame:CGRectZero];
    [self.customHeader setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.customHeader];
    [NSLayoutConstraint activateConstraints:@[
        [self.customHeader.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.customHeader.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.customHeader.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.customHeader.heightAnchor constraintEqualToConstant:100.0],
    ]];
}

- (void) setupNotFriendContainer {
    self.notFriendsContainer = [[UIView alloc] initWithFrame:CGRectZero];
    [self.notFriendsContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.notFriendsContainer];
    self.notFriendHightConstraint = [self.notFriendsContainer.heightAnchor constraintEqualToConstant:0];
    [NSLayoutConstraint activateConstraints:@[
        [self.notFriendsContainer.topAnchor constraintEqualToAnchor:self.customHeader.bottomAnchor],
        [self.notFriendsContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30],
        [self.notFriendsContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30],
        self.notFriendHightConstraint
    ]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(onTappedNotFriendContainer:)];
    [self.notFriendsContainer addGestureRecognizer:tap];
}

- (void) onTappedNotFriendContainer:(UITapGestureRecognizer*)recognizer {
    self.isExpandNotFriends = !self.isExpandNotFriends;
    [self layoutNotFriendContainer];
}

- (void) setupTabsHeader {
    self.customTabsHeader = [[CustomTabsHeader alloc] initWithFrame:CGRectZero];
    [self.customTabsHeader setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.customTabsHeader];
    [NSLayoutConstraint activateConstraints:@[
        [self.customTabsHeader.topAnchor constraintEqualToAnchor:self.notFriendsContainer.bottomAnchor constant:10],
        [self.customTabsHeader.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.customTabsHeader.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.customTabsHeader.heightAnchor constraintEqualToConstant:30.0],
    ]];
}

- (void) setupEmptyView {
    self.emptyFriendView = [[EmptyFriendView alloc] initWithFrame:CGRectZero];
    [self.emptyFriendView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.emptyFriendView];
    [NSLayoutConstraint activateConstraints:@[
        [self.emptyFriendView.topAnchor constraintEqualToAnchor:self.customTabsHeader.bottomAnchor],
        [self.emptyFriendView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.emptyFriendView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.emptyFriendView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
}

- (void) setupSearchBar {
    self.friendSearchBar = [[FriendSearchBar alloc] initWithFrame:CGRectZero];
    [self.friendSearchBar setDelegate:self];
    [self.friendSearchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.friendSearchBar];
    
    self.searchBarTopConstraint = [self.friendSearchBar.topAnchor constraintEqualToAnchor:self.customTabsHeader.bottomAnchor];
    
    [NSLayoutConstraint activateConstraints:@[
        self.searchBarTopConstraint,
        [self.friendSearchBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.friendSearchBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.friendSearchBar.heightAnchor constraintEqualToConstant:66.0],
    ]];
}

- (void) setupTableView {
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.mainTableView registerClass:[CustomTableViewCell class]
               forCellReuseIdentifier:[CustomTableViewCell identifier]];
    [self.mainTableView setDelegate:self];
    [self.mainTableView setDataSource:self];
    [self.mainTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mainTableView setSectionHeaderTopPadding:0];
    
    [self.view addSubview:self.mainTableView];
    [NSLayoutConstraint activateConstraints:@[
        [self.mainTableView.topAnchor constraintEqualToAnchor:self.friendSearchBar.bottomAnchor],
        [self.mainTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.mainTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.mainTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(fetch)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.mainTableView addSubview:self.refreshControl];
}


// MARK: - Logic

- (void) fetch {
    
    __weak FriendViewController *weakSelf = self;
    [self.viewModel fetchManWithCompletion:^(BOOL success) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.customHeader configure:weakSelf.viewModel.man.name
                                       setKoKoId:weakSelf.viewModel.man.kokoId];
            });
        }
    }];
    
    [self.viewModel fetchFriendsWithCompletion:^(BOOL success) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.mainTableView reloadData];
                [weakSelf setBody];
                [weakSelf.refreshControl endRefreshing];
                [weakSelf createNotFriendViews];
                [weakSelf layoutNotFriendContainer];
            });
        }
    }];
}

- (void) setBody {
    if (_viewModel.friends.count == 0) {
        [self.friendSearchBar setHidden:YES];
        [self.mainTableView setHidden:YES];
        [self.emptyFriendView setHidden:NO];
    } else {
        [self.friendSearchBar setHidden:NO];
        [self.mainTableView setHidden:NO];
        [self.emptyFriendView setHidden:YES];
    }
}

- (void) createNotFriendViews {
    
    if (self.friendCase == CaseTwo) {
        return;
    }
    
    self.notFriendsViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.viewModel.notFriends.count; i++) {
        NotFriendsView *notFriendView = [[NotFriendsView alloc] initWithFrame:CGRectMake(0, 0, self.notFriendsContainer.frame.size.width, 70)];
        [notFriendView configureWithFriend:self.viewModel.notFriends[i]];
        [self.notFriendsViews addObject:notFriendView];
        
        if (i == 0) {
            [self.notFriendsContainer addSubview:notFriendView];
        } else {
            [self.notFriendsContainer insertSubview:notFriendView belowSubview:self.notFriendsViews[i - 1]];
        }
    }
}

- (void) layoutNotFriendContainer {
    
    if (self.notFriendsViews.count == 0 || self.friendCase == CaseTwo) {
        return;
    }
    
    [self.notFriendHightConstraint setActive:NO];
    self.notFriendHightConstraint = [self.notFriendsContainer.heightAnchor constraintEqualToConstant:
                                         self.isExpandNotFriends ?
                                     70 + 80 * (self.notFriendsViews.count - 1) :
                                         70 + 10 * (self.notFriendsViews.count - 1)
    ];
    [self.notFriendHightConstraint setActive:YES];
        
    int x = 0;
    int y = 0;
    int width = self.notFriendsContainer.frame.size.width;
    
    for (int i = 0; i < self.notFriendsViews.count; i++) {
        [self.notFriendsViews[i] setFrame:CGRectMake(x, y, width, 70)];
        
        if (self.isExpandNotFriends) {
            y += 80;
        } else {
            y += 10;
            x += 5;
            width -= 10;
        }
    }
    
    __weak FriendViewController *weakSelf = self;
    UIViewPropertyAnimator *animate = [[UIViewPropertyAnimator alloc] initWithDuration:0.3
                                                                                 curve:UIViewAnimationCurveEaseInOut
                                                                            animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
    [animate startAnimation];
}


// MARK: - TableView Delegate, DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CustomTableViewCell identifier] forIndexPath:indexPath];
    [cell configureWithFriend: self.viewModel.friends[indexPath.row]];
    return cell;
}


// MARK: - FriendSearchBarDelegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBarTopConstraint setActive:NO];
    self.searchBarTopConstraint = [self.friendSearchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    [self.searchBarTopConstraint setActive:YES];
    
    __weak FriendViewController *weakSelf = self;
    UIViewPropertyAnimator *animate = [[UIViewPropertyAnimator alloc] initWithDuration:0.3
                                                                                 curve:UIViewAnimationCurveEaseInOut
                                                                            animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
    [animate startAnimation];
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBarTopConstraint setActive:NO];
    self.searchBarTopConstraint = [self.friendSearchBar.topAnchor constraintEqualToAnchor:self.customTabsHeader.bottomAnchor];
    [self.searchBarTopConstraint setActive:YES];
    
    __weak FriendViewController *weakSelf = self;
    UIViewPropertyAnimator *animate = [[UIViewPropertyAnimator alloc] initWithDuration:0.3
                                                                                 curve:UIViewAnimationCurveEaseInOut
                                                                            animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
    [animate startAnimation];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    __weak FriendViewController *weakSelf = self;
    [self.viewModel searchFriendsWithString:searchText completionHandler:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
}

@end
