//
//  NKBaseViewController.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NKModule.h"
#import "NKView.h"

@protocol NKMessageService;

@interface NKBaseViewController : UIViewController <NKView>

@property (weak, nonatomic) id <NKModule> eventHandler;

@property (strong, nonatomic) id <NKMessageService> errorHandler;

@end
