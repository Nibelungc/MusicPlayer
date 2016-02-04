//
//  NKPlayerView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 16/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKAudioPlayer.h"

@protocol NKPlayerViewDelegate;
@class NKAudioPlayer;

@interface NKPlayerView : UIView <NKAudioPlayerPlaybackDelegate>

@property (weak, nonatomic) NKAudioPlayer* player;

@property (weak, nonatomic, nullable) UILabel* progressLabel;

@property (weak, nonatomic, nullable) UILabel* durationLabel;

@property (weak, nonatomic, nullable) UIButton* playButton;

@property (weak, nonatomic, nullable) UIButton* nextButton;

@property (weak, nonatomic, nullable) UIButton* prevButton;

@property (weak, nonatomic, nullable) UISlider* progressBar;

@property (weak, nonatomic, nullable) UILabel* trackTitleLabel;

@property (weak, nonatomic, nullable) UIButton* favoriteButton;

@property (weak, nonatomic, nullable) id <NKPlayerViewDelegate> delegate;

- (nonnull instancetype) initWithHeight: (CGFloat) height andPlayer: (nullable NKAudioPlayer*) player;

- (void) showAnimated: (BOOL) animated;

- (void) hideAnimated: (BOOL) animated;

- (void) setFavorite: (BOOL) favorite;

@end


@protocol NKPlayerViewDelegate <NSObject>

@optional

- (void) playerViewDidShow: (nonnull NKPlayerView*) playerView animated: (BOOL) animated;

- (void) playerViewDidHide: (nonnull NKPlayerView*) playerView animated: (BOOL) animated;

@end