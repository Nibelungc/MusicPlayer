//
//  NKAlbumWireframe.m
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAlbumWireframe.h"

#import "NKAlbumPresenter.h"
#import "NKAlbumInteractor.h"
#import "NKCoreDataStorage.h"
#import "NKAudioService.h"
#import "NKAlbumVIewController.h"
#import "NKMenuWireFrame.h"
#import "NKDownloadsManager.h"

@implementation NKAlbumWireframe

- (instancetype)init {
    self = [super init];
    if (self) {
        NKAlbumPresenter* presenter = [[NKAlbumPresenter alloc] init];
        NKAlbumInteractor* interactor = [[NKAlbumInteractor alloc] init];
        NKCoreDataStorage* dataStorage = [[NKCoreDataStorage alloc] init];
        NKAlbumVIewController* view = [[NKAlbumVIewController alloc] init];
        
        presenter.interactor = interactor;
        presenter.output = view;
        presenter.albumWireframe = self;
        
        interactor.output = presenter;
        interactor.dataStorage = dataStorage;
        interactor.audioService = [dataStorage userAudioService];
        
        view.eventHandler = presenter;
        dataStorage.fileManager = [[NKDownloadsManager alloc] init];
        
        _presenter = presenter;
    }
    return self;
}

- (void) configureWithAlbumID: (NSNumber*) albumID {
    [self.presenter configureWithAlbumID: albumID];
}

- (void) closeMenu {
    [self.menuWireframe closeMenu];
}

- (void) toggleMenu {
    [self.menuWireframe toggleMenu];
}

@end
