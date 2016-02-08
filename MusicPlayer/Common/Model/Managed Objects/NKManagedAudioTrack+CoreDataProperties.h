//
//  NKManagedAudioTrack+CoreDataProperties.h
//  MusicPlayer
//
//  Created by Nikolay Kagala on 08/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NKManagedAudioTrack.h"

NS_ASSUME_NONNULL_BEGIN

@interface NKManagedAudioTrack (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *artist;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSNumber *favorite;

@end

NS_ASSUME_NONNULL_END
