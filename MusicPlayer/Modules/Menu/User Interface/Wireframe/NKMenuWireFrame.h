//
//  NKMenuWireFrame.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKMenuPresenter.h"

@class UIViewController;

@protocol NKMenuModule;

@interface NKMenuWireFrame : NSObject

@property (strong, nonatomic) NKMenuPresenter* presenter;

@end
