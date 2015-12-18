//
//  NKLoginInteractorIO.h
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSArray;

@protocol NKLoginInteractorInput <NSObject>

- (void) getListOfServices;

@end

@protocol NKLoginInteractorOutput <NSObject>

- (void) setListOfServices: (NSArray*) listOfServices;

@end
