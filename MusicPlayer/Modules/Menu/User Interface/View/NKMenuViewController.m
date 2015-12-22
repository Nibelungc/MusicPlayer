//
//  NKMenuViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuViewController.h"

@interface NKMenuViewController ()

@end

@implementation NKMenuViewController

@dynamic eventHandler;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
}

#pragma mark - NKMenuView

- (void) setMenuItemsWithTitles: (NSArray <NSString *>*) titles {
#warning Fill menu items
}

- (void) setUserInfoWithName: (NSString*) name andImage: (UIImage*) image {
#warning Fill user info
}

@end
