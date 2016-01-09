//
//  NKAlbumInteractorIO.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NKAlbumInteractorInput <NSObject>

@required

- (void) getTracksForAlbumID: (NSNumber*) identifier;

- (void) getTitleForAlbumID: (NSNumber*) identifier;

@end

@protocol NKAlbumInteractorOutput <NSObject>

@required

- (void) tracksNotFoundWithError: (NSError*) errorOrNil;

- (void) tracksFound: (NSArray*) audioTracks;

- (void) albumTitleNotFoundWithError: (NSError*) error;

- (void) albumTitleFound: (NSString*) title;

@end
