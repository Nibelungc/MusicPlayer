//
//  NKLoginPresenter.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKLoginModule.h"
#import "NKBasePresenter.h"
#import "NKLoginInteractorIO.h"

@class NKLoginWireframe;

@protocol NKLoginView;

@interface NKLoginPresenter : NKBasePresenter <NKLoginModule, NKLoginInteractorOutput>

@property (strong, nonatomic) UIViewController<NKLoginView>* output;

@property (strong, nonatomic) id <NKLoginInteractorInput> interactor;

@property (weak, nonatomic) NKLoginWireframe* loginWireframe;

@end
