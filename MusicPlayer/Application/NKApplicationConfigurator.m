//
//  NKApplicationConfigurator.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MagicalRecord/MagicalRecord.h>
#import "NKApplicationConfigurator.h"

#import "NKApplicationFactory.h"
#import "NKRootWireframe.h"
#import "NKLoginWireframe.h"
#import "NKWireframe.h"

static NSString* const kCoreDataModelName = @"MusicPlayer";

@interface NKApplicationConfigurator ()

@property (strong, nonatomic) NKRootWireframe* rootWireframe;

@end

@implementation NKApplicationConfigurator

- (void) configurateWithWindow:(UIWindow *)window {
    [self setupCoreDataStack];
    @weakify(self)
    [NKApplicationFactory getInitialWireframe:^(id<NKWireframe> wireframe) {
        @strongify(self)
        self.rootWireframe = [[NKRootWireframe alloc] initWithInitialWireframe:wireframe];
        [self configureApplicationAppearanceForWindow: window];
        [self.rootWireframe.initialWireframe presentInterfaceFromWindow: window];
    }];
}

- (void) configurate {
    UIWindow* window = [[UIApplication sharedApplication] windows].firstObject;
    [self configurateWithWindow: window];
}

- (void) setupCoreDataStack {
    [MagicalRecord setupCoreDataStackWithStoreNamed: kCoreDataModelName];
}

- (void) configureApplicationAppearanceForWindow: (UIWindow*) window {
    [window setTintColor: [UIColor grayColor]];
}


@end
