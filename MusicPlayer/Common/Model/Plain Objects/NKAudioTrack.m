//
//  NKAudioTrack.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKAudioTrack.h"

@implementation NKAudioTrack

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ - %@", self.artist, self.title];
}

@end
