//
//  NKMenuInteractor.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuInteractor.h"

#import "NKMenuItem.h"
#import "NKUser.h"

@implementation NKMenuInteractor

#pragma mark - NKMenuInteractorInput

- (void) getMenuItems {
    NKMenuItem* item = [[NKMenuItem alloc] init];
    item.title = @"First menu item";
    item.index = 0;
    [self.output menuItemsWereFound: @[item]];
}

- (void) getUser {
    NKUser* user = [[NKUser alloc] init];
    user.firstName = @"Nikolay";
    user.lastName = @"Kagala";
    user.imageUrl = [[NSBundle mainBundle] URLForResource:@"music_background" withExtension:@"jpg"];
    [self.output userWasFound: user];
}

- (void) logout {
    NSLog(@"Logout finished");
    [self.output logoutCompleted];
}

@end
