//
//  NKBaseViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKBaseViewController.h"
#import "NKMessageService.h"
#import "NKApplicationFactory.h"

@implementation NKBaseViewController

#pragma mark - Lifecycle

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

- (void) showErrorMessage: (NSString*) message withTitle: (NSString*) title{
    [self.errorHandler showErrorMessage: message withTitle: title];
}

- (void) showMessage: (NSString*) message withTitle: (NSString*) title{
    [self.errorHandler showMessage: message withTitle: title];
}

#pragma mark - Accessors

- (id <NKMessageService>) errorHandler {
    if (!_errorHandler){
        _errorHandler = [NKApplicationFactory applicationErrorHandler];
    }
    return _errorHandler;
}

@end
