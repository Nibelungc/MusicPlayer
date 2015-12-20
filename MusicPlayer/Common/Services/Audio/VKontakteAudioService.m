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

@interface VKontakteAudioService ()

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
    [VKSdk authorize: @[VK_PER_AUDIO]];
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

@end
