//
//  NKAudioService.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSNumber, NSError, NSArray, NSString;

@class NKUser;
@class NKAudioTrack;
@class NKAudioAlbum;

typedef void(^NKAudioServiceLoginCompletion)(NKUser* __nullable user, NSError* __nullable errorOrNil);
typedef void(^NKAudioServiceTracksCompletion)( NSArray <NKAudioTrack *> * __nullable tracks, NSError* __nullable errorOrNil);
typedef void(^NKAudioServiceAlbumsCompletion)(NSArray <NKAudioAlbum *> * __nullable albums, NSError* __nullable errorOrNil);
typedef void(^NKAudioServiceSearchCompletion)(NSArray <NKAudioTrack *> * __nullable tracks, NSError* __nullable errorOrNil);

typedef void(^NKAudioServiceWakeupSessionCompletion)(BOOL success, NSError* __nullable errorOrNil);

@protocol NKAudioService <NSObject>

@property (strong, nonatomic)  NSString* _Nullable title;

@required

+ (_Nonnull instancetype) sharedService;

- (void) loginWithCompletion: (_Nonnull NKAudioServiceLoginCompletion) completion;

- (void) wakeUpSessionWithCompletion: (_Nonnull NKAudioServiceLoginCompletion) completion;

- (void) getAudioTracksForSearchString: (NSString* _Nonnull) searchString withCompletion: (_Nonnull NKAudioServiceSearchCompletion) completion;

- (void) getAudioTracksForAlbumIdentifier: (NSNumber* _Nonnull) identitier withCompletion: (_Nonnull NKAudioServiceTracksCompletion) completion;

- (void) getAlbumsWithCompletion: (_Nonnull NKAudioServiceAlbumsCompletion) completion;


@end
