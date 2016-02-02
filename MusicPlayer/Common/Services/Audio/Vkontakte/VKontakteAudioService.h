//
//  VKontateAudioService.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKAudioService.h"
#import "VKSdk.h"

@interface VKontakteAudioService : NSObject <NKAudioService, VKSdkDelegate>

+ (_Nonnull instancetype) sharedService;

- (void) loginWithCompletion: (_Nonnull NKAudioServiceLoginCompletion) completion;

- (void) forceLogout;

- (void) wakeUpSessionWithCompletion: (_Nonnull NKAudioServiceLoginCompletion) completion;

- (void) getAudioTracksForSearchString: (NSString* _Nonnull) searchString
                        withCompletion: (_Nonnull NKAudioServiceSearchCompletion) completion;

- (void) getAudioTracksForAlbumIdentifier: (NSNumber* _Nullable) identifier
                           withCompletion: (_Nonnull NKAudioServiceTracksCompletion) completion;

- (void) getAlbumsWithCompletion: (_Nonnull NKAudioServiceAlbumsCompletion) completion;

- (void) getAlbumTitleForIdentifier: (NSNumber* _Nullable) identifier
                     withCompletion: (_Nonnull NKAudioServiceAlbumNameCompletion) completion;

- (BOOL) isAudioTrackFavorite: (nonnull NKAudioTrack*) audioTrack;

- (void) addAudioTrackToFavorite: (nonnull NKAudioTrack*) audioTrack
                      completion: (nonnull NKAudioServiceCompletion) completion;

- (void) removeAudioTrackFromFavorite: (nonnull NKAudioTrack*) audioTrack
                           completion: (nonnull NKAudioServiceCompletion) completion;

@end
