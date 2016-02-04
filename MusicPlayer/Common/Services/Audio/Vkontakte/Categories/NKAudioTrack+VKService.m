//
//  NKAudioTrack+VKService.m
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioTrack+VKService.h"
#import <VKApiConst.h>
#import <objc/runtime.h>

static char owner_id_hash_key;
static char recently_deleted_hash_key;

NSString* const kVK_API_AUDIOTRACK_ID = @"audio_id";
NSString* const kVK_API_ITEMS = @"items";

@implementation NKAudioTrack (VKService)

/* VK Audio Album JSON model {
    "album_id" = 68827758;
    artist = "Hi_Tack";
    date = 1433953773;
    duration = 184;
    "genre_id" = 22;
    id = 372569046;
    "lyrics_id" = 3699790;
    "owner_id" = 174600511;
    title = "Say Say Say";
    url = "https://psv4.vk.me/c1039/u455992/audios/d55ab1b9d7fa.mp3?extra=gkMx4ESgRsZzrT69WtMkwv5C8A8uJS0r7b1S4Fl_EB6oRox0oLma4sh01mSq3kh8pkdVtC44wnBvmRSdt8wvLp0B8AJB5A";
}
*/

- (instancetype) initWithVKJson: (NSDictionary*) json {
    if (self = [super init]){
        self.identifier = json[@"id"];
        self.artist = json[@"artist"];
        self.title = json[@"title"];
        self.duration = json[@"duration"];
        self.url = [NSURL URLWithString: json[@"url"]];
        self.ownerID = json[@"owner_id"];
    }
    return self;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"id: %ld / owner_id: %ld", self.identifier.integerValue, self.ownerID.integerValue];
}

#pragma mark - Accessors

- (NSNumber *)ownerID {
    return objc_getAssociatedObject(self, &owner_id_hash_key);
}

- (void) setOwnerID:(NSNumber *)ownerID {
    objc_setAssociatedObject(self, &owner_id_hash_key, ownerID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) isRecentlyDeleted {
    NSNumber* wrapper = objc_getAssociatedObject(self, &recently_deleted_hash_key);
    return wrapper.boolValue;
}

- (void) setRecentlyDeleted: (BOOL) recentlyDeleted {
    NSNumber* wrapper = @(recentlyDeleted);
    objc_setAssociatedObject(self, &recently_deleted_hash_key, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
