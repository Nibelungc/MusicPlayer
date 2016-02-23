//
//  NKAudioPlayer.h
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NKAudioPlayerDelegate;
@protocol NKAudioPlayerPlaybackDelegate;
@class NKPlayerView;
@class NKAudioTrack;

@interface NKAudioPlayer : NSObject

@property (weak, nonatomic, nullable) id<NKAudioPlayerDelegate> delegate;

@property (weak, nonatomic, nullable) id<NKAudioPlayerPlaybackDelegate> playbackDelegate;

@property (weak, nonatomic, nullable, readonly) NKAudioTrack* currentAudioTrack;

+ (nonnull instancetype) sharedPlayer;

- (void) loadItemsURLs: (nonnull NSArray <NKAudioTrack *>*) urls;

- (void) togglePlayPause;

- (BOOL) playTrackAtIndex: (NSInteger) index;

- (BOOL) playNext;

- (BOOL) playPrevious;

- (void) play;

- (void) pause;

- (void) stop;

- (BOOL) isPlaying;

- (nullable NKPlayerView*) playerViewWithHeight: (CGFloat) height;

- (void) seekToPosition: (CGFloat) position;

@end

@protocol NKAudioPlayerDelegate <NSObject>

@optional

- (void) trackDidStartPlayingWithIndex: (NSInteger) index;

- (void) trackDidStopPlayingWithIndex: (NSInteger) index;

@end

@protocol NKAudioPlayerPlaybackDelegate <NSObject>

@optional

- (void) audioDidPausePlaying;

- (void) audioDidStartPlaying;

- (void) audioProgressDidChangeTo: (NSTimeInterval) time withDuration: (NSTimeInterval) duration;

@end
