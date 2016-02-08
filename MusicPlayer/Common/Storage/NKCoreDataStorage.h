//
//  NKCoreDataStorage.h
//  MusicPlayer
//
//  Created by Denis Baluev on 29/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKDataStorage.h"

@class NKDownloadsManager;

@interface NKCoreDataStorage : NSObject <NKDataStorage>

@property (strong, nonatomic, nonnull) NKDownloadsManager* fileManager;

- (void) fetchSavedUser: (_Nonnull NKDataStorageSavedUserCompletion) completion;

- (void) saveUserAndDeleteOldOne: ( NKUser* _Nonnull ) user;

- (id<NKAudioService> __nullable) userAudioService;

- (nullable NSArray <NKAudioTrack *>*) downloadedTracks;

- (void) addDownloadedAudioTrack: (nonnull NKAudioTrack*) track;

- (void) removeDownloadedAudioTrack: (nonnull NKAudioTrack*) track;

@end
