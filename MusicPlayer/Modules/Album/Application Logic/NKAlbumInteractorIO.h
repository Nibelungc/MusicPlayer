//
//  NKAlbumInteractorIO.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKAudioTrack;

@protocol NKAlbumInteractorInput <NSObject>

@required

- (void) getTracksForAlbumID: (NSNumber*) identifier;

- (void) getTitleForAlbumID: (NSNumber*) identifier;

- (void) getTracksForSearchingText: (NSString*) text;

- (void) toogleFavoriteForAudioTrack: (NKAudioTrack*) track;

@end

@protocol NKAlbumInteractorOutput <NSObject>

@required

- (void) tracksNotFoundWithError: (NSError*) errorOrNil;

- (void) tracksFound: (NSArray*) audioTracks;

- (void) albumTitleNotFoundWithError: (NSError*) error;

- (void) albumTitleFound: (NSString*) title;

- (void) favoriteValueChangedForAudioTrack: (NKAudioTrack*) track;

- (void) toogleFavoriteOperationFailed: (NSError*) error;

@end
