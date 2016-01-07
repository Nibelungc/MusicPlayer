//
//  NKMenuPresenter.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuPresenter.h"
#import "NKMenuWireFrame.h"
#import "NKMenuView.h"
#import "NKUser.h"

@implementation NKMenuPresenter

@dynamic output;

#pragma mark - NKMenuModule

- (void) loadView {
    [self.interactor getMenuItems];
    [self.interactor getUser];
}

- (void) menuItemChosenWithTitle: (NSString*) title {
#warning Show appropriate module
}

- (void) userLogoutAction {
    [self.interactor logout];
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
    NSString* name = [NSString stringWithFormat: @"%@ %@", user.firstName, user.lastName];
    [self.output setUserInfoWithName: name andImage: nil];
    [NKUtils downloadImageFromURL: user.imageUrl
                   withCompletion:^(UIImage *image, NSError *errorOrNil) {
                       [self.output setUserInfoWithName: name andImage: image];
                   }];
}

- (void) logoutCompleted {
    [self.wireframe goToLoginModule];
}

@end
