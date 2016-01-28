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

- (void) configureWithAlbumID: (NSNumber*) albumID;

- (void) albumWasLoaded;

- (void) playAudioTrackWithID: (NSNumber*) trackID;

- (void) playNextAudioTrack;

- (void) playPreviousAudioTrack;

- (void) playOrPauseAudio;

- (void) needToAddPlayerWithHeight: (CGFloat) height;

- (void) findTracksForSearchingString: (NSString*) string;

@end
