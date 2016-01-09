//
//  NKMenuItem.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKMenuItem : NSObject

@property (assign, nonatomic) NSNumber* index;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSNumber* identifier;

@end
