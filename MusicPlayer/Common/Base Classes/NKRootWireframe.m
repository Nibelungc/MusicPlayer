//
//  NKRootWireframe.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKRootWireframe.h"

#import "NKLoginWireframe.h"

@implementation NKRootWireframe

- (instancetype)initWithInitialWireframe: (id <NKWireframe>) wireframe{
    self = [super init];
    if (self) {
        _initialWireframe = wireframe;
    }
    return self;
}


@end
