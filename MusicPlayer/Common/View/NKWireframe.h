//
//  NKWireframe.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIWindow;

@protocol NKWireframe <NSObject>

- (void) presentInterfaceFromWindow: (UIWindow*) window;

@end
