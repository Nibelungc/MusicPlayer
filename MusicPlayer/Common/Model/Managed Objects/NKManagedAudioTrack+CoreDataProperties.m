//
//  NKManagedAudioTrack+CoreDataProperties.m
//  MusicPlayer
//
//  Created by Nikolay Kagala on 08/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NKManagedAudioTrack+CoreDataProperties.h"

@implementation NKManagedAudioTrack (CoreDataProperties)

@dynamic identifier;
@dynamic artist;
@dynamic title;
@dynamic duration;
@dynamic url;
@dynamic favorite;

@end
