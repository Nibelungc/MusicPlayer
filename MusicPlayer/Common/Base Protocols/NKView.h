//
//  NKView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@protocol NKView <NSObject>

- (void) showErrorMessage: (NSString*) message withTitle: (NSString*) title;

- (void) showMessage: (NSString*) message withTitle: (NSString*) title;

@end
