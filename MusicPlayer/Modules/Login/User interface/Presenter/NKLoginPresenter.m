//
//  NKLoginPresenter.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKLoginPresenter.h"
#import "NKLoginView.h"
#import "NKCategories.h"

@implementation NKLoginPresenter

@dynamic output;

#pragma mark - NKLoginModule

- (void) loadView {
    [self.interactor getListOfServices];
}

- (void) loginActionWithServiceTitle: (NSString*) serviceTitle {
    NSLog(@"Login with service: %@", serviceTitle);
}

#pragma mark - NKLoginInteractorOutput

- (void) setListOfServices: (NSArray*) listOfServices {
    NSArray* titles = [listOfServices map:^id(id obj) {
        return [obj title];
    }];
    [self.output setServicesTitles: titles];
}

@end
