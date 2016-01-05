//
//  NKMenuPresenter.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuPresenter.h"
#import "NKMenuView.h"

@implementation NKMenuPresenter

@dynamic output;

#pragma mark - NKMenuModule

- (void) loadView {
    [self.interactor getMenuItems];
}

- (void) menuItemChosenWithTitle: (NSString*) title {
#warning Show appropriate module
}

- (void) userLogoutAction {
#warning Perform logout
}

#pragma mark - NKMenuInteractorOutput

- (void) menuItemsWereFound: (NSArray <NKMenuItem *>* ) items {
    NSArray* menuItemTitles = [items map:^id(id obj) {
        return [obj title];
    }];
    [self.output setMenuItemsWithTitles: menuItemTitles];
}

- (void) menuItemsNotFound:(NSError *)errorOrNil {
    [self.output showErrorMessage: errorOrNil.localizedDescription withTitle: @"Ошибка загруки меню"];
}

- (void) userWasFound: (NKUser*) user {
#warning Prepeare for view
}

- (void) logoutCompleted {
#warning Go to root wireframe
}

@end
