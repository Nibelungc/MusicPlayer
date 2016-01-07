//
//  NKAudioAlbum+VKService.h
//  MusicPlayer
//
//  Created by Denis Baluev on 06/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioAlbum.h"

@interface NKAudioAlbum (VKService)

- (instancetype) initWithVKJson: (NSDictionary*) json;

@end
