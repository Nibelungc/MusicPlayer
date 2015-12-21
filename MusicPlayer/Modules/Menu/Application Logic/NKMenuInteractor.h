//
//  NKMenuInteractor.h
//  MusicPlayer
//
//  Created by Denis Baluev on 21/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKMenuInteractorIO.h"

@interface NKMenuInteractor : NSObject <NKMenuInteractorInput>

@property (weak, nonatomic) id<NKMenuInteractorOutput> output;

@end
