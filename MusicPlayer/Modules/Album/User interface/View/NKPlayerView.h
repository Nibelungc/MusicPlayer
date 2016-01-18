//
//  NKPlayerView.h
//  MusicPlayer
//
//  Created by Denis Baluev on 16/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NKPlayerViewDelegate;
@class NKAudioPlayer;

@interface NKPlayerView : UIView

@property (weak, nonatomic, nullable) UILabel* progressLabel;

@property (weak, nonatomic, nullable) UILabel* durationLabel;

@property (weak, nonatomic, nullable) UIButton* playButton;

@property (weak, nonatomic, nullable) UIButton* nextButton;

@property (weak, nonatomic, nullable) UIButton* prevButton;

@property (weak, nonatomic, nullable) UIProgressView* progressBar;

@property (weak, nonatomic, nullable) id <NKPlayerViewDelegate> delegate;

- (nonnull instancetype) initWithHeight: (CGFloat) height andPlayer: (nullable NKAudioPlayer*) player;

- (void) showAnimated: (BOOL) animated;

- (void) hideAnimated: (BOOL) animated;

@end


@protocol NKPlayerViewDelegate <NSObject>

@optional

- (void) playerViewDidShow: (nonnull NKPlayerView*) playerView animated: (BOOL) animated;

- (void) playerViewDidHide: (nonnull NKPlayerView*) playerView animated: (BOOL) animated;

@end