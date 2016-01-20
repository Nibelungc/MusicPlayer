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
#import "NKPLayerView.h"

static CGFloat kAudioPlayerPlayingRate = 1.0;
__unused static CGFloat kAudioPlayerStoppedRate = 0.0;

static NSString* kRateKey = @"rate";

static __weak NKPlayerView* currentPlayerView;

@interface NKAudioPlayer ()

@property (strong, nonatomic, nullable) AVPlayer* player;

@property (strong, nonatomic) AVPlayerViewController* playerController;

@property (nonatomic) NSInteger currentTrackIndex;

@property (strong, nonatomic) id timeObserver;

@end

@implementation NKAudioPlayer

- (instancetype)initWithItemsURLs: (NSArray <NSURL *>*) urls{
    self = [super init];
    if (self) {
        [[self class] configureAudioSession];
        [self startReceivingRemoteControlEvents];
        self.itemsURLs = urls;
        self.playbackDelegate = currentPlayerView;
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
    
    if ([self.playbackDelegate respondsToSelector: @selector(audioDidStartPlaying)]){
        [self.playbackDelegate audioDidStartPlaying];
    }
}

- (void) pause {
    [self.player pause];
    
    if ([self.playbackDelegate respondsToSelector: @selector(audioDidPausePlaying)]){
        [self.playbackDelegate audioDidPausePlaying];
    }
}

- (void) stop {
    [self pause];
    [self destroyCurrentPlayer];
   
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
    self.player = [self createPlayerWithUrl: url];
    [self play];
}

- (AVPlayer*) createPlayerWithUrl: (NSURL*) url {
    AVPlayer* player = [[AVPlayer alloc] initWithURL: url];
    self.playerController = [[AVPlayerViewController alloc] init];
    self.playerController.player = player;
    
    @weakify(self)
    CMTime cmtime = CMTimeMake(1, 10);
    self.timeObserver = [player addPeriodicTimeObserverForInterval: cmtime
                                         queue: NULL
                                    usingBlock:^(CMTime time) {
                                        @strongify(self)
                                        [self audioProgressDidChangeTo: time];
                                    }];
    
    return player;
}

- (void) destroyCurrentPlayer {
    [self.player removeTimeObserver: self.timeObserver];
    self.player = nil;
    self.timeObserver = nil;
}

#pragma mark - Presentation layer

- (nullable NKPlayerView*) playerViewWithHeight: (CGFloat) height {
    NKPlayerView* playerView = [[NKPlayerView alloc] initWithHeight: height andPlayer: self];
    currentPlayerView = playerView;
    return playerView;
}


#pragma mark - Events

- (void) audioProgressDidChangeTo: (CMTime) time {
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval progress = CMTimeGetSeconds(time);
    if ([self.playbackDelegate respondsToSelector: @selector(audioProgressDidChangeTo:withDuration:)]){
        [self.playbackDelegate audioProgressDidChangeTo: progress withDuration: duration];
    }
    if (progress >= duration){
        [self currentAudioTrackFinishedPlaying];
    }
//    if (progress == 0){
//        NSLog(@"Start playing at index %ld", _currentTrackIndex);
//    }
}

- (void) currentAudioTrackFinishedPlaying {
    [self playNext];
}

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

#pragma mark - Observarion

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
}

@end
