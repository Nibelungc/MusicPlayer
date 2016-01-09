//
//  NKAudioAlbum.m
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKAudioAlbum.h"

@implementation NKAudioAlbum

#pragma mark - Accessors

- (NSString*) title {
    if (!_title){
        return @"No name";
    }
    return _title;
}

@end
