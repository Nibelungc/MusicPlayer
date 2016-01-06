//
//  NKMenuViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuViewController.h"

#import <UIViewController+MMDrawerController.h>

CGFloat const kUserInfoHeightInPercent = 20;

@interface NKMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;

@property (weak, nonatomic) UIImageView* avatarImageView;

@property (weak, nonatomic) UILabel* userNameLabel;

@property (strong, nonatomic) NSMutableArray* dataSource;

@end

@implementation NKMenuViewController

@dynamic eventHandler;

#pragma mark - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
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
    UITableView* tableView = [[UITableView alloc] initWithFrame: menuRect
                                                          style: UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = self.view.backgroundColor;
    
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(logoutAction:)]];
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

#pragma mark - NKMenuView

- (void) setMenuItemsWithTitles: (NSArray <NSString *>*) titles {
    self.dataSource = [NSMutableArray arrayWithArray: titles];
    [self reloadData];
}

- (void) setUserInfoWithName: (NSString*) name andImage: (UIImage*) image {
    [self.avatarImageView setImage:image animated: YES];
    self.userNameLabel.text = name;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
}

#pragma mark - UITableViewDataSource

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
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
}

@end
