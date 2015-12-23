//
//  NKLoginWireframe.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKLoginWireframe.h"
#import <UIKit/UIKit.h>

#import "NKLoginViewController.h"
#import "NKLoginPresenter.h"
#import "NKLoginInteractor.h"

#import "NKMenuWireFrame.h"
#import <MMDrawerController.h>
#import <MMDrawerVisualState.h>

@implementation NKLoginWireframe

- (instancetype)init{
    self = [super init];
    if (self) {
        NKLoginViewController* loginViewcontroller = [[NKLoginViewController alloc] init];
        NKLoginPresenter* loginPresenter = [[NKLoginPresenter alloc] init];
        NKLoginInteractor* loginInteractor = [[NKLoginInteractor alloc] init];
        
        loginViewcontroller.eventHandler = loginPresenter;
        
        loginPresenter.output = loginViewcontroller;
        loginPresenter.interactor = loginInteractor;
        loginPresenter.loginWireframe = self;
        
        loginInteractor.output = loginPresenter;
        
        _loginPresenter = loginPresenter;
    }
    return self;
}

- (BOOL) hasLoggedUser{
#warning ask for any logged user (presenter/interactor?)
    return NO;
}

- (void) presentInterfaceFromWindow:(UIWindow *)window {
    window.rootViewController = self.loginPresenter.output;
    [window makeKeyAndVisible];
}

- (void) presentMainController {
    NKMenuWireFrame* menuWireframe = [[NKMenuWireFrame alloc] init];
    UIWindow* applicationWindow = [[UIApplication sharedApplication].delegate window];
    [menuWireframe presentInterfaceFromWindow:applicationWindow];
}

@end
