//
//  NKMenuView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKView.h"

@class NKMenuItem;

@protocol NKMenuView <NKView>

@required

- (void) setMenuItems: (NSArray <NKMenuItem *>*) items;

- (void) setUserInfoWithName: (NSString*) name andImage: (UIImage*) image;

- (void) selectMenuItemWithIdentifier: (NSNumber*) identifier;

@end
