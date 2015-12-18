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

@implementation NKApplicationFactory

+ (id<NKConfigurator>) thirdPartiesConfigurator{
    return [[NKThirdPartiesConfigurator alloc] init];
}

+ (id<NKConfigurator>) applicationConfigurator{
    return [[NKApplicationConfigurator alloc] init];
}

@end
