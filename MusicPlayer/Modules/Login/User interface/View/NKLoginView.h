//
//  NKLoginView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NKView.h"

@protocol NKLoginView <NKView>

- (void) setServicesTitles: (NSArray <NSString *> *) titles;

@end
