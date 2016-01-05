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

@implementation NKMenuInteractor

#pragma mark - NKMenuInteractorInput

- (void) getMenuItems {
    [self.audioService getAlbumsWithCompletion:^(NSArray<NKAudioAlbum *> * _Nullable albums, NSError * _Nullable errorOrNil) {
        if (errorOrNil == nil) {
            NSArray* mapItems = [albums map:^id(id obj) {
                NKMenuItem* item = [[NKMenuItem alloc] init];
                NSInteger index = [albums indexOfObject: obj];
                item.title = [obj title];
                item.index = @(index);
                return item;
            }];
            [self.output menuItemsWereFound: mapItems];
        } else {
            [self.output menuItemsNotFound: errorOrNil];
        }
    }];
}

- (void) getUser {
    NKUser* user = [[NKUser alloc] init];
    user.firstName = @"Nikolay";
    user.lastName = @"Kagala";
    user.imageUrl = [[NSBundle mainBundle] URLForResource:@"music_background" withExtension:@"jpg"];
    [self.output userWasFound: user];
}

- (void) logout {
    NSLog(@"Logout finished");
    [self.output logoutCompleted];
}

@end
