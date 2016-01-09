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
#import "NKAlbumModule.h"

#import "NKLoginWireframe.h"
#import "NKAlbumWireframe.h"

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
        
        NKLoginWireframe* loginWireframe = [[NKLoginWireframe alloc] init];
        NKAlbumWireframe* albumWireframe = [[NKAlbumWireframe alloc] init];
        albumWireframe.menuWireframe = self;
        
        interactor.audioService = [dataStorage userAudioService];
        interactor.output = presenter;
        interactor.dataStorage = dataStorage;
        
        presenter.interactor = interactor;
        presenter.output = view;
        presenter.wireframe = self;
        
        view.eventHandler = presenter;
        
        _presenter = presenter;
        _loginWireframe = loginWireframe;
        _albumWireframe = albumWireframe;
    }
    return self;
}

- (void) presentInterfaceFromWindow: (UIWindow*) applicationWindow{
    _applicationWindow = applicationWindow;
    UIViewController<NKMenuView> *viewcontroller = self.presenter.output;
    
    UIViewController* centerViewcontroller = self.albumWireframe.presenter.output;

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

- (void) menuLoadedWithInitialItemID: (NSNumber*) initialItemID {
    [self.albumWireframe configureWithAlbumID: initialItemID];
}

- (void) configureAlbumModuleWithItemID: (NSNumber*) identifier {
    [self.albumWireframe configureWithAlbumID: identifier];
}

- (void) closeMenu {
    MMDrawerController* drawer = (MMDrawerController*) self.applicationWindow.rootViewController;
    [drawer closeDrawerAnimated: YES completion: nil];
}

@end
