//
//  NKThirdPartiesConfigurator.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKThirdPartiesConfigurator.h"

#import "VkSdk.h"
#import "VKontakteAudioService.h"

#warning SET VK APP ID
NSString* const VK_APP_ID = @"";

@implementation NKThirdPartiesConfigurator

+ (NSArray*) availableServices {
    return @[ [VKontakteAudioService sharedService] ];
}

- (void) configurate {
    [self configurateVKSdk];
}

- (void) configurateVKSdk {
    VKSdk* sdk = [VKSdk initializeWithAppId: VK_APP_ID];
    [sdk registerDelegate: [VKontakteAudioService sharedService]];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL successHandling = YES;
    successHandling = [VKSdk processOpenURL: url fromApplication: sourceApplication];
    return successHandling;
}

@end
