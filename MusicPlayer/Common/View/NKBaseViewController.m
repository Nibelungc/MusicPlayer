//
//  NKBaseViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKBaseViewController.h"

@implementation NKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.eventHandler respondsToSelector: @selector(loadView)]){
        [self.eventHandler loadView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.eventHandler respondsToSelector: @selector(updateView)]){
        [self.eventHandler updateView];
    }
}

#pragma mark - NKView

- (void) showErrorMessage: (NSString*) message{

}

- (void) showErrorMessage: (NSString*) message withTitle: (NSString*) title{

}

- (void) showMessage: (NSString*) message{

}

- (void) showMessage: (NSString*) message withTitle: (NSString*) title{

}

@end
