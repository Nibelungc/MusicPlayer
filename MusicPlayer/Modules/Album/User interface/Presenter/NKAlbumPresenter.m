//
//  NKAlbumPresenter.m
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAlbumPresenter.h"
#import "NKAlbumView.h"
#import "NKAlbumWireframe.h"

@interface NKAlbumPresenter ()


@end

@implementation NKAlbumPresenter

@dynamic output;

#pragma mark - NKAlbumInteractorOutput

- (void) tracksNotFoundWithError: (NSError*) errorOrNil {
    if (errorOrNil == nil){
        [self.output showEmptyListOfAudioTracks];
    } else {
        [self.output showErrorMessage: errorOrNil.localizedDescription
                            withTitle: @"Ошибка загрузки песен"];
    }
}

- (void) tracksFound: (NSArray*) audioTracks {
    [self.output updateListOfAudioTracks: audioTracks];
}

- (void) albumTitleNotFoundWithError: (NSError*) error {
    [self.output showErrorMessage: error.localizedDescription withTitle: @"Ошибка получения названия альбома"];
}

- (void) albumTitleFound: (NSString*) title {
    [self.output setModuleTitle: title];
}

#pragma mark - NKAlbumModule

- (void) albumWasLoaded {
    [self.interactor getTitleForAlbumID: self.albumID];
    [self.albumWireframe closeMenu];
}

- (void) configureWithAlbumID: (NSNumber*) albumID {
    if (albumID && albumID.integerValue == self.albumID.integerValue){
        return;
    }
    self.albumID = albumID;
    [self.interactor getTracksForAlbumID: albumID];
}

- (void) loadView {
    if (self.albumID){
        [self.interactor getTracksForAlbumID: self.albumID];
    } else {
        [self.output showEmptyListOfAudioTracks];
    }
}

- (void) playAudioTrackWithID: (NSInteger) trackID {

}

- (void) stopPlayingAudio {

}

- (void) playNextAudioTrack {

}

- (void) playPreviousAudioTrack {

}

@end
