//
//  NKPlayerView.m
//  MusicPlayer
//
//  Created by Denis Baluev on 16/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKPlayerView.h"
#import "NKAudioPlayer.h"

CGFloat const kHideAnimationDuration = 0.3;
CGFloat const kSpaceBetweenButtonsX = 25.0;
NSString* const kTimeLabelPlaceholder = @"--:--:--";

@interface NKPlayerView () <NKAudioPlayerPlaybackDelegate>

@property (assign, nonatomic) CGFloat playerHeight;

@property (weak, nonatomic) NSLayoutConstraint* bottomConstraint;

@property (weak, nonatomic) NKAudioPlayer* player;

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

#pragma mark - Configure view

- (void) createPlayerControlsSubviews {
    CGSize buttonSize = CGSizeMake(44.0, 44.0);
    CGFloat labelWidth = 44.0;
    
    /** Progress label */
    UILabel* progressLabel = [[UILabel alloc] init];
    progressLabel.adjustsFontSizeToFitWidth = YES;
    progressLabel.text = kTimeLabelPlaceholder;
    progressLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: progressLabel];
    
    self.progressLabel = progressLabel;
    [self addProgressLabelConstraintsWithWidth: labelWidth];
    
    /** Duration label */
    UILabel* durationLabel = [[UILabel alloc] init];
    durationLabel.adjustsFontSizeToFitWidth = YES;
    durationLabel.text = kTimeLabelPlaceholder;
    progressLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: durationLabel];
    
    self.durationLabel = durationLabel;
    [self addDurationLabelConstraintsWithWidth: labelWidth];
    
    /** Progress slider */
    UIProgressView* progressView = [[UIProgressView alloc] init];
    [self addSubview: progressView];
    
    self.progressBar = progressView;
    [self addProgressBarConstraints];
    
    /** Play button */
    UIButton* playButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize playButtonSize = buttonSize;
    UIImage* playImage = [UIImage imageNamed:@"play"];
    UIImage* pauseImage = [UIImage imageNamed:@"pause"];
    [playButton setImage: playImage forState: UIControlStateNormal];
    [playButton setImage: pauseImage forState: UIControlStateSelected];
    [self addSubview: playButton];
    
    self.playButton = playButton;
    [self addPlayButtonConstraintsWithSize: playButtonSize];
    
    /** Next button */
    UIButton* nextButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize nextButtonSize = buttonSize;
    UIImage* nextImage = [UIImage imageNamed:@"next"];
    [nextButton setImage: nextImage forState: UIControlStateNormal];
    [self addSubview: nextButton];
    
    self.nextButton = nextButton;
    [self addNextButtonConstraintsWithSize: nextButtonSize];
    
    /** Previous button */
    UIButton* previousButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize previousButtonSize = buttonSize;
    UIImage* previousImage = [UIImage imageNamed:@"previous"];
    [previousButton setImage: previousImage forState: UIControlStateNormal];
    [self addSubview: previousButton];
    
    self.prevButton = previousButton;
    [self addPreviousButtonConstraintsWithSize: previousButtonSize];
    
    
}

- (NSString*) stringFromTimeInterval: (NSTimeInterval) time {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
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
    self.progressBar.progress = progress;
    self.progressLabel.text = [self stringFromTimeInterval: time];
    self.durationLabel.text = [NSString stringWithFormat:@"-%@", [self stringFromTimeInterval: duration-time]];
}

#pragma mark - Autolayout

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
     [NSLayoutConstraint constraintWithItem: self.progressBar
                                  attribute: NSLayoutAttributeBottom
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.playButton
                                  attribute: NSLayoutAttributeTop
                                 multiplier: 1.0
                                   constant: -playButtonTopPadding]];
}

- (void) addProgressBarConstraints {
    CGFloat topPadding = kDefaultPadding;
    self.progressBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* hFormat = @"H:[_progressLabel]-[_progressBar]-[_durationLabel]";
    NSString* vFormat = @"V:[_progressBar(==topPadding)]";
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: hFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: nil
                                               views: NSDictionaryOfVariableBindings(_progressBar, _progressLabel, _durationLabel)]];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: vFormat
                                             options: NSLayoutFormatDirectionLeadingToTrailing
                                             metrics: @{@"topPadding": @(topPadding)}
                                               views: NSDictionaryOfVariableBindings(_progressBar)]];

    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem: self.progressLabel
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: self.progressBar
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1.0
                                   constant: -2.0]];
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
