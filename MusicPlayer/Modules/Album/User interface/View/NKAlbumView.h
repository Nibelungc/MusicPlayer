//
//  NKAlbumView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKView.h"

@class NKAudioTrack;

@protocol NKAlbumView <NKView>

@required

- (void) updateListOfAudioTracks: (NSArray <NKAudioTrack *>*) audioTracks;

- (void) showEmptyListOfAudioTracks;

- (void) setModuleTitle: (NSString*) title;

- (void) presentPlayerController: (UIViewController*) playerController;

@end
