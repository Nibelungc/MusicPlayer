//
//  NKBaseViewController.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NKBaseModule.h"

@interface NKBaseViewController : UIViewController

@property (weak, nonatomic) id <NKBaseModule> eventHandler;

@end
