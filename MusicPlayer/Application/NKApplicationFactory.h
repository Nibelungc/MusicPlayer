//
//  NKApplicationFactory.h
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKConfigurator.h"

@interface NKApplicationFactory : NSObject

- (id<NKConfigurator>) thirdPartiesConfigurator;

- (id<NKConfigurator>) applicationConfigurator;

@end
