//
//  NKRootWireframe.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKRootWireframe.h"

#import "NKLoginPresenter.h"

@implementation NKRootWireframe

- (id <NKBaseModule>) initialModule{
    return [[NKLoginPresenter alloc] init];
}

@end
