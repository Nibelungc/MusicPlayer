//
//  NKRootWireframe.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NKModule;
@protocol NKWireframe;

@interface NKRootWireframe : NSObject

@property (strong, nonatomic) id <NKWireframe> initialWireframe;

- (instancetype)initWithInitialWireframe: (id <NKWireframe>) wireframe;

@end
