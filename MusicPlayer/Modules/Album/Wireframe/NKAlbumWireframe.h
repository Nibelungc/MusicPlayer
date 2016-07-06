//
//  NKAlbumWireframe.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKMenuWireFrame;
@protocol NKAlbumModule;

@interface NKAlbumWireframe : NSObject

@property (strong, nonatomic) id <NKAlbumModule> presenter;

@property (weak, nonatomic) NKMenuWireFrame* menuWireframe;

- (void) configureWithAlbumID: (NSNumber*) albumID;

- (void) closeMenu;

- (void) toggleMenu;

@end
