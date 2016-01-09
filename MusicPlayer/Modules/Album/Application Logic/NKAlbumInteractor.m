//
//  NKAlbumInteractor.m
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAlbumInteractor.h"
#import "NKAudioService.h"


@implementation NKAlbumInteractor

- (void) getTracksForAlbumID: (NSNumber*) identifier {
    @weakify(self)
    [self.audioService getAudioTracksForAlbumIdentifier: identifier
     withCompletion:^(NSArray<NKAudioTrack *> * _Nullable tracks, NSError * _Nullable errorOrNil) {
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
     }];
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

@end
