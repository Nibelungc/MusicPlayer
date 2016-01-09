//
//  NKMenuInteractor.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuInteractor.h"

#import "NKMenuItem.h"
#import "NKUser.h"
#import "NKDataStorage.h"
#import "NKAudioAlbum.h"

@implementation NKMenuInteractor

#pragma mark - NKMenuInteractorInput

- (void) getMenuItems {
    @weakify(self)
    [self.audioService getAlbumsWithCompletion:^(NSArray<NKAudioAlbum *> * _Nullable albums, NSError * _Nullable errorOrNil) {
        @strongify(self)
        if (errorOrNil == nil) {
            NSArray* menuItems = [albums map:^id(NKAudioAlbum* album) {
                NKMenuItem* item = [[NKMenuItem alloc] init];
                NSInteger index = [albums indexOfObject: album];
                item.index = @(index);
                item.title = album.title;
                item.identifier = album.identifier;
                return item;
            }];
            [self.output menuItemsWereFound: menuItems];
        } else {
            [self.output menuItemsNotFound: errorOrNil];
        }
    }];
}

- (void) getUser {
    __weak typeof(self) welf = self;
    [self.dataStorage fetchSavedUser:^(NKUser * _Nullable user) {
        [welf.output userWasFound: user];
    }];
}

- (void) logout {
    [self.audioService forceLogout];
    [self.output logoutCompleted];
}

@end
