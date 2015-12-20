//
//  NKNotificationService.m
//  MusicPlayer
//
//  Created by Denis Baluev on 20/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKNotificationService.h"

#import <TSMessages/TSMessage.h>

@implementation NKNotificationService

- (void) showErrorMessage: (NSString*) message withTitle: (NSString*) title{
    [TSMessage showNotificationWithTitle: title subtitle: message type: TSMessageNotificationTypeError];
}

- (void) showMessage: (NSString*) message withTitle: (NSString*) title{
    [TSMessage showNotificationWithTitle: title subtitle: message type: TSMessageNotificationTypeMessage];
}

@end
