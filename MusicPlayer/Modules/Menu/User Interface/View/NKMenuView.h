//
//  NKMenuView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKView.h"

@protocol NKMenuView <NKView>

- (void) setMenuItemsWithTitles: (NSArray <NSString *>*) titles;

- (void) setUserInfoWithName: (NSString*) name andImage: (UIImage*) image;

@end
