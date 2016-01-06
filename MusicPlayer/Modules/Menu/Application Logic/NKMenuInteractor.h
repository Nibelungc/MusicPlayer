//
//  NKMenuInteractor.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKMenuInteractorIO.h"
#import "NKAudioService.h"

@protocol NKDataStorage;

@interface NKMenuInteractor : NSObject <NKMenuInteractorInput>

@property (weak, nonatomic) id<NKMenuInteractorOutput> output;

@property (strong, nonatomic) id <NKDataStorage> dataStorage;

@property (strong, nonatomic) id <NKAudioService> audioService;

- (void) getMenuItems;

- (void) getUser;

- (void) logout;

@end
