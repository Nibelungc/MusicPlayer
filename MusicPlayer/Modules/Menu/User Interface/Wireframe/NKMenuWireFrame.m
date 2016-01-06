//
//  NKMenuWireFrame.m
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKMenuWireFrame.h"

#import "NKMenuInteractor.h"
#import "NKMenuPresenter.h"
#import "NKMenuViewController.h"
#import "NKCoreDataStorage.h"
#import "NKUser.h"
#import "NKLoginWireframe.h"

#import <MMDrawerController.h>
#import <MMDrawerVisualState.h>

@implementation NKMenuWireFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        NKMenuInteractor* interactor = [[NKMenuInteractor alloc] init];
        NKMenuPresenter* presenter = [[NKMenuPresenter alloc] init];
        NKMenuViewController* view = [[NKMenuViewController alloc] init];
        NKCoreDataStorage* dataStorage = [[NKCoreDataStorage alloc] init];
        [dataStorage fetchSavedUser:^(NKUser * _Nullable user) {
            interactor.audioService = [user audioServiceImpl];
        }];
        
        interactor.output = presenter;
        interactor.dataStorage = dataStorage;
        
        presenter.interactor = interactor;
        presenter.output = view;
        presenter.wireframe = self;
        
        view.eventHandler = presenter;
        
        _presenter = presenter;
        _loginWireframe = [[NKLoginWireframe alloc] init];
    }
    return self;
}

- (void) presentInterfaceFromWindow: (UIWindow*) applicationWindow{
    _applicationWindow = applicationWindow;
    UIViewController<NKMenuView> *viewcontroller = self.presenter.output;
    
    UIViewController* centerViewcontroller = [[UIViewController alloc] init];
    centerViewcontroller.view.backgroundColor = [UIColor cyanColor];
    UINavigationController* mainNavigationController = [[UINavigationController alloc] initWithRootViewController: centerViewcontroller];
    
    MMDrawerController* drawerController = [self drawerControllerWithCenterVC: mainNavigationController
                                                                    andLeftVC: viewcontroller];
    
    [UIView transitionWithView: applicationWindow
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve animations:^{
                           applicationWindow.rootViewController = drawerController;
                       } completion:nil];
}


- (MMDrawerController*) drawerControllerWithCenterVC: (UIViewController*) centerVC andLeftVC: (UIViewController*) leftVC {
    MMDrawerController* drawerController = [[MMDrawerController alloc] initWithCenterViewController: centerVC
                                                                           leftDrawerViewController: leftVC];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask: MMCloseDrawerGestureModeAll];
    drawerController.shouldStretchDrawer = NO;
    [drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideAndScaleVisualStateBlock]];
    return drawerController;
}

- (void) goToLoginModule {
    [self.loginWireframe presentInterfaceFromWindow: self.applicationWindow];
}

@end
