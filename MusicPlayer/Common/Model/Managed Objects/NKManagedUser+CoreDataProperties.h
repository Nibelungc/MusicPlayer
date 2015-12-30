//
//  NKManagedUser+CoreDataProperties.h
//  MusicPlayer
//
//  Created by Denis Baluev on 30/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NKManagedUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface NKManagedUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *token;

@end

NS_ASSUME_NONNULL_END
