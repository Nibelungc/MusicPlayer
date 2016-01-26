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

@interface NKAudioPlayer : NSObject

@property (strong, nonatomic, nonnull) NSArray <NSURL *>* itemsURLs;

@property (weak, nonatomic, nullable) id<NKAudioPlayerDelegate> delegate;

@property (weak, nonatomic, nullable) id<NKAudioPlayerPlaybackDelegate> playbackDelegate;

- (nonnull instancetype)initWithItemsURLs: (nonnull NSArray <NSURL *>*) urls;

- (void) playTrackAtIndex: (NSInteger) index;

- (void) playNext;

- (void) playPrevious;

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
