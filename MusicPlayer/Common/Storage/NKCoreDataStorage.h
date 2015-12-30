//
//  NKCoreDataStorage.h
//  MusicPlayer
//
//  Created by Denis Baluev on 29/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKDataStorage.h"

@interface NKCoreDataStorage : NSObject <NKDataStorage>

- (void) fetchSavedUser: (_Nonnull NKDataStorageSavedUserCompletion) completion;

- (void) saveUserAndDeleteOldOne: ( NKUser* _Nonnull ) user;

@end
