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

#import "NKLoginWireframe.h"
#import "NKMenuWireFrame.h"

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

+ (void) getInitialWireframe: (void(^)(id <NKWireframe> wireframe)) completion {
    NKLoginWireframe* loginWireframe = [[NKLoginWireframe alloc] init];
    
    __block id <NKWireframe> initialWireframe = loginWireframe;
    
    [loginWireframe loginWithLastSession:^(BOOL success) {
        if (success) {
            initialWireframe = [[NKMenuWireFrame alloc] init];
        }
        completion(initialWireframe);
    }];
}

@end
