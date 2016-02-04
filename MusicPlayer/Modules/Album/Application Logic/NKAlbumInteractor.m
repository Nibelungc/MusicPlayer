//
//  NKAlbumInteractor.m
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAlbumInteractor.h"
#import "NKAudioService.h"
#import "NKAudioTrack.h"

@implementation NKAlbumInteractor

- (void) toogleFavoriteForAudioTrack: (NKAudioTrack*) track {
    @weakify(self)
    NKAudioServiceCompletion completion = ^(BOOL success, NSError * _Nullable errorOrNil){
        @strongify(self)
        if (errorOrNil){
            [self.output toogleFavoriteOperationFailed: errorOrNil];
        } else{
            [self.output favoriteValueChangedForAudioTrack: track];
        }
    };
    
    if (track.isFavorite){
        [self.audioService removeAudioTrackFromFavorite: track
                                             completion: completion];
    } else {
        [self.audioService addAudioTrackToFavorite: track
                                        completion: completion];
    }
}

- (void) getTracksForAlbumID: (NSNumber*) identifier {
    [self.audioService getAudioTracksForAlbumIdentifier: identifier
                                         withCompletion:[self defaultTracksCompletion]];
}

- (void) getTitleForAlbumID: (NSNumber*) identifier {
    @weakify(self)
    [self.audioService getAlbumTitleForIdentifier: identifier
     withCompletion:^(NSString * _Nullable title, NSError * _Nullable errorOrNil) {
         @strongify(self)
         if (errorOrNil == nil){
             [self.output albumTitleFound: title];
         } else {
             [self.output albumTitleNotFoundWithError: errorOrNil];
         }
     }];
}

- (void) getTracksForSearchingText:(NSString *)text {
    [self.audioService getAudioTracksForSearchString: text
                                      withCompletion: [self defaultTracksCompletion]];
}

- (NKAudioServiceTracksCompletion) defaultTracksCompletion {
    @weakify(self)
    return ^(NSArray<NKAudioTrack *> * _Nullable tracks, NSError * _Nullable errorOrNil) {
        @strongify(self)
        if (errorOrNil == nil) {
            if (tracks.count > 0) {
                [self.output tracksFound: tracks];
            } else {
                [self.output tracksNotFoundWithError: nil];
            }
        } else {
            [self.output tracksNotFoundWithError: errorOrNil];
        }
    };
}

@end
