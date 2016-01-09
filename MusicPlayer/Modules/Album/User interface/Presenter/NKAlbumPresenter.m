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
#import "NKAudioPlayer.h"

#import "NKAudioTrack.h"

@interface NKAlbumPresenter ()

@property (strong, nonatomic) NKAudioPlayer* player;

@property (strong, nonatomic) NSArray <NKAudioTrack *>* tracks;

@property (strong, nonatomic) NSNumber* playingTrackID;

@end

@implementation NKAlbumPresenter

@dynamic output;

- (instancetype)init {
    self = [super init];
    if (self) {
        _player = [[NKAudioPlayer alloc] init];
    }
    return self;
}

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
    self.tracks = audioTracks;
    [self.output updateListOfAudioTracks: audioTracks];
}

- (void) albumTitleNotFoundWithError: (NSError*) error {
    [self.output showErrorMessage: error.localizedDescription withTitle: @"Ошибка получения названия альбома"];
}

- (void) albumTitleFound: (NSString*) title {
    [self.output setModuleTitle: title];
}

#pragma mark - NKAlbumModule

- (void) selectAudioTrackWithID: (NSNumber*) trackID {
    if (trackID.integerValue == self.playingTrackID.integerValue) {
        [self stopPlayingAudio];
    } else {
        [self playAudioTrackWithID: trackID];
    }
}

- (void) deselectAudioTrackWithID: (NSNumber*) trackID {
    [self playAudioTrackWithID: trackID];
}

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

- (void) playAudioTrackWithID: (NSNumber*) trackID {
    NKAudioTrack* track = [self audioTrackForID: trackID];
    [self.player playTrackWithURL: track.url];
    self.playingTrackID = trackID;
}

- (void) stopPlayingAudio {
    [self.player stop];
}

- (void) playNextAudioTrack {

}

- (void) playPreviousAudioTrack {

}

#pragma mark - Private

- (NKAudioTrack*) audioTrackForID: (NSNumber*) identifier{
    NSArray* filteredTracks = [self.tracks filter:^BOOL(NKAudioTrack* track) {
        return track.identifier.integerValue == identifier.integerValue;
    }];
    return filteredTracks.firstObject;
}

@end
