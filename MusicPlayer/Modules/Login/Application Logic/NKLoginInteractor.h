//
//  NKLoginInteractor.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKLoginInteractorIO.h"

@protocol NKDataStorage;
@protocol NKAudioService;

@interface NKLoginInteractor : NSObject <NKLoginInteractorInput>

@property (weak, nonatomic) id <NKLoginInteractorOutput> output;

@property (strong, nonatomic) id <NKDataStorage> dataStorage;

- (void) getListOfServices;

- (void) loginWithService: (id <NKAudioService>) service;

- (void) tryToWakeupLastSession;

@end
