//
//  NKLoginViewController.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NKBaseViewController.h"

#import "NKLoginView.h"
#import "NKLoginModule.h"

@interface NKLoginViewController : NKBaseViewController <NKLoginView>

@property (weak, nonatomic) id <NKLoginModule> eventHandler;

@end
