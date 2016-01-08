//
//  NKBasePresenter.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKModule.h"

@class UIViewController;

@interface NKBasePresenter : NSObject <NKModule>

@property (strong, nonatomic) UIViewController* output;

@end
