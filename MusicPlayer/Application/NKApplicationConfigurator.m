//
//  NKApplicationConfigurator.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NKApplicationConfigurator.h"
#import "NKRootWireframe.h"
#import "NKLoginWireframe.h"
#import "NKWireframe.h"

@interface NKApplicationConfigurator ()

@property (strong, nonatomic) NKRootWireframe* rootWireframe;

@end

@implementation NKApplicationConfigurator

- (instancetype)init{
    self = [super init];
    if (self) {
        NKLoginWireframe* initialWireframe = [[NKLoginWireframe alloc] init];
        _rootWireframe = [[NKRootWireframe alloc] initWithInitialWireframe:initialWireframe];
        initialWireframe.rootWireframe = _rootWireframe;
    }
    return self;
}

- (void) configurateWithWindow:(UIWindow *)window {
    [self configureApplicationAppearanceForWindow: window];
    [self.rootWireframe.initialWireframe presentInterfaceFromWindow: window];
}

- (void) configurate {
    UIWindow* window = [[UIApplication sharedApplication] windows].firstObject;
    [self configurateWithWindow: window];
}

- (void) configureApplicationAppearanceForWindow: (UIWindow*) window {
    [window setTintColor: [UIColor grayColor]];
    
}


@end
