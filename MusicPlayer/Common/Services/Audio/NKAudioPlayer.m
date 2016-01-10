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

@interface NKAudioPlayer ()

@property (strong, nonatomic) AVPlayer* player;

@property (strong, nonatomic) AVPlayerViewController* playerController;

@end

@implementation NKAudioPlayer

- (instancetype)init {
    self = [super init];
    if (self) {
        _playerController = [[AVPlayerViewController alloc] init];
        [[self class] configureAudioSession];
    }
    return self;
}

+ (void) configureAudioSession {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

#pragma mark - Playback control

- (void) playTrackWithURL: (NSURL*) url {
    [self stop];
    self.player = [AVPlayer playerWithURL: url];
    self.playerController.player = self.player;
    [self play];
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
}

#pragma mark - Presentation layer

- (UIViewController*) playerViewController {
    return self.playerController;
}

@end
