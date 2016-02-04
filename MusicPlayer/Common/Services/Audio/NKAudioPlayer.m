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
#import "NKAudioTrack.h"
#import "NKRemoteControlCenter.h"

static CGFloat kAudioPlayerPlayingRate = 1.0;
__unused static CGFloat kAudioPlayerStoppedRate = 0.0;

static NSString* kRateKey = @"rate";
static NSString* kStatusKey = @"status";

static __weak NKPlayerView* currentPlayerView;

@interface NKAudioPlayer ()

@property (strong, nonatomic, nonnull) NSArray <NKAudioTrack *>* items;

@property (strong, nonatomic, nullable) AVPlayer* player;

@property (nonatomic) NSInteger currentTrackIndex;

@property (strong, nonatomic) id timeObserver;

@property (strong, nonatomic, nonnull) NKRemoteControlCenter* remoteControlCenter;

@property (weak, nonatomic, nullable, readwrite) NKAudioTrack* currentAudioTrack;

@end

@implementation NKAudioPlayer

+ (nonnull instancetype) sharedPlayer {
    static NKAudioPlayer* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype) init {
    if (self = [super init]){
        [[self class] configureAudioSession];
        _remoteControlCenter = [NKRemoteControlCenter remoteControlCenterWithPlayer: self];
        [_remoteControlCenter startReceivingRemoteControlEvents];
    }
    return self;
}

+ (void) configureAudioSession {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}

- (void) dealloc {
    [self.remoteControlCenter stopReceivingRemoteControlEvents];
}

- (void) loadItemsURLs: (nonnull NSArray <NKAudioTrack *>*) tracks {
    self.items = tracks;
    self.playbackDelegate = currentPlayerView;
    currentPlayerView.player = self;
}

#pragma mark - Playback control

- (void) togglePlayPause {
    if ([self isPlaying]){
        [self pause];
    } else {
        [self play];
    }
}

- (BOOL) playTrackAtIndex: (NSInteger) index {
    if (index < 0 || index >= self.items.count){
        NSLog(@"Can't find the audio track at the index: (%ld)", index);
        return NO;
    }
    NKAudioTrack* track = self.items[index];
    self.currentAudioTrack = track;
    [self playTrackWithURL: track.url];
    
    self.currentTrackIndex = index;
    
    if ([self.delegate respondsToSelector: @selector(trackDidStartPlayingWithIndex:)]){
        [self.delegate trackDidStartPlayingWithIndex: index];
    }
    [self.remoteControlCenter presentAudioTrack: track];
    return YES;
}

- (BOOL) playNext {
    return [self playTrackAtIndex: self.currentTrackIndex + 1];
}

- (BOOL) playPrevious {
    return [self playTrackAtIndex: self.currentTrackIndex - 1];
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

- (void) seekToPosition: (CGFloat) position {
    CGFloat durationInSeconds = CMTimeGetSeconds([self.player.currentItem duration]);
    CGFloat seconds = durationInSeconds * position;
    CMTime seekTime = CMTimeMakeWithSeconds(seconds, self.player.currentTime.timescale);
    [self.player seekToTime: seekTime];
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
    
    [self addObserversToPlayer: player];
    
    return player;
}

- (void) destroyCurrentPlayer {
    [self removePlayerObservers];
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
}

- (void) itemDidFinishPlaying: (NSNotification*) notification {
    [self playNext];
}


#pragma mark - Observarion

- (void) addObserversToPlayer: (AVPlayer*) player {
    @weakify(self)
    CMTime cmtime = CMTimeMake(1, 10);
    self.timeObserver = [player addPeriodicTimeObserverForInterval: cmtime
                                                             queue: NULL
                                                        usingBlock:^(CMTime time) {
                                                            @strongify(self)
                                                            [self audioProgressDidChangeTo: time];
                                                        }];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(itemDidFinishPlaying:)
                                                 name: AVPlayerItemDidPlayToEndTimeNotification
                                               object: player.currentItem];
}

- (void) removePlayerObservers {
    [self.player removeTimeObserver: self.timeObserver];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: AVPlayerItemDidPlayToEndTimeNotification
                                                  object: self.player.currentItem];
}

-(void)observeValueForKeyPath: (NSString *)keyPath
                     ofObject: (id)object
                       change: (NSDictionary<NSString *,id> *)change
                      context: (void *)context {
}

@end
