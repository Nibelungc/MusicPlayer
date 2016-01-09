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
#import "NKMenuItem.h"

@implementation NKMenuPresenter

@dynamic output;

#pragma mark - NKMenuModule

- (void) loadView {
    [self.interactor getMenuItems];
    [self.interactor getUser];
}

- (void) menuItemChosenWithIdentifier: (NSNumber*) identifier {
    [self.wireframe configureAlbumModuleWithItemID: identifier];
}

- (void) userLogoutAction {
    [self.interactor logout];
}

#pragma mark - NKMenuInteractorOutput

- (void) menuItemsWereFound: (NSArray <NKMenuItem *>* ) items {
    [self.output setMenuItems: items];
    if (!self.menuItems) {
        NKMenuItem* initialItem = (NKMenuItem*) items.firstObject;
        [self.wireframe menuLoadedWithInitialItemID: initialItem.identifier];
        [self.output selectMenuItemWithIdentifier: initialItem.identifier];
    }
    self.menuItems = items;
    
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
