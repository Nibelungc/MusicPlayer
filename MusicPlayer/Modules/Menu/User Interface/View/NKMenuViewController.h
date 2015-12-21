//
//  NKMenuViewController.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKBaseViewController.h"

#import "NKMenuView.h"
#import "NKMenuModule.h"

@interface NKMenuViewController : NKBaseViewController <NKMenuView>

@property (weak, nonatomic) id <NKMenuModule> eventHandler;

@end
