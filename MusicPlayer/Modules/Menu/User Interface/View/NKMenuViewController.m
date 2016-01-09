//
//  NKMenuViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuViewController.h"
#import "NKMenuItem.h"

#import <UIViewController+MMDrawerController.h>

CGFloat const kUserInfoHeightInPercent = 20;

@interface NKMenuViewController () <UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;

@property (weak, nonatomic) UIImageView* avatarImageView;

@property (weak, nonatomic) UILabel* userNameLabel;

@property (strong, nonatomic) NSMutableArray <NKMenuItem *>* dataSource;

@end

@implementation NKMenuViewController

@dynamic eventHandler;

#pragma mark - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideApplicationStatusBar: YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self hideApplicationStatusBar: NO];
}

#pragma mark - Configuration

- (void) configureView {
    [super configureView];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    CGRect drawerRect = [self.view bounds];
    drawerRect.size.width = [self.mm_drawerController maximumLeftDrawerWidth];
    
    CGFloat userInfoHeight = CGRectGetHeight(drawerRect) * kUserInfoHeightInPercent/100.0;
    CGRect userInfoRect, menuRect;
    CGRectDivide(drawerRect, &userInfoRect, &menuRect, userInfoHeight, CGRectMinYEdge);
    CGFloat leftPadding = kDefaultPadding * 2.0;
    CGFloat rightPadding = leftPadding;
    
    /** User info */
    CGFloat avatarSideSize = userInfoHeight * 0.5;
    CGFloat avatarHeight = avatarSideSize;
    CGFloat avatarWidth = avatarSideSize;
    CGFloat userInfoContentMinY = CGRectGetMidY(userInfoRect) - avatarSideSize/2.0;
    CGRect avatarFrame = CGRectMake(leftPadding, userInfoContentMinY,
                                    avatarWidth, avatarHeight);
    UIImageView* avatarImageView = [[UIImageView alloc] initWithFrame: avatarFrame];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarImageView.layer.cornerRadius = avatarHeight/2.0;
    
    [self.view addSubview: avatarImageView];
    
    self.avatarImageView = avatarImageView;
    
    CGFloat avatarMaxXWithPadding = CGRectGetMaxX(avatarFrame) + kDefaultPadding;
    CGRect userNameFrame = CGRectMake(avatarMaxXWithPadding, userInfoContentMinY,
                                      CGRectGetWidth(drawerRect) - avatarMaxXWithPadding - rightPadding , avatarHeight);
    UILabel* userNameLabel = [[UILabel alloc] initWithFrame: userNameFrame];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    userNameLabel.numberOfLines = 0;
    [self.view addSubview: userNameLabel];
    
    self.userNameLabel = userNameLabel;
    
    /** Menu items */
    CGRect logoutButtonFrame, tableFrame;
    CGRectDivide(menuRect, &logoutButtonFrame, &tableFrame, kDefaultRowHeight, CGRectMaxYEdge);
    
    UITableView* tableView = [[UITableView alloc] initWithFrame: tableFrame
                                                          style: UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = self.view.backgroundColor;
    
    /** Log out*/
    UIButton* logOutButton = [UIButton buttonWithType: UIButtonTypeCustom];
    logOutButton.frame = logoutButtonFrame;
    [logOutButton setTitle: @"Log out" forState: UIControlStateNormal];
    [logOutButton addTarget: self action: @selector(logoutAction:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: logOutButton];
    
}

#pragma mark - Actions

- (void) logoutAction: (id) sender {
    
    static UIAlertController* alertController = nil;
    if (!alertController){
        NSString* alertTitle = @"Log out";
        NSString* alertMessage = [NSString stringWithFormat:@"Are you sure, %@?", self.userNameLabel.text];
        alertController = [UIAlertController alertControllerWithTitle: alertTitle
                                                               message: alertMessage
                                                        preferredStyle: UIAlertControllerStyleActionSheet];
        __weak typeof(self) welf = self;
        UIAlertAction* logoutAction = [UIAlertAction actionWithTitle:@"Log out"
                                                               style: UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 __strong typeof(self) sWelf = welf;
                                                                 [sWelf.eventHandler userLogoutAction];
                                                            }];
        [alertController addAction: logoutAction];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style: UIAlertActionStyleCancel
                                                             handler: nil];
        [alertController addAction: cancelAction];
    }
    [self presentViewController: alertController
                       animated: YES
                     completion: nil];
}

#pragma mark - Private

- (void) hideApplicationStatusBar: (BOOL) hidden {
    [[UIApplication sharedApplication] setStatusBarHidden: hidden withAnimation: UIStatusBarAnimationSlide];
}

- (void) reloadData {
    [self.tableView reloadData];
}

- (NKMenuItem*) menuItemWithIdentifier: (NSNumber*) identifier {
    NSArray* itemsWithIdentifier = [self.dataSource filter:^BOOL(NKMenuItem* item) {
        return item.identifier.integerValue == identifier.integerValue;
    }];
    return itemsWithIdentifier.firstObject;
}

- (NSIndexPath*) indexPathForMenuItem: (NKMenuItem*) item {
    NSInteger indexOfItem = [self.dataSource indexOfObject: item];
    if (indexOfItem != NSNotFound){
        return [NSIndexPath indexPathForRow: indexOfItem inSection:0];
    }
    return nil;
}

#pragma mark - NKMenuView

- (void) selectMenuItemWithIdentifier: (NSNumber*) identifier {
    NKMenuItem* menuItem = [self menuItemWithIdentifier: identifier];
    NSIndexPath* indexPath = [self indexPathForMenuItem: menuItem];
    [self.tableView selectRowAtIndexPath: indexPath
                                animated: NO
                          scrollPosition: UITableViewScrollPositionNone];
}

- (void) setMenuItems: (NSArray <NKMenuItem *>*) items {
    self.dataSource = [NSMutableArray arrayWithArray: items];
    [self reloadData];
}

- (void) setUserInfoWithName: (NSString*) name andImage: (UIImage*) image {
    [self.avatarImageView setImage:image animated: YES];
    self.userNameLabel.text = name;
}

@end

#pragma mark - UITableViewDelegate

@implementation NKMenuViewController (TableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NKMenuItem* selectedItem = self.dataSource[indexPath.row];
    [self.eventHandler menuItemChosenWithIdentifier: selectedItem.identifier];
}

@end

#pragma mark - UITableViewDataSource

@implementation NKMenuViewController (TableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier];
    }
    NKMenuItem* menuItem = self.dataSource[indexPath.row];
    cell.textLabel.text = menuItem.title;
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
}

@end
