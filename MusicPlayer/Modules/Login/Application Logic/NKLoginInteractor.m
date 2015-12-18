//
//  NKLoginInteractor.m
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKLoginInteractor.h"
#import "NKThirdPartiesConfigurator.h"

@implementation NKLoginInteractor

- (void) getListOfServices {
    NSArray* services = [NKThirdPartiesConfigurator availableServices];
    [self.output setListOfServices: services];
}

@end
