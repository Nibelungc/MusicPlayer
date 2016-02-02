//
//  NKRemoteControlCenter.m
//  MusicPlayer
//
//  Created by Nikolay Kagala on 01/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "NKRemoteControlCenter.h"
#import "NKAudioPlayer.h"
#import "NKAudioTrack.h"

@implementation NKRemoteControlCenter

+ (instancetype) remoteControlCenterWithPlayer: (NKAudioPlayer*) player {
    NKRemoteControlCenter* rcc = [[NKRemoteControlCenter alloc] init];
    rcc.player = player;
    return rcc;
}

- (void) presentAudioTrack: (nonnull NKAudioTrack*) track {
    [self presentAudioTrack: track withImage: nil];
    [self loadArtworkForAudioTrack: track];
}

- (void) presentAudioTrack:(nonnull NKAudioTrack *)track withImage: (nullable UIImage*) image {
    NSString* title = track.title ?: @"Unknown track";
    NSString* artist = track.artist ?: @"Unknown artist";
    NSMutableDictionary* mediaInfo = [@{MPMediaItemPropertyTitle            : title,
                                        MPMediaItemPropertyAlbumTitle       : artist,
                                        MPMediaItemPropertyPlaybackDuration : track.duration} mutableCopy];
    if (image){
        MPMediaItemArtwork* artwork = [[MPMediaItemArtwork alloc] initWithImage: image];
        mediaInfo[MPMediaItemPropertyArtwork] = artwork;
    }
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaInfo];
}


- (void) loadArtworkForAudioTrack: (NKAudioTrack*) track {
    [self loadImageFromAudioTrack: track
                       completion:
     ^(UIImage *image, NSError *error) {
         if (error){
             NSLog(@"Error loading artwork for track: %@", track);
         } else if (image) {
             [self presentAudioTrack: track withImage: image];
         }
     }];
}

#pragma mark - Remote control

- (void) startReceivingRemoteControlEvents {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    MPRemoteCommandCenter* rc = [MPRemoteCommandCenter sharedCommandCenter];
    
    [rc.nextTrackCommand
     addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
         MPRemoteCommandHandlerStatus status = [self.player playNext] ? MPRemoteCommandHandlerStatusSuccess : MPRemoteCommandHandlerStatusNoActionableNowPlayingItem;
         return status;
     }];
    
    [rc.previousTrackCommand
     addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
         MPRemoteCommandHandlerStatus status = [self.player playPrevious] ? MPRemoteCommandHandlerStatusSuccess : MPRemoteCommandHandlerStatusNoActionableNowPlayingItem;
         return status;
     }];
    
    [rc.pauseCommand
     addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
         [self.player pause];
         return MPRemoteCommandHandlerStatusSuccess;
     }];
    
    [rc.playCommand
     addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
         [self.player play];
         return MPRemoteCommandHandlerStatusSuccess;
     }];
}

- (void) stopReceivingRemoteControlEvents {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

#pragma mark - Private

- (void) loadImageFromAudioTrack: (NKAudioTrack*) track
                      completion: (void(^)(UIImage* image, NSError* error)) completion{
    AVAsset *asset = [AVURLAsset URLAssetWithURL:track.url options:nil];
    
    NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                           withKey:AVMetadataCommonKeyArtwork
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        for (AVMetadataItem *item in artworks) {
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                NSData *data = [item.value copyWithZone:nil];
                completion([UIImage imageWithData: data], nil);
            } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                completion([UIImage imageWithData:[item.value copyWithZone:nil]], nil);
            }
        }
    }];
}

@end
