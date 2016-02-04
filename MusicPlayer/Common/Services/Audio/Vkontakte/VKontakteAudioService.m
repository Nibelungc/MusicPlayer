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
#import "NKAudioAlbum+VKService.h"
#import "NKAudioTrack+VKService.h"

NSString * const VKServiceTitle = @"Vkontakte";


NSInteger const kDefaultItemsCountForFetch = 200;

static NSDictionary* albumsTitles;

@interface VKontakteAudioService () <VKSdkUIDelegate>

@property (nonatomic, copy) NKAudioServiceLoginCompletion loginCompletion;

@property (strong, nonatomic) NSArray* permissions;

@end

@implementation VKontakteAudioService

@synthesize title;

- (instancetype)init{
    self = [super init];
    if (self) {
        title = VKServiceTitle;
        _permissions = @[VK_PER_AUDIO];
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

#pragma mark - NKAudioService

- (void) loginWithCompletion: (_Nonnull NKAudioServiceLoginCompletion) completion {
    self.loginCompletion = completion;
    
    [[VKSdk instance] setUiDelegate: self];
    
    [self wakeUpSessionWithCompletion:^(NKUser * _Nullable user, NSError * _Nullable errorOrNil) {
        if (user) {
            completion([self userFromVKSdk], nil);
        } else {
            [VKSdk authorize: self.permissions];
        }
    }];
    
}

- (void) forceLogout {
//    Cannot log in again after forceLogout. No error occurs, only vkSdkUserAuthorizationFailed invokes
//    [VKSdk forceLogout];
}

- (void) wakeUpSessionWithCompletion: (_Nonnull NKAudioServiceLoginCompletion) completion {
    
    [VKSdk wakeUpSession: self.permissions
           completeBlock:^(VKAuthorizationState state, NSError *error) {
               if (state == VKAuthorizationAuthorized){
                   completion([self userFromVKSdk], nil);
               } else {
                   completion(nil, error);
               }
           }];
}

- (void) getAudioTracksForSearchString: (NSString* _Nonnull) searchString withCompletion: (_Nonnull NKAudioServiceSearchCompletion) completion {
    if (!searchString){
        completion(nil, nil);
        return;
    }
    NSString* methodName = @"search";
    NSDictionary* parametrs = @{VK_API_Q        : searchString,
                                VK_API_COUNT    : @(kDefaultItemsCountForFetch) };
    
    VKRequest* request = [VKApi requestWithMethod: [self audioRequsetWithMethodName: methodName]
                                    andParameters: parametrs];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray* tracksJson = response.json[kVK_API_ITEMS];
        NSArray* tracks = [tracksJson map:^id(id obj) {
            return [[NKAudioTrack alloc] initWithVKJson: obj];
        }];
        completion(tracks, nil);
    } errorBlock:^(NSError *error) {
        completion(nil, error);
    }];
}

- (void) getAudioTracksForAlbumIdentifier: (NSNumber* _Nullable) identifier withCompletion: (_Nonnull NKAudioServiceTracksCompletion) completion {
    NSString* methodName = @"get";
    NSDictionary* parametrs = @{VK_API_OWNER_ID : [self currentUserID],
                                VK_API_ALBUM_ID : ZeroOrNSNumber(identifier)};
    
    VKRequest* request = [VKApi requestWithMethod: [self audioRequsetWithMethodName: methodName]
                                    andParameters: parametrs];
    [request executeWithResultBlock:^(VKResponse *response) {
        
        NSArray* tracksJson = response.json[kVK_API_ITEMS];
        NSArray* tracks = [tracksJson map:^id(id obj) {
            NKAudioTrack* track = [[NKAudioTrack alloc] initWithVKJson: obj];
            if ([self isAlbumFavorite: identifier]){
                track.favorite = YES;
            }
            return track;
        }];
        
        completion(tracks, nil);
    } errorBlock:^(NSError *error) {
        completion(nil, error);
    }];
}

- (void) getAlbumsWithCompletion: (_Nonnull NKAudioServiceAlbumsCompletion) completion {
    NSString* methodName = @"getAlbums";
    NSString* userId = [self currentUserID];
    NSDictionary* parametrs = @{VK_API_OWNER_ID : userId,
                                VK_API_COUNT    : @(20)};
    VKRequest* request = [VKApi requestWithMethod: [self audioRequsetWithMethodName: methodName]
                                    andParameters: parametrs];
    
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray* albumsJson = response.json[kVK_API_ITEMS];
        NSArray* albums = [albumsJson map:^id(id json) {
            return [[NKAudioAlbum alloc] initWithVKJson: json];
        }];
        NSMutableArray* albumsWithMyMusic = [NSMutableArray arrayWithArray: albums];
        [albumsWithMyMusic insertObject: [self myMusicAlbum] atIndex: 0];
        [self saveAlbumsTitlesForAlbums: albumsWithMyMusic];
        completion(albumsWithMyMusic, nil);
    } errorBlock:^(NSError *error) {
        completion(nil, error);
    }];
}

- (void) getAlbumTitleForIdentifier: (NSNumber* _Nullable) identifier
                     withCompletion: (_Nonnull NKAudioServiceAlbumNameCompletion) completion {
    completion(albumsTitles[ZeroOrNSNumber(identifier)], nil);
}

#pragma mark - Favorite

- (void) restoreFavoriteAudioTrack: (nonnull NKAudioTrack*) audioTrack
                        completion: (nonnull NKAudioServiceCompletion) completion {
    
    NSString* methodName = @"restore";
    
    NSDictionary* params = @{VK_API_OWNER_ID        : audioTrack.ownerID,
                             kVK_API_AUDIOTRACK_ID  : audioTrack.identifier};
    
    VKRequest* request = [VKRequest requestWithMethod: [self audioRequsetWithMethodName: methodName]
                                        andParameters: params];
    [request executeWithResultBlock:^(VKResponse *response) {
        audioTrack.favorite = YES;
        audioTrack.recentlyDeleted = NO;
        completion(YES, nil);
    } errorBlock:^(NSError *error) {
        completion(NO, error);
    }];
}

- (NSNumber*) favoriteAlbumID {
    return @(0);
}

- (void) addAudioTrackToFavorite: (nonnull NKAudioTrack*) audioTrack
                      completion: (nonnull NKAudioServiceCompletion) completion {
    if (audioTrack.isFavorite){
        completion(YES, nil);
        return;
    }
    
    if (audioTrack.isRecentlyDeleted){
        [self restoreFavoriteAudioTrack: audioTrack completion: completion];
        return;
    }
    
    NSString* methodName = @"add";
    NSDictionary* parametrs = @{kVK_API_AUDIOTRACK_ID   : audioTrack.identifier,
                                VK_API_OWNER_ID         : audioTrack.ownerID,
                                VK_API_ALBUM_ID         : [self favoriteAlbumID]};
    
    VKRequest* request = [VKRequest requestWithMethod: [self audioRequsetWithMethodName: methodName]
                                        andParameters: parametrs];
    
    [request executeWithResultBlock:^(VKResponse *response) {
        audioTrack.ownerID = [VKSdk accessToken].localUser.id;
        audioTrack.favorite = YES;
        audioTrack.identifier = response.json;
        completion(YES, nil);
    } errorBlock:^(NSError *error) {
        completion(NO, error);
    }];
}

- (void) removeAudioTrackFromFavorite: (nonnull NKAudioTrack*) audioTrack
                           completion: (nonnull NKAudioServiceCompletion) completion {
    if (!audioTrack.isFavorite){
        completion(YES, nil);
        return;
    }
    NSString* methodName = @"delete";
    NSDictionary* parametrs = @{kVK_API_AUDIOTRACK_ID   : audioTrack.identifier,
                                VK_API_OWNER_ID         : audioTrack.ownerID};
    
    VKRequest* request = [VKRequest requestWithMethod: [self audioRequsetWithMethodName: methodName]
                                        andParameters: parametrs];
    
    [request executeWithResultBlock:^(VKResponse *response) {
        audioTrack.favorite = NO;
        audioTrack.recentlyDeleted = YES;
        completion(YES, nil);
    } errorBlock:^(NSError *error) {
        completion(NO, error);
    }];
    
}

- (BOOL) isAlbumFavorite: (NSNumber*) identifier {
    return [identifier compare: [self favoriteAlbumID]] == NSOrderedSame;
}

#pragma mark - Private

- (void) saveAlbumsTitlesForAlbums: (NSArray <NKAudioAlbum *>*) albums {
    NSMutableDictionary* titles = [NSMutableDictionary dictionary];
    for (NKAudioAlbum* album in albums) {
        [titles setObject: album.title forKey: ZeroOrNSNumber(album.identifier)];
    }
    albumsTitles = [NSDictionary dictionaryWithDictionary: titles];
}

- (NKAudioAlbum*) myMusicAlbum {
    NKAudioAlbum* myMusic = [[NKAudioAlbum alloc] init];
    myMusic.identifier = nil;
    myMusic.title = @"My Music";
    return myMusic;
}

- (NSString*) currentUserID {
    return [NSString stringWithFormat:@"%@", [VKSdk accessToken].localUser.id];
}

- (NKUser*) userFromVKSdk {
    NKUser* user = [self userFromVKUser: [VKSdk accessToken].localUser];
    user.token = [VKSdk accessToken].accessToken;
    return [self userFromVKUser: [VKSdk accessToken].localUser];
}

- (NKUser*) userFromVKUser: (VKUser*) vkUser {
    if (!vkUser) { return nil; }
    NKUser* user = [[NKUser alloc] init];
    user.firstName = vkUser.first_name;
    user.lastName = vkUser.last_name;
    user.imageUrl = [NSURL URLWithString: vkUser.photo_100];
    user.audioService = NSStringFromClass([self class]);
    return user;
}

- (NSString*) audioRequsetWithMethodName: (NSString*) name {
    return [NSString stringWithFormat: @"audio.%@", name];
}

static id ZeroOrNSNumber(NSNumber* number) {
    return number ?: @(0);
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
    NKUser* user = [self userFromVKUser: result.user];
    user.token = result.token.accessToken;
    self.loginCompletion(user, nil);
}

/**
 Notifies delegate about access error, mostly connected with user deauthorized application
 */
- (void)vkSdkUserAuthorizationFailed{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.loginCompletion(nil, nil);
}

#pragma mark - VKSdkUIDelegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller{
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
