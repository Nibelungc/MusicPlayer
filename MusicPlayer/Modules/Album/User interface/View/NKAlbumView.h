//
//  NKAlbumView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKView.h"

@class NKAudioTrack;
@class NKPlayerView;

@protocol NKAlbumView <NKView>

@required

- (void) updateListOfAudioTracks: (NSArray <NKAudioTrack *>*) audioTracks;

- (void) showEmptyListOfAudioTracks;

- (void) setModuleTitle: (NSString*) title;

- (void) presentPlayerView: (NKPlayerView*) playerView;

- (void) trackDidStartPlayingWithIndex: (NSInteger) index;

- (void) trackDidStopPlayingWithIndex: (NSInteger) index;

- (void) favoriteValueForTrackChanged: (NKAudioTrack*) track;

@end
