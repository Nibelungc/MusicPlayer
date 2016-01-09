//
//  NKAudioPlayer.h
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKAudioPlayer : NSObject

- (void) playTrackWithURL: (NSURL*) url;

- (void) play;

- (void) pause;

- (void) stop;

@end
