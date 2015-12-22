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

@implementation NKMenuWireFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        NKMenuInteractor* interactor = [[NKMenuInteractor alloc] init];
        NKMenuPresenter* presenter = [[NKMenuPresenter alloc] init];
        NKMenuViewController* view = [[NKMenuViewController alloc] init];
        
        interactor.output = presenter;
        
        presenter.interactor = interactor;
        presenter.output = view;
        
        view.eventHandler = presenter;
        
        _presenter = presenter;
    }
    return self;
}

@end
