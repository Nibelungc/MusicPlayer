//
//  NKLoginPresenter.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKLoginPresenter.h"
#import "NKLoginWireframe.h"
#import "NKLoginView.h"
#import "NKCategories.h"
#import "NKUser.h"

@interface NKLoginPresenter ()

@property (strong, nonatomic) NSArray* services;

@end

@implementation NKLoginPresenter

@dynamic output;

#pragma mark - NKLoginModule

- (void) loadView {
    [self.interactor getListOfServices];
}

- (void) loginActionWithServiceTitle: (NSString*) serviceTitle {
    NSPredicate* titlePredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", serviceTitle];
    NSArray* servicesWithTitle = [self.services filteredArrayUsingPredicate: titlePredicate];
    [self.interactor loginWithService: servicesWithTitle.firstObject];
}

- (void) tryToLoginWithLastSession {
    [self.interactor tryToWakeupLastSession];
}

#pragma mark - NKLoginInteractorOutput

- (void) setListOfServices: (NSArray*) listOfServices {
    self.services = listOfServices;
    NSArray* titles = [listOfServices map:^id(id obj) {
        return [obj title];
    }];
    [self.output setServicesTitles: titles];
}

- (void) loginSucceededWithUser: (NKUser*) user{
    NSString* message = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    [self.output showMessage: message withTitle: @"Успешная авторизация"];
    [self.loginWireframe presentMainController];
}

- (void) loginFailedWithError: (NSError*) error{
    [self.output showErrorMessage: error.localizedDescription withTitle: @"Ошибка авторизации"];
}

- (void) lastSessionWokenUp {
    [self.loginWireframe loginWithLastSessionEnded: YES];
}

- (void) lastSessionWasntFound {
    [self.loginWireframe loginWithLastSessionEnded: NO];
}

@end
