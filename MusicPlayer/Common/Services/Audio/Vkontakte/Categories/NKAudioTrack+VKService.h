//
//  NKAudioTrack+VKService.h
//  MusicPlayer
//
//  Created by Denis Baluev on 09/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioTrack.h"

extern NSString* const kVK_API_AUDIOTRACK_ID;
extern NSString* const kVK_API_ITEMS;

@interface NKAudioTrack (VKService)

@property (strong, nonatomic) NSNumber* ownerID;

- (instancetype) initWithVKJson: (NSDictionary*) json;

@end
