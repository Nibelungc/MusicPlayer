//
//  VKontateAudioService.m
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "VKontakteAudioService.h"

#import "NKUser.h"
#import "NKAudioTrack.h"
#import "NKAudioAlbum.h"

NSString * const VKServiceTitle = @"Вконтакте";

@interface VKontakteAudioService () <VKSdkUIDelegate>

@property (nonatomic, copy) NKAudioServiceLoginComletion loginCompletion;

@end

@implementation VKontakteAudioService

@synthesize title;

#pragma mark - NKAudioService

- (instancetype)init{
    self = [super init];
    if (self) {
        title = VKServiceTitle;
    }
    return self;
}

+ (_Nonnull instancetype) sharedService{
    static VKontakteAudioService* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void) loginWithCompletion: (_Nonnull NKAudioServiceLoginComletion) completion {
    self.loginCompletion = completion;
    NSArray* permissions = @[VK_PER_AUDIO];
    
    [[VKSdk instance] setUiDelegate: self];
    [VKSdk wakeUpSession:permissions
           completeBlock:^(VKAuthorizationState state, NSError *error) {
               if (state == VKAuthorizationAuthorized){
                   self.loginCompletion(nil, nil);
               } else {
                   [VKSdk authorize: permissions];
               }
           }];
}



- (void) getAudioTracksForSearchString: (NSString* _Nonnull) searchString withCompletion: (_Nonnull NKAudioServiceSearchCompletion) completion {

}

- (void) getAudioTracksForAlbumIdentifier: (NSNumber* _Nonnull) identitier withCompletion: (_Nonnull NKAudioServiceTracksCompletion) completion {

}

- (void) getAlbumsWithCompletion: (_Nonnull NKAudioServiceAlbumsCompletion) completion {

}

#pragma mark - VKSdkDelegate

/**
 Notifies delegate about authorization was completed, and returns authorization result which presents new token or error.
 @param result contains new token or error, retrieved after VK authorization
 */
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result{
    if (result.error){
        self.loginCompletion(nil, result.error);
        return;
    }
    NKUser* user = [[NKUser alloc] init];
    user.token = result.token.accessToken;
    user.firstName = result.user.first_name;
    user.lastName = result.user.last_name;
    user.imageUrl = [NSURL URLWithString: result.user.photo_100];
    self.loginCompletion(user, nil);
}

/**
 Notifies delegate about access error, mostly connected with user deauthorized application
 */
- (void)vkSdkUserAuthorizationFailed{
    NSLog(@"VK authorization failed");
    self.loginCompletion(nil, nil);
}

#pragma mark - VKSdkUIDelegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller{
#warning Get viewcontroller by another way
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    [window.rootViewController presentViewController: controller animated: YES completion: nil];
}

/**
 Calls when user must perform captcha-check
 @param captchaError error returned from API. You can load captcha image from <b>captchaImg</b> property.
 After user answered current captcha, call answerCaptcha: method with user entered answer.
 */
- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"Need captcha enter: %@", captchaError);
}

@end
