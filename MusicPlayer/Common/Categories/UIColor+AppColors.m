//
//  UIColor+AppColors.m
//  MusicPlayer
//
//  Created by Denis Baluev on 18/12/15.
//  Copyright © 2015 Sequenia. All rights reserved.
//

#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#import "UIColor+AppColors.h"

@implementation UIColor (AppColors)

+ (UIColor*) appTintColor {
    return [UIColor lightBlueColor];
}

+ (UIColor*) appBackgroundColor {
    return [UIColor darkBlueColor];
}

+ (UIColor*) navigationBarColor {
    return [UIColor lightBlueColor];
}

+ (UIColor*) playerTextColor {
    return [UIColor lightTextColor];
}

+ (UIColor*) darkBlueColor {
    return UIColorFromRGBA(57, 69, 85, 1);
}

+ (UIColor*) lightBlueColor {
    return UIColorFromRGBA(87, 133, 183, 1);
}

@end
