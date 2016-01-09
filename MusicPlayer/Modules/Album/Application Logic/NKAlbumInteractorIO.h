//
//  NKAlbumInteractorIO.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NKAlbumInteractorInput <NSObject>

- (void) getTracksForAlbumID: (NSNumber*) identifier;

@end

@protocol NKAlbumInteractorOutput <NSObject>

- (void) tracksNotFoundWithError: (NSError*) errorOrNil;

- (void) tracksFound: (NSArray*) audioTracks;

@end
