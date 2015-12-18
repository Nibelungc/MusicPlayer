//
//  NKAudioAlbum.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKAudioTrack;

@interface NKAudioAlbum : NSObject

@property (strong, nonatomic) NSNumber* identifier;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSArray <NKAudioTrack *>* tracks;

@end
