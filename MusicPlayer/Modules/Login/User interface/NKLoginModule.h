//
//  NKLoginModule.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKModule.h"

@protocol NKLoginModule <NKModule>

- (void) loginActionWithServiceTitle: (NSString*) serviceTitle;

- (void) tryToLoginWithLastSession;

@end
