//
//  NKCoreDataStorage.m
//  MusicPlayer
//
//  Created by Denis Baluev on 29/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKCoreDataStorage.h"
#import <MagicalRecord/MagicalRecord.h>

#import "NKManagedUser.h"
#import "NKUser.h"

@implementation NKCoreDataStorage

- (void) saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        if (!contextDidSave){
            NSLog(@"MR_saveToPersistentStoreWithCompletion: Context not saved.");
            if (error){
                NSLog(@"Error saving context: %@", error.localizedDescription);
            }
        }
    }];
}

#pragma mark - User

- (void) fetchSavedUser: (_Nonnull NKDataStorageSavedUserCompletion) completion {
    NSArray* results = [NKManagedUser MR_findAll];
    NKManagedUser* managedUser = (NKManagedUser*) results.firstObject;
    completion([self userFromManagedObject: managedUser]);
}

- (void) saveUserAndDeleteOldOne: ( NKUser* _Nonnull ) user {
    [NKManagedUser MR_truncateAll];
    [self createManagedUserFromUser: user];
    [self saveContext];
}

#pragma mark - Mapping

- (NKUser*) userFromManagedObject: (NKManagedUser*) managedUser {
    if (!managedUser) { return nil; }
    NKUser* user = [[NKUser alloc] init];
    user.firstName = managedUser.firstName;
    user.lastName = managedUser.lastName;
    user.token = managedUser.token;
    user.imageUrl = [NSURL URLWithString: managedUser.imageUrl];
    user.audioService = managedUser.audioService;
    return user;
}

- (NKManagedUser*) createManagedUserFromUser: (NKUser*) user {
    if (!user) { return nil; }
    NKManagedUser* managedUser = [NKManagedUser MR_createEntity];
    managedUser.firstName = user.firstName;
    managedUser.lastName = user.lastName;
    managedUser.token = user.token;
    managedUser.imageUrl = [user.imageUrl absoluteString];
    managedUser.audioService = user.audioService;
    return managedUser;
}

@end
