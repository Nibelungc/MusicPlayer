//
//  NKPlayerView.m
//  MusicPlayer
//
//  Created by Denis Baluev on 16/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKPlayerView.h"

CGFloat const kHideAnimationDuration = 0.3;

@interface NKPlayerView ()

@property (assign, nonatomic) CGFloat playerHeight;

@property (weak, nonatomic) NSLayoutConstraint* bottomConstraint;

@end

@implementation NKPlayerView

- (instancetype) initWithHeight: (CGFloat) height {
    if (self = [super init]){
        _playerHeight = height;
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

#pragma mark - Configure view

- (void) createPlayerControlsSubviews {
    CGSize buttonSize = CGSizeMake(44.0, 44.0);
    
    UIButton* playButton = [UIButton buttonWithType: UIButtonTypeCustom];
    CGSize playButtonSize = buttonSize;
    [playButton setTitle: @"Play" forState: UIControlStateNormal];
    [self addSubview: playButton];
    playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSizeContstraints: playButtonSize forSubview: playButton];
    [self addCenterConstraintsForView: playButton];
    
    self.playButton = playButton;
}

#pragma mark - Autolayout

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

@end
