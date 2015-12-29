//
//  NKDataStorage.h
//  MusicPlayer
//
//  Created by Denis Baluev on 29/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKUser;

typedef void(^NKDataStorageSavedUserCompletion)(NKUser* __nullable user);

@protocol NKDataStorage <NSObject>

@required

- (void) fetchSavedUser: (_Nonnull NKDataStorageSavedUserCompletion) completion;

- (void) saveUser: ( NKUser* _Nonnull ) user;

@end
