//
//  NKRemoteControlCenter.h
//  MusicPlayer
//
//  Created by Nikolay Kagala on 01/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKAudioPlayer;
@class NKAudioTrack;

@interface NKRemoteControlCenter : NSObject

@property (strong, nonatomic, nonnull) NKAudioPlayer* player;

+ (nonnull instancetype) remoteControlCenterWithPlayer: (nonnull NKAudioPlayer*) player;

- (void) startReceivingRemoteControlEvents;

- (void) stopReceivingRemoteControlEvents;

- (void) presentAudioTrack: (nonnull NKAudioTrack*) track;

@end
