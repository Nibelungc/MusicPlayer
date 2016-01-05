//
//  NKMenuInteractorIO.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSArray;

@class NKMenuItem;
@class NKUser;

@protocol NKMenuInteractorInput <NSObject>

- (void) getMenuItems;

- (void) getUser;

- (void) logout;

@end

@protocol NKMenuInteractorOutput <NSObject>

- (void) menuItemsWereFound: (NSArray <NKMenuItem *>* ) items;

- (void) menuItemsNotFound: (NSError*) errorOrNil;

- (void) userWasFound: (NKUser*) user;

- (void) logoutCompleted;

@end
