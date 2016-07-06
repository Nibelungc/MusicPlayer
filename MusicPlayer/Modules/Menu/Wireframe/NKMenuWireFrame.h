//
//  NKMenuWireFrame.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKMenuPresenter.h"
#import "NKWireframe.h"

@class UIViewController;
@class NKLoginWireframe;
@class NKAlbumWireframe;

@protocol NKMenuModule;

@interface NKMenuWireFrame : NSObject <NKWireframe>

@property (strong, nonatomic) NKMenuPresenter* presenter;

@property (strong, nonatomic) NKLoginWireframe* loginWireframe;

@property (strong, nonatomic) NKAlbumWireframe* albumWireframe;

@property (weak, nonatomic) UIWindow* applicationWindow;

- (void) goToLoginModule;

- (void) menuLoadedWithInitialItemID: (NSNumber*) initialAlbumID;

- (void) configureModuleWithItemID: (NSNumber*) identifier;

- (void) closeMenu;

- (void) toggleMenu;

@end
