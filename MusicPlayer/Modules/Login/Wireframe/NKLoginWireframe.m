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
#import "NKCoreDataStorage.h"

#import "NKMenuWireFrame.h"
#import <MMDrawerController.h>
#import <MMDrawerVisualState.h>

@interface NKLoginWireframe ()

@property (copy, nonatomic) NKLoginLastSessionCompletion lastSessionCompletion;

@end

@implementation NKLoginWireframe

- (instancetype)init{
    self = [super init];
    if (self) {
        NKLoginViewController* loginViewcontroller = [[NKLoginViewController alloc] init];
        NKLoginPresenter* loginPresenter = [[NKLoginPresenter alloc] init];
        NKLoginInteractor* loginInteractor = [[NKLoginInteractor alloc] init];
        NKCoreDataStorage* coreDataStorage = [[NKCoreDataStorage alloc] init];
        
        loginViewcontroller.eventHandler = loginPresenter;
        
        loginPresenter.output = loginViewcontroller;
        loginPresenter.interactor = loginInteractor;
        loginPresenter.loginWireframe = self;
        
        loginInteractor.output = loginPresenter;
        loginInteractor.dataStorage = coreDataStorage;
        
        _loginPresenter = loginPresenter;
    }
    return self;
}

- (void) loginWithLastSession: (void(^)(BOOL success)) completion {
    self.lastSessionCompletion = completion;
    [self.loginPresenter tryToLoginWithLastSession];
}

- (void) loginWithLastSessionEnded: (BOOL) success{
    self.lastSessionCompletion(success);
}

- (void) presentInterfaceFromWindow:(UIWindow *)window {
    [UIView transitionWithView: window
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve animations:^{
                           window.rootViewController = self.loginPresenter.output;
                       } completion:nil];
    [window makeKeyAndVisible];
}

- (void) presentMainController {
    NKMenuWireFrame* menuWireframe = [[NKMenuWireFrame alloc] init];
    UIWindow* applicationWindow = [[UIApplication sharedApplication].delegate window];
    [menuWireframe presentInterfaceFromWindow:applicationWindow];
    self.menuWireframe = menuWireframe;
}

@end
