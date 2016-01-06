//
//  NKAudioAlbum+VKService.m
//  MusicPlayer
//
//  Created by Denis Baluev on 06/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioAlbum+VKService.h"

static NSString* const kIdKey = @"id";
static NSString* const kOwnerIdKey = @"owner_id";
static NSString* const kTitleKey = @"title";

@implementation NKAudioAlbum (VKService)

/* Album json model
    id = 67930243;
    "owner_id" = 174600511;
    title = Test;
*/

- (instancetype) initWithVKJson: (NSDictionary*) json {
    if (self = [super init]){
        self.identifier = json[kIdKey];
        self.title = json[kTitleKey];
    }
    return self;
}

@end
