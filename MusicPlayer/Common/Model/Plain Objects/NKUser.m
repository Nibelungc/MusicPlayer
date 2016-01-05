//
//  NKUser.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKUser.h"

@implementation NKUser

- (id <NKAudioService>) audioServiceImpl {
    id <NKAudioService> service = nil;
    Class clazz = NSClassFromString(self.audioService);
    service = [[clazz alloc] init];
    return service;
}

@end
