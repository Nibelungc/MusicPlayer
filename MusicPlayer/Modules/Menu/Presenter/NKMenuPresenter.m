//
//  NKMenuPresenter.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuPresenter.h"

@implementation NKMenuPresenter

@dynamic output;

#pragma mark - NKMenuModule

- (void) menuItemChosenWithTitle: (NSString*) title {
#warning Show appropriate module
}

- (void) userLogoutAction {
#warning Perform logout
}

#pragma mark - NKMenuInteractorOutput

- (void) menuItemsWereFound: (NSArray <NKMenuItem *>* ) items {
#warning Pepare for view
}

- (void) userWasFound: (NKUser*) user {
#warning Prepeare for view
}

- (void) logoutCompleted {
#warning Go to root wireframe
}

@end
