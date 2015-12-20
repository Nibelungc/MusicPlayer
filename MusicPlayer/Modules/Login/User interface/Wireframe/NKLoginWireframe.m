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

@implementation NKLoginWireframe

- (void) presentInterfaceFromWindow:(UIWindow *)window {
    
    NKLoginViewController* loginViewcontroller = [[NKLoginViewController alloc] init];
    NKLoginPresenter* loginPresenter = [[NKLoginPresenter alloc] init];
    NKLoginInteractor* loginInteractor = [[NKLoginInteractor alloc] init];
    
    loginViewcontroller.eventHandler = loginPresenter;
    
    loginPresenter.output = loginViewcontroller;
    loginPresenter.interactor = loginInteractor;
    loginPresenter.loginWireframe = self;
    
    loginInteractor.output = loginPresenter;
    
    self.loginPresenter = loginPresenter;
    
    window.rootViewController = loginViewcontroller;
    [window makeKeyAndVisible];
}

@end
