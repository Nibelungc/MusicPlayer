//
//  NKLoginInteractorIO.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSArray;
@class NKUser;
@protocol NKAudioService;

@protocol NKLoginInteractorInput <NSObject>

- (void) getListOfServices;

- (void) loginWithService: (id <NKAudioService>) service;

@end

@protocol NKLoginInteractorOutput <NSObject>

- (void) setListOfServices: (NSArray*) listOfServices;

- (void) loginSucceededWithUser: (NKUser*) user;

- (void) loginFailedWithError: (NSError*) error;

@end
