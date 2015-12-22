//
//  NKThirdPartiesConfigurator.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NKThirdPartiesConfigurator.h"

#import "VkSdk.h"
#import "VKontakteAudioService.h"

NSString* const VK_APP_ID = @"5195154";

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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    BOOL successHandling = YES;
    successHandling = [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return successHandling;
}


@end
