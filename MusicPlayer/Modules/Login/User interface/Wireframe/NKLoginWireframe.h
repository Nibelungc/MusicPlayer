//
//  NKLoginWireframe.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKWireframe.h"

@class NKRootWireframe;
@class NKLoginPresenter;

@interface NKLoginWireframe : NSObject <NKWireframe>

@property (weak, nonatomic) NKRootWireframe* rootWireframe;

@property (strong, nonatomic) NKLoginPresenter* loginPresenter;

@end
