//
//  NKApplicationConfigurator.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKApplicationConfigurator.h"
#import "NKRootWireframe.h"

@interface NKApplicationConfigurator ()

@property (strong, nonatomic) NKRootWireframe* rootWireframe;

@end

@implementation NKApplicationConfigurator

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configurateDependencies];
    }
    return self;
}

- (void) configurate {
    
}

- (void) configurateDependencies {
    self.rootWireframe = [[NKRootWireframe alloc] init];
}


@end
