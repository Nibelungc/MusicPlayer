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

- (void) getAudioTracksForAlbumIdentifier: (NSNumber* _Nonnull) identitier
                           withCompletion: (_Nonnull NKAudioServiceTracksCompletion) completion;

- (void) getAlbumsWithCompletion: (_Nonnull NKAudioServiceAlbumsCompletion) completion;

@end
