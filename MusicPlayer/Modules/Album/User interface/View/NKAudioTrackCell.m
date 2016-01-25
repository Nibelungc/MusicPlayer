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
    UIFont* titleFont = [UIFont boldSystemFontOfSize: [UIFont systemFontSize]];
    UIFont* artistFont = [UIFont italicSystemFontOfSize: [UIFont systemFontSize]];
    
    self.textLabel.text = track.title;
    self.textLabel.font = titleFont;
    
    self.detailTextLabel.text = track.artist;
    self.detailTextLabel.font = artistFont;
    self.detailTextLabel.textColor = [UIColor grayColor];
}

@end
