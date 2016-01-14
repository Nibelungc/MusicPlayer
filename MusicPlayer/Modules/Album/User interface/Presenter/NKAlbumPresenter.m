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
        if ([self.player isPlaying]){
            [self pausePlayingAudio];
        } else {
            [self.player play];
        }
    } else {
        [self playAudioTrackWithID: trackID];
    }
}

- (void) deselectAudioTrackWithID: (NSNumber*) trackID {
    [self playAudioTrackWithID: trackID];
}

- (void) albumWasLoaded {
    [self.interactor getTitleForAlbumID: self.albumID];
    NSArray* tracksUrls = [self.tracks map:^id(NKAudioTrack* track) {
        return track.url;
    }];
    self.player = [[NKAudioPlayer alloc] initWithItemsURLs:tracksUrls];
    self.player.delegate = self;
    
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
    NSInteger index = [self.tracks indexOfObject: track];
    [self.player playTrackAtIndex:index];
    self.playingTrackID = trackID;
    
    [self.output trackDidStartPlayingWithIndex: index];
}

- (void) stopPlayingAudio {
    [self.player stop];
}

- (void) pausePlayingAudio {
    [self.player pause];
}

- (void) showPlayer {
    [self.output presentPlayerController: [self.player playerViewController]];
}

- (void) playNextAudioTrack {
    [self.player playNext];
}

- (void) playPreviousAudioTrack {
    [self.player playPrevious];
}

#pragma mark - Private

- (NKAudioTrack*) audioTrackForID: (NSNumber*) identifier{
    NSArray* filteredTracks = [self.tracks filter:^BOOL(NKAudioTrack* track) {
        return track.identifier.integerValue == identifier.integerValue;
    }];
    return filteredTracks.firstObject;
}

@end

#pragma mark - NKAudioPlayerDelegate

@implementation NKAlbumPresenter (AudioPlayerDelegate)

- (void) trackDidStartPlayingWithIndex: (NSInteger) index {
    [self.output trackDidStartPlayingWithIndex: index];
}

- (void) trackDidStopPlayingWithIndex: (NSInteger) index {
    [self.output trackDidStopPlayingWithIndex: index];
}

@end
