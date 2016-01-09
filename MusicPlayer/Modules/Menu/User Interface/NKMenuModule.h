//
//  NKMenuModule.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKModule.h"

@protocol NKMenuModule <NKModule>

- (void) menuItemChosenWithIdentifier: (NSNumber*) identifier;

- (void) userLogoutAction;

@end
