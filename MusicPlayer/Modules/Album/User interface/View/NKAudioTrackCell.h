//
//  NKAudioTrackCell.h
//  MusicPlayer
//
//  Created by Denis Baluev on 08/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKAudioTrack;

@interface NKAudioTrackCell : UITableViewCell

- (void) configureCellWithTrack: (NKAudioTrack*) track;

+ (instancetype) createCell;

+ (NSString*) reuseIdentifier;

@end
