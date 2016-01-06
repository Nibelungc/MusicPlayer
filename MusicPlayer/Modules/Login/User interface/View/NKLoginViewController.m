//
//  NKLoginViewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 17/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#import "NKLoginViewController.h"

#import "NKConstants.h"
#import "NKCategories.h"

@interface NKLoginViewController ()

@property (strong, nonatomic) NSArray* servicesButtons;

@property (weak, nonatomic) UIView* buttonsContainer;

@end

@implementation NKLoginViewController

@dynamic eventHandler;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview: [self createMotionView] atIndex: 0];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden: YES withAnimation: UIStatusBarAnimationSlide];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden: NO withAnimation: UIStatusBarAnimationSlide];
}

#pragma mark - Configuration

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void) createButtonsWithTitles: (NSArray <NSString *> *) titles withAction: (SEL) action {
    [self.buttonsContainer removeFromSuperview];
    
    CGFloat sidePaddnig = kDefaultPadding;
    CGFloat bottomPadding = kDefaultPadding;
    CGFloat buttonHeight = 50.0;
    CGFloat containerHeight = titles.count * (buttonHeight + bottomPadding);
    CGRect containerFrame = CGRectInset(self.view.bounds, sidePaddnig, (CGRectGetHeight(self.view.bounds) - containerHeight)/2);
    UIView* container = [[UIView alloc] initWithFrame: containerFrame];
    [self.view addSubview: container];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(0, idx * (buttonHeight + bottomPadding), CGRectGetWidth(containerFrame), buttonHeight);
        UIButton* button = [self buttonWithTitle: title andFrame: frame];
        [button addTarget: self action: action forControlEvents: UIControlEventTouchUpInside];
        [container addSubview: button];
    }];
    
    self.buttonsContainer = container;
}

- (UIView*) createMotionView {
    CGFloat shift = 20.0;
    UIView* motionView = [[UIView alloc] initWithFrame: CGRectInset(self.view.bounds, -shift, -shift)];
    motionView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"music_background.jpg"]];
    
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    verticalMotionEffect.minimumRelativeValue = @(-shift);
    verticalMotionEffect.maximumRelativeValue = @(shift);
    
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-shift);
    horizontalMotionEffect.maximumRelativeValue = @(shift);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    [motionView addMotionEffect: group];
    return motionView;
}


- (UIButton*) buttonWithTitle: (NSString*) title andFrame: (CGRect) frame{
    UIButton* button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor appTintColor];
    button.layer.cornerRadius = 10.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor: [UIColor appBackgroundColor] forState: UIControlStateNormal];
    [button setTitle: title forState: UIControlStateNormal];
    
    return button;
}

#pragma mark - Actions

- (void) buttonTapped: (UIButton*) sender {
    [self.eventHandler loginActionWithServiceTitle: sender.titleLabel.text];
}

#pragma mark - NKLoginView

- (void) setServicesTitles: (NSArray <NSString *> *) titles {
    [self createButtonsWithTitles: titles withAction: @selector(buttonTapped:)];
}

@end
