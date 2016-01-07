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

@protocol NKMenuModule;

@interface NKMenuWireFrame : NSObject <NKWireframe>

@property (strong, nonatomic) NKMenuPresenter* presenter;

@property (strong, nonatomic) NKLoginWireframe* loginWireframe;

@property (weak, nonatomic) UIWindow* applicationWindow;

- (void) goToLoginModule;

@end
