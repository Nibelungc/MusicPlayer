//
//  NKApplicationFactory.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKConfigurator.h"

@protocol NKAudioService;
@protocol NKMessageService;
@protocol NKWireframe;

@interface NKApplicationFactory : NSObject

+ (id<NKConfigurator>) thirdPartiesConfigurator;

+ (id<NKConfigurator>) applicationConfigurator;

+ (id<NKMessageService>) applicationErrorHandler;

+ (id<NKWireframe>) initialWireframe;

@end
