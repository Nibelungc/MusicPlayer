//
//  NKLoginInteractor.m
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKLoginInteractor.h"
#import "NKThirdPartiesConfigurator.h"
#import "NKAudioService.h"
#import "NKDataStorage.h"

@implementation NKLoginInteractor

- (void) getListOfServices {
    NSArray* services = [NKThirdPartiesConfigurator availableServices];
    [self.output setListOfServices: services];
}

- (void) loginWithService: (id <NKAudioService>) service{
    [service loginWithCompletion:^(NKUser * _Nullable user, NSError * _Nullable errorOrNil) {
        if (errorOrNil != nil) {
            [self.output loginFailedWithError: errorOrNil];
        } else {
            __block NKUser* currentUser = user;
            if (!currentUser){
                [self.dataStorage fetchSavedUser:^(NKUser * _Nullable savedUser) {
                    currentUser = savedUser;
                }];
            } else {
                [self.dataStorage saveUserAndDeleteOldOne: currentUser];
            }
            [self.output loginSucceededWithUser: currentUser];
        }
    }];
}

- (void) tryToWakeupLastSession{
    __weak typeof(self) welf = self;
    [self.dataStorage fetchSavedUser:^(NKUser * _Nullable user) {
        if (user){
            [welf.output lastSessionWokenUp];
        } else {
            [welf.output lastSessionWasntFound];
        }
    }];
}

@end
