//
//  NKAudioPlayer.h
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NKAudioPlayerDelegate;

@interface NKAudioPlayer : NSObject

@property (strong, nonatomic, nonnull) NSArray <NSURL *>* itemsURLs;

@property (weak, nonatomic, nullable) id<NKAudioPlayerDelegate> delegate;

- (nonnull instancetype)initWithItemsURLs: (nonnull NSArray <NSURL *>*) urls;

- (void) playTrackAtIndex: (NSInteger) index;

- (void) playNext;

- (void) playPrevious;

- (void) play;

- (void) pause;

- (void) stop;

- (BOOL) isPlaying;

- (nullable UIViewController*) playerViewController;

@end

@protocol NKAudioPlayerDelegate <NSObject>

@optional

- (void) trackDidStartPlayingWithIndex: (NSInteger) index;

- (void) trackDidStopPlayingWithIndex: (NSInteger) index;

@end
