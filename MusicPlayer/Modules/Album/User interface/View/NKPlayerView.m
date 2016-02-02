//
//  NKPlayerView.m
//  MusicPlayer
//
//  Created by Denis Baluev on 16/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKPlayerView.h"
#import "NKAudioPlayer.h"

#import <MediaPlayer/MPVolumeView.h>
#import <MarqueeLabel/MarqueeLabel.h>

CGFloat const kHideAnimationDuration = 0.3;
CGFloat const kSpaceBetweenButtonsX = 25.0;
NSString* const kTimeLabelPlaceholder = @"--:--:--";
UIImageRenderingMode const imagesRenderingMode = UIImageRenderingModeAlwaysTemplate;

@interface NKPlayerView ()

@property (assign, nonatomic) CGFloat playerHeight;

@property (weak, nonatomic) NSLayoutConstraint* bottomConstraint;

@property (weak, nonatomic) MPVolumeView* volumeView;

@property (assign, nonatomic) BOOL progressBarDragged;

@end

@implementation NKPlayerView

#pragma mark - Initialization

- (instancetype) initWithHeight: (CGFloat) height andPlayer: (NKAudioPlayer*) player {
    if (self = [super init]){
        _playerHeight = height;
        _player = player;
        _player.playbackDelegate = self;
        [self createPlayerControlsSubviews];
    }
    return self;
}

- (void) showAnimated: (BOOL) animated {
    [self changeBottomConstraintConstantValue: 0.0 animated: animated];
    
    if ([self.delegate respondsToSelector: @selector(playerViewDidShow:animated:)]) {
        [self.delegate playerViewDidShow: self animated: animated];
    }
}

- (void) hideAnimated: (BOOL) animated {
    [self changeBottomConstraintConstantValue: -self.playerHeight animated: animated];
    
    if ([self.delegate respondsToSelector: @selector(playerViewDidHide:animated:)]) {
        [self.delegate playerViewDidHide: self animated: animated];
    }
}

- (void)didMoveToSuperview {
    [self addSelfConstraints];
}

- (void) changeBottomConstraintConstantValue: (CGFloat) value animated: (BOOL) animated {
    self.bottomConstraint.constant = value;
    if (animated){
        [UIView animateWithDuration: kHideAnimationDuration
                         animations:^{
                             [self layoutIfNeeded];
                         }];
    } else {
        [self layoutIfNeeded];
    }
}

#pragma mark - Actions

- (void) progressBarTouchDown: (UISlider*) sender{
    self.progressBarDragged = YES;
}

- (void) progressBarReleased: (UISlider*) sender {
    [self.player seekToPosition: sender.value];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressBarDragged = NO;
    });
}

- (void) sliderTapped: (UITapGestureRecognizer*) gestureRecognizer {
    UISlider* slider = (UISlider*) gestureRecognizer.view;
    self.progressBarDragged = YES;
    CGPoint point = [gestureRecognizer locationInView: slider];
    CGFloat percentage = point.x / slider.bounds.size.width;
    CGFloat delta = percentage * (slider.maximumValue - slider.minimumValue);
    CGFloat value = slider.minimumValue + delta;
    [slider setValue:value animated:YES];
    [self progressBarReleased: slider];
}

#pragma mark - Configure view

- (void) createPlayerControlsSubviews {
    CGSize buttonSize = CGSizeMake(44.0, 44.0);
    CGFloat labelWidth = 44.0;
    UIFont* timeLabelFont = [UIFont systemFontOfSize: 13.0];
    self.tintColor = [UIColor whiteColor];
    
    /** Progress label */
    UILabel* progressLabel = [[UILabel alloc] init];
    progressLabel.textColor = [UIColor playerTextColor];
    progressLabel.font = timeLabelFont;
    progressLabel.text = kTimeLabelPlaceholder;
    progressLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: progressLabel];
    
    self.progressLabel = progressLabel;
    [self addProgressLabelConstraintsWithWidth: labelWidth];
    
    /** Duration label */
    UILabel* durationLabel = [[UILabel alloc] init];
    durationLabel.textColor = [UIColor playerTextColor];
    durationLabel.font = timeLabelFont;
    durationLabel.text = kTimeLabelPlaceholder;
    progressLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: durationLabel];

    self.durationLabel = durationLabel;
    [self addDurationLabelConstraintsWithWidth: labelWidth];
    
    /** Progress slider */
    UISlider* progressView = [[UISlider alloc] init];
    [progressView addTarget: self action: @selector(progressBarTouchDown:) forControlEvents: UIControlEventTouchDown];
    [progressView addTarget: self action: @selector(progressBarReleased:) forControlEvents: UIControlEventTouchUpInside];
    [progressView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(sliderTapped:)]];
    [self addSubview: progressView];
    
    self.progressBar = progressView;
    [self addProgressBarConstraints];
    
    /** Track title label */
    MarqueeLabel* titleLabel = [[MarqueeLabel alloc] initWithFrame: CGRectZero];
    titleLabel.textColor = [UIColor playerTextColor];
    titleLabel.fadeLength = kDefaultPadding * 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: titleLabel];
    
    self.trackTitleLabel = titleLabel;
    [self trackTitleLabelAddContstraints];
    
    /** Play button */
    UIButton* playButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize playButtonSize = buttonSize;
    UIImage* playImage = [[UIImage imageNamed:@"play"] imageWithRenderingMode: imagesRenderingMode];
    UIImage* pauseImage = [[UIImage imageNamed:@"pause"] imageWithRenderingMode: imagesRenderingMode];
    [playButton setImage: playImage forState: UIControlStateNormal];
    [playButton setImage: pauseImage forState: UIControlStateSelected];
    [self addSubview: playButton];
    
    self.playButton = playButton;
    [self addPlayButtonConstraintsWithSize: playButtonSize];
    
    /** Next button */
    UIButton* nextButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize nextButtonSize = buttonSize;
    UIImage* nextImage = [[UIImage imageNamed:@"next"]imageWithRenderingMode: imagesRenderingMode];
    [nextButton setImage: nextImage forState: UIControlStateNormal];
    [self addSubview: nextButton];
    
    self.nextButton = nextButton;
    [self addNextButtonConstraintsWithSize: nextButtonSize];
    
    /** Previous button */
    UIButton* previousButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize previousButtonSize = buttonSize;
    UIImage* previousImage = [[UIImage imageNamed:@"previous"]imageWithRenderingMode: imagesRenderingMode];
    [previousButton setImage: previousImage forState: UIControlStateNormal];
    [self addSubview: previousButton];
    
    self.prevButton = previousButton;
    [self addPreviousButtonConstraintsWithSize: previousButtonSize];
    
    /** Favorite button */
    UIButton* favoriteButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize favoriteButtonSize = CGSizeMake(buttonSize.width/2.0, buttonSize.height/2.0);
    UIImage* favoriteImage = [[UIImage imageNamed:@"favorite@3x"] imageWithRenderingMode: imagesRenderingMode];
    UIImage* notFavoriteImage = [[UIImage imageNamed:@"not_favorite@3x"] imageWithRenderingMode: imagesRenderingMode];
    [favoriteButton setImage: favoriteImage forState: UIControlStateSelected];
    [favoriteButton setImage: notFavoriteImage forState: UIControlStateNormal];
    [self addSubview: favoriteButton];
    
    self.favoriteButton = favoriteButton;
    [self addFavoriteButtonConstraintsWithSize: favoriteButtonSize];
    
    /** Volume view */
    UIImage* volumeThumbImage = [[UIImage imageNamed:@"github_1"]imageWithRenderingMode: imagesRenderingMode];
    MPVolumeView* volumeView = [[MPVolumeView alloc] init];
    [volumeView setVolumeThumbImage: volumeThumbImage forState: UIControlStateNormal];
    [self addSubview: volumeView];
    
    self.volumeView = volumeView;
    [self addVolumeViewConstraints];
}

- (NSString*) stringFromTimeInterval: (NSTimeInterval) time {
    NSInteger maxTime = 24 * 60 * 60;
    if (time >= maxTime){
        return @"> 24 ч.";
    }
    NSString* format = time > 60 * 60 ? @"HH:mm:ss" : @"mm:ss";
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: format];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSDate* date = [NSDate dateWithTimeIntervalSinceReferenceDate: time];
    
    return [formatter stringFromDate: date];
}

#pragma mark - NKAudioPlayerPlaybackDelegate

- (void) audioDidPausePlaying {
    [self.playButton setSelected: NO];
}

- (void) audioDidStartPlaying {
    [self.playButton setSelected: YES];
}

- (void) audioProgressDidChangeTo: (NSTimeInterval) time withDuration: (NSTimeInterval) duration {
    CGFloat progress = time/duration;
    
    self.progressLabel.text = [NSString stringWithFormat:@" %@", [self stringFromTimeInterval: time]];
    self.durationLabel.text = [NSString stringWithFormat:@"-%@", [self stringFromTimeInterval: duration-time]];
    
    if (!self.progressBarDragged){
        self.progressBar.value = progress;
    }
}

#pragma mark - Autolayout

- (void) addFavoriteButtonConstraintsWithSize: (CGSize) size {
    self.favoriteButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSizeContstraints: size forSubview: self.favoriteButton];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.prevButton
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.favoriteButton
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: 0.0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.prevButton
                                  attribute: NSLayoutAttributeLeft
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.favoriteButton
                                  attribute: NSLayoutAttributeRight
                                 multiplier: 1.0
                                   constant: kSpaceBetweenButtonsX]];
}

- (void) trackTitleLabelAddContstraints {
    self.trackTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* hFormat = @"H:|-[_trackTitleLabel]-|";
    NSString* vFormat = @"V:[_progressBar]-[_trackTitleLabel]";
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_trackTitleLabel)]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_progressBar, _trackTitleLabel)]];
}

- (void) addVolumeViewConstraints {
    UIImage* volumeDown = [[UIImage imageNamed:@"volume_down@3x"]imageWithRenderingMode: imagesRenderingMode];
    UIImage* volumeUp = [[UIImage imageNamed:@"volume_up@3x"]imageWithRenderingMode: imagesRenderingMode];
    CGSize volumeImageSize = CGSizeMake(15.0, 15.0);
    
    UIImageView* volumeDownImageView = [[UIImageView alloc]initWithImage: volumeDown];
    UIImageView* volumeUpImageView = [[UIImageView alloc] initWithImage: volumeUp];
    volumeDownImageView.contentMode = UIViewContentModeScaleAspectFit;
    volumeUpImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview: volumeDownImageView];
    [self addSubview: volumeUpImageView];
    
    
    self.volumeView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* vFormat = @"V:[_volumeView(==20)]-|";
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_volumeView)]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.progressBar
                                  attribute: NSLayoutAttributeWidth
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.volumeView
                                  attribute: NSLayoutAttributeWidth
                                 multiplier: 1.0
                                   constant: 0.0]];
    
    [self addCenterConstraintsForView: self.volumeView withAttribute: NSLayoutAttributeCenterX];
    
    /**  Volume Down Image View Constraints*/
    volumeDownImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSizeContstraints: volumeImageSize forSubview: volumeDownImageView];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: volumeDownImageView
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.volumeView
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: 0.0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.volumeView
                                  attribute: NSLayoutAttributeLeading
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: volumeDownImageView
                                  attribute: NSLayoutAttributeTrailing
                                 multiplier: 1.0
                                   constant: kDefaultPadding]];
    
    /**  Volume Up Image View Constraints*/
    volumeUpImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSizeContstraints: volumeImageSize forSubview: volumeUpImageView];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: volumeUpImageView
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.volumeView
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: 0.0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: volumeUpImageView
                                  attribute: NSLayoutAttributeLeading
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.volumeView
                                  attribute: NSLayoutAttributeTrailing
                                 multiplier: 1.0
                                   constant: kDefaultPadding]];
    
}

- (void) addProgressLabelConstraintsWithWidth: (CGFloat) labelWidth{
    self.progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* hFormat = @"H:|-[_progressLabel(==labelWidth)]";
    NSString* vFormat = @"V:|-[_progressLabel]";
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: @{@"labelWidth": @(labelWidth)}
                                               views: NSDictionaryOfVariableBindings(_progressLabel)]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_progressLabel)]];
}

- (void) addDurationLabelConstraintsWithWidth: (CGFloat) labelWidth {
    self.durationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* hFormat = @"H:[_durationLabel(==labelWidth)]-|";
    NSString* vFormat = @"V:|-[_durationLabel]";
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: @{@"labelWidth": @(labelWidth)}
                                               views: NSDictionaryOfVariableBindings(_durationLabel)]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_durationLabel)]];
}

- (void) addPlayButtonConstraintsWithSize: (CGSize) playButtonSize{
    CGFloat playButtonTopPadding = kDefaultPadding;
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSizeContstraints: playButtonSize forSubview: self.playButton];
    [self addCenterConstraintsForView: self.playButton withAttribute: NSLayoutAttributeCenterX];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.playButton
                                  attribute: NSLayoutAttributeTop
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.trackTitleLabel
                                  attribute: NSLayoutAttributeBottom
                                 multiplier: 1.0
                                   constant: playButtonTopPadding]];
}

- (void) addProgressBarConstraints {
    CGFloat height = kDefaultPadding;
    self.progressBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* hFormat = @"H:[_progressLabel]-[_progressBar]-[_durationLabel]";
    NSString* vFormat = @"V:[_progressBar(==height)]";
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_progressBar, _progressLabel, _durationLabel)]];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: @{@"height": @(height)}
                                               views: NSDictionaryOfVariableBindings(_progressBar)]];

    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.progressLabel
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.progressBar
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: 0.0]];
}

- (void) addNextButtonConstraintsWithSize: (CGSize) nextButtonSize {
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSizeContstraints: nextButtonSize forSubview: self.nextButton];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.nextButton
                                  attribute: NSLayoutAttributeLeading
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.playButton
                                  attribute: NSLayoutAttributeTrailing
                                 multiplier: 1.0
                                   constant: kSpaceBetweenButtonsX]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.playButton
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.nextButton
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: 0.0]];
}

- (void) addPreviousButtonConstraintsWithSize: (CGSize) previousButtonSize {
    self.prevButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSizeContstraints: previousButtonSize forSubview: self.prevButton];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.playButton
                                  attribute: NSLayoutAttributeLeading
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.prevButton
                                  attribute: NSLayoutAttributeTrailing
                                 multiplier: 1.0
                                   constant: kSpaceBetweenButtonsX]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.playButton
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.prevButton
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: 0.0]];
}

- (void) addSelfConstraints {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSString* hFormat = @"H:|-0-[playerView]-0-|";
    NSString* vFormat = [NSString stringWithFormat:@"V:[playerView(==%0.f)]", self.playerHeight];
    UIView* playerView = self;
    
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(playerView)]];
    
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(playerView)]];
    
    vFormat = [NSString stringWithFormat: @"V:[playerView]-(%0.f)-|", -self.playerHeight];
    NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                                                   options: NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics: nil
                                                                     views: NSDictionaryOfVariableBindings(playerView)];
    [self.superview addConstraints: constraints];
    
    self.bottomConstraint = constraints.firstObject;
}

- (void) addSizeContstraints: (CGSize) size forSubview: (UIView*) view {
    NSDictionary* views = NSDictionaryOfVariableBindings(view);
    
    NSString* hFormat = [NSString stringWithFormat:@"H:[view(==%0.f)]", size.width];
    NSString* vFormat = [NSString stringWithFormat:@"V:[view(==%0.f)]", size.height];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: views]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: views]];
}

- (void) addCenterConstraintsForView: (UIView*) view {
    [self addCenterConstraintsForView: view withAttribute: NSLayoutAttributeCenterY];
    [self addCenterConstraintsForView: view withAttribute: NSLayoutAttributeCenterX];
}

- (void) addCenterConstraintsForView: (UIView*) view withAttribute: (NSLayoutAttribute) attribute {
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self
                                  attribute: attribute
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: view
                                  attribute: attribute
                                 multiplier: 1.0
                                   constant: 0.0]];
}



@end
