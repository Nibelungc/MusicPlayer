//
//  NKDownloadsManager.h
//  MusicPlayer
//
//  Created by Nikolay Kagala on 08/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NKDownloadCompletion)(NSString* filePath, NSError* error);
typedef void(^NKRemovingCompletion)(NSError* error);

@class NKAudioTrack;

@protocol NKProgress <NSObject>

- (void) setProgress: (CGFloat) progress animated:(BOOL)animated;

@end

@interface NKDownloadsManager : NSObject

- (void) downloadTrack: (NKAudioTrack*) track
              progress: (id<NKProgress>) progress
            completion: (NKDownloadCompletion) completion;

- (void) removeTrack: (NKAudioTrack*) track completion: (NKRemovingCompletion) completion;

@end

@interface NSURLSessionTask (NKProgress)

@property (weak, nonatomic) id <NKProgress> progress;

@property (copy, nonatomic) NKDownloadCompletion downloadCompletion;

@end
