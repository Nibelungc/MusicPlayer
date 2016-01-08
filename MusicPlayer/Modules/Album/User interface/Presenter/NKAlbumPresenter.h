//
//  NKAlbumPresenter.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKBasePresenter.h"
#import "NKAlbumModule.h"
#import "NKAlbumInteractorIO.h"

@protocol NKAlbumView;
@class NKAlbumWireframe;

@interface NKAlbumPresenter : NKBasePresenter <NKAlbumModule, NKAlbumInteractorOutput>

@property (strong, nonatomic) UIViewController<NKAlbumView>* output;

@property (strong, nonatomic) id<NKAlbumInteractorInput> interactor;

@property (weak, nonatomic) NKAlbumWireframe* albumWireframe;

@end
