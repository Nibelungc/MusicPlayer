//
//  NSArray+HOM.m
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NSArray+HOM.h"

@implementation NSArray (HOM)

- (NSArray*) map: (id(^)(id obj)) block {
    NSMutableArray* mappedArray = [[NSMutableArray alloc] initWithCapacity: self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id newObject = block(obj);
        [mappedArray addObject: newObject];
    }];
    return mappedArray;
}

- (NSArray*) filter: (BOOL(^)(id obj)) block {
    NSMutableArray* filteredArray = [[NSMutableArray alloc] initWithCapacity: self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)){
            [filteredArray addObject: obj];
        }
    }];
    return filteredArray;
}

@end
