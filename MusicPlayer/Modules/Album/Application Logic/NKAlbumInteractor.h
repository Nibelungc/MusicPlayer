//
//  NKAlbumInteractor.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKAlbumInteractorIO.h"

@protocol NKAlbumModule;
@protocol NKAudioService;
@protocol NKDataStorage;

@interface NKAlbumInteractor : NSObject <NKAlbumInteractorInput>

@property (weak, nonatomic) id<NKAlbumModule> output;

@property (strong, nonatomic) id<NKAudioService> audioService;

@property (strong, nonatomic) id<NKDataStorage> dataStorage;

@end
