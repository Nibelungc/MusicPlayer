//
//  NKAlbumPresenter.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKBasePresenter.h"
#import "NKAlbumModule.h"
#import "NKAlbumInteractorIO.h"

@protocol NKAlbumView;
@class NKAlbumWireframe;

@interface NKAlbumPresenter : NKBasePresenter <NKAlbumModule, NKAlbumInteractorOutput>

@property (strong, nonatomic) UIViewController<NKAlbumView>* output;

@property (strong, nonatomic) id<NKAlbumInteractorInput> interactor;

@property (weak, nonatomic) NKAlbumWireframe* albumWireframe;

@property (strong, nonatomic) NSNumber* albumID;

#pragma mark - NKAlbumModule

- (void) selectAudioTrackWithID: (NSNumber*) trackID;

- (void) deselectAudioTrackWithID: (NSNumber*) trackID;

- (void) configureWithAlbumID: (NSNumber*) albumID;

- (void) albumWasLoaded;

- (void) playAudioTrackWithID: (NSNumber*) trackID;

- (void) stopPlayingAudio;

- (void) playNextAudioTrack;

- (void) playPreviousAudioTrack;

@end
