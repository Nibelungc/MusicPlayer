//
//  NKBaseModule.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NKModule <NSObject>

@property (strong, nonatomic) UIViewController* output;

@optional

- (void) updateView;

- (void) loadView;

@end
