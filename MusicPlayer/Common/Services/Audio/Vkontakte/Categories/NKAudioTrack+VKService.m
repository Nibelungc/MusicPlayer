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

static char ownerIDHashKey;

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

- (NSNumber *)ownerID {
    return objc_getAssociatedObject(self, &ownerIDHashKey);
}

- (void) setOwnerID:(NSNumber *)ownerID {
    objc_setAssociatedObject(self, &ownerIDHashKey, ownerID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
