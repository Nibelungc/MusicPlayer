//
//  NKAudioPlayer.m
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioPlayer.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

static CGFloat kAudioPlayerPlayingRate = 1.0;
static CGFloat kAudioPlayerStoppedRate = 0.0;

@interface NKAudioPlayer ()

@property (strong, nonatomic, nullable) AVPlayer* player;

@property (strong, nonatomic) AVPlayerViewController* playerController;

@property (nonatomic) NSInteger currentTrackIndex;

@end

@implementation NKAudioPlayer

- (instancetype)initWithItemsURLs: (NSArray <NSURL *>*) urls{
    self = [super init];
    if (self) {
        [[self class] configureAudioSession];
        [self startReceivingRemoteControlEvents];
        self.itemsURLs = urls;
    }
    return self;
}

+ (void) configureAudioSession {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}

- (void) dealloc {
    [self stopReceivingRemoteControlEvents];
}

#pragma mark - Playback control

- (void) playTrackAtIndex: (NSInteger) index {
    if (index < 0 || index >= self.itemsURLs.count){
        NSLog(@"Can't find the audio track at the index: (%ld)", index);
        return;
    }
    [self playTrackWithURL: self.itemsURLs[index]];
    
    self.currentTrackIndex = index;
    
    if ([self.delegate respondsToSelector: @selector(trackDidStartPlayingWithIndex:)]){
        [self.delegate trackDidStartPlayingWithIndex: index];
    }
}

- (void) playNext {
    [self playTrackAtIndex: self.currentTrackIndex + 1];
}

- (void) playPrevious {
    [self playTrackAtIndex: self.currentTrackIndex - 1];
}

- (void) play {
    [self.player play];
}

- (void) pause {
    [self.player pause];
}

- (void) stop {
    [self pause];
    self.player = nil;
    
    if ([self.delegate respondsToSelector:@selector(trackDidStopPlayingWithIndex:)]){
        [self.delegate trackDidStopPlayingWithIndex: self.currentTrackIndex];
    }
}

- (BOOL) isPlaying {
    return [self.player rate] == kAudioPlayerPlayingRate;
}

#pragma mark - Private

- (void) playTrackWithURL: (NSURL*) url {
    [self stop];
    self.player = [[AVPlayer alloc] initWithURL: url];
    self.playerController = [[AVPlayerViewController alloc] init];
    self.playerController.player = self.player;
    [self play];
}

#pragma mark - Presentation layer

- (UIViewController*) playerViewController {
    return self.playerController;
}

#pragma mark - Events


#pragma mark - Remote control

- (void) startReceivingRemoteControlEvents {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return;
    [[MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self playNext];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void) stopReceivingRemoteControlEvents {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

@end
