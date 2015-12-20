//
//  NKApplicationFactory.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKApplicationFactory.h"

#import "NKThirdPartiesConfigurator.h"
#import "NKApplicationConfigurator.h"
#import "NKNotificationService.h"

@implementation NKApplicationFactory

+ (id<NKConfigurator>) thirdPartiesConfigurator{
    return [[NKThirdPartiesConfigurator alloc] init];
}

+ (id<NKConfigurator>) applicationConfigurator{
    return [[NKApplicationConfigurator alloc] init];
}

+ (id<NKMessageService>) applicationErrorHandler{
    return [[NKNotificationService alloc] init];
}

@end
