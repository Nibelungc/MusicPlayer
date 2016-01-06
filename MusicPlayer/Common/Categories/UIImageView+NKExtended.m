//
//  UIImageView+NKExtended.m
//  MusicPlayer
//
//  Created by Denis Baluev on 06/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UIImageView+NKExtended.h"

@implementation UIImageView (NKExtended)

- (void) setImage:(UIImage *)image animated: (BOOL) animated{
    if (animated) {
        [UIView transitionWithView: self
                          duration: 0.3f
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations: ^{
                            self.image = image;
                        } completion: NULL];
    } else {
        [self setImage: image];
    }
    
}


@end
