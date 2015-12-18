//
//  NKUser.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKUser : NSObject

@property (strong, nonatomic) NSString* token;

@property (strong, nonatomic) NSURL* imageUrl;

@property (strong, nonatomic) NSString* firstName;

@property (strong, nonatomic) NSString* lastName;

@end
