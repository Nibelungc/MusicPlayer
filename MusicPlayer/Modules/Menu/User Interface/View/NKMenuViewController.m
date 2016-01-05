//
//  NKMenuViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuViewController.h"
#import "NKMenuItem.h"

@interface NKMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;

@property (weak, nonatomic) NSMutableArray* dataSource;

@end

@implementation NKMenuViewController

@dynamic eventHandler;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];

    UITableView* tableView = [[UITableView alloc] initWithFrame: self.view.bounds
                                                          style: UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    
    self.tableView = tableView;
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
#warning Fill user info
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
    NKMenuItem* item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

@end
