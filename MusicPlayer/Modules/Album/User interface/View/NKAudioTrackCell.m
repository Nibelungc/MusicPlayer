//
//  NKAudioTrackCell.m
//  MusicPlayer
//
//  Created by Denis Baluev on 08/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAudioTrackCell.h"
#import "NKAudioTrack.h"

@implementation NKAudioTrackCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) createCell {
    return [[NKAudioTrackCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                   reuseIdentifier: [self reuseIdentifier]];
}

+ (NSString*) reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void) configureCellWithTrack: (NKAudioTrack*) track {
    self.textLabel.text = track.title;
    self.detailTextLabel.text = track.artist;
}

@end
