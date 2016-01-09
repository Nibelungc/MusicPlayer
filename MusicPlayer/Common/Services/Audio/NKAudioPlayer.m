//
//  NKAudioPlayer.m
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioPlayer.h"

#import <AVFoundation/AVFoundation.h>

@interface NKAudioPlayer ()

@property (strong, nonatomic) AVPlayer* player;

@end

@implementation NKAudioPlayer

- (void) playTrackWithURL: (NSURL*) url {
    [self stop];
    self.player = [AVPlayer playerWithURL: url];
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

@end
