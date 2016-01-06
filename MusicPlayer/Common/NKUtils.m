//
//  NKUtils.m
//  MusicPlayer
//
//  Created by Denis Baluev on 06/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKUtils.h"

@implementation NKUtils

+ (void) downloadImageFromURL: (NSURL*) url
               withCompletion: (void(^)(UIImage* image, NSError* errorOrNil)) completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError* error = nil;
        NSData* imageData = [NSData dataWithContentsOfURL: url
                                                  options: NSDataReadingMappedIfSafe
                                                    error: &error];
        
        UIImage* resultImage = [UIImage imageWithData: imageData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(resultImage, error);
            }
        });
    });
}

@end
