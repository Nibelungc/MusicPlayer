//
//  NKMenuPresenter.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKMenuInteractorIO.h"
#import "NKBasePresenter.h"
#import "NKMenuModule.h"

@protocol NKMenuView;

@interface NKMenuPresenter : NKBasePresenter <NKMenuInteractorOutput, NKMenuModule>

@property (strong, nonatomic) id <NKMenuInteractorInput> interactor;

@property (strong, nonatomic) UIViewController<NKMenuView>* output;

@end
