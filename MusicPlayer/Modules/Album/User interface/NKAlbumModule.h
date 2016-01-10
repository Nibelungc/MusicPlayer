//
//  NKAlbumModule.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKModule.h"

@protocol NKAlbumModule <NKModule>

@required

- (void) selectAudioTrackWithID: (NSNumber*) trackID;

- (void) deselectAudioTrackWithID: (NSNumber*) trackID;

- (void) configureWithAlbumID: (NSNumber*) albumID;

- (void) showPlayer;

- (void) albumWasLoaded;

- (void) playAudioTrackWithID: (NSNumber*) trackID;

- (void) stopPlayingAudio;

- (void) playNextAudioTrack;

- (void) playPreviousAudioTrack;

@end
