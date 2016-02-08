//
//  NKDownloadsManager.m
//  MusicPlayer
//
//  Created by Nikolay Kagala on 08/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKDownloadsManager.h"
#import "NKAudioTrack.h"
#import <objc/runtime.h>

@interface NKDownloadsManager () <NSURLSessionDelegate>

@property (strong, nonatomic) NSURLSession* session;

@end

@implementation NKDownloadsManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration: configuration
                                                 delegate: self
                                            delegateQueue: [NSOperationQueue mainQueue]];
    }
    return self;
}

- (void) downloadTrack: (NKAudioTrack*) track
              progress: (id<NKProgress>) progress
            completion: (NKDownloadCompletion) completion {
    
    NSURLRequest* request = [NSURLRequest requestWithURL: track.url];
    NSURLSessionDownloadTask* downloadTask = [self.session downloadTaskWithRequest: request];
    downloadTask.progress = progress;
    downloadTask.downloadCompletion = completion;
    [downloadTask resume];
}

- (void) removeTrack: (NKAudioTrack*) track completion: (NKRemovingCompletion) completion {

}


#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    if (error){
        NSLog(@"%@ failed with error: %@", task, error);
        if (task.downloadCompletion){
            task.downloadCompletion(nil, error);
        }
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%@ finish loading at location: %@", downloadTask, location);
    if (downloadTask.downloadCompletion){
        downloadTask.downloadCompletion(location.path, nil);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat progress = bytesWritten/totalBytesExpectedToWrite;
    NSLog(@"Progress %.2f", progress);
    if (downloadTask.progress){
        NSLog(@"Set progress %.2f", progress);
        [downloadTask.progress setProgress: progress animated: YES];
    }
}

@end

static char progress_hash_key;
static char dowload_completion_hash_key;

@implementation NSURLSessionTask (NKProgress)

- (id<NKProgress>)progress {
    return objc_getAssociatedObject(self, &progress_hash_key);
}

- (void) setProgress:(id<NKProgress>)progress {
    objc_setAssociatedObject(self, &progress_hash_key, progress, OBJC_ASSOCIATION_ASSIGN);
}

- (NKDownloadCompletion)downloadCompletion {
    return objc_getAssociatedObject(self, &dowload_completion_hash_key);
}

- (void)setDownloadCompletion:(NKDownloadCompletion)downloadCompletion {
    objc_setAssociatedObject(self, &dowload_completion_hash_key, downloadCompletion, OBJC_ASSOCIATION_COPY);
}

@end
