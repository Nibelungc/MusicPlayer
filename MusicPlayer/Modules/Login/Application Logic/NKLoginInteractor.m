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

@implementation NKLoginInteractor

- (void) getListOfServices {
    NSArray* services = [NKThirdPartiesConfigurator availableServices];
    [self.output setListOfServices: services];
}

- (void) loginWithService: (id <NKAudioService>) service{
    [service loginWithCompletion:^(NKUser * _Nullable user, NSError * _Nullable errorOrNil) {
        if (errorOrNil) {
            [self.output loginFailedWithError: errorOrNil];
        } else {
            [self.output loginSucceededWithUser: user];
        }
    }];
}

- (void) tryToWakeupLastSession{
#warning Get user from data storage
}

@end
