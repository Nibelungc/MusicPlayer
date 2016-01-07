//
//  NKUtils.h
//  MusicPlayer
//
//  Created by Denis Baluev on 06/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKUtils : NSObject

+ (void) downloadImageFromURL: (NSURL*) url
               withCompletion: (void(^)(UIImage* image, NSError* errorOrNil)) completion;

@end
