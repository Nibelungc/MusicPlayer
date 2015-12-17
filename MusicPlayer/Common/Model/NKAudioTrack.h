//
//  NKAudioTrack.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKAudioTrack : NSObject

@property (strong, nonatomic) NSNumber* identifier;

@property (strong, nonatomic) NSString* artist;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSNumber* duration;

@end
