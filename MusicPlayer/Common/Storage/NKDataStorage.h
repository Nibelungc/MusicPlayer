//
//  NKDataStorage.h
//  MusicPlayer
//
//  Created by Denis Baluev on 29/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKUser;
@class NKAudioTrack;
@protocol NKAudioService;

typedef void(^NKDataStorageSavedUserCompletion)(NKUser* __nullable user);

@protocol NKDataStorage <NSObject>

@required

- (void) fetchSavedUser: (_Nonnull NKDataStorageSavedUserCompletion) completion;

- (void) saveUserAndDeleteOldOne: ( NKUser* _Nonnull ) user;

- (id<NKAudioService> __nullable) userAudioService;

- (nullable NSArray <NKAudioTrack *>*) downloadedTracks;

- (void) addDownloadedAudioTrack: (nonnull NKAudioTrack*) track;

- (void) removeDownloadedAudioTrack: (nonnull NKAudioTrack*) track;

- (BOOL) isDownloadsAlbumIdentifier: (nonnull NSNumber*) identifier;

@end
