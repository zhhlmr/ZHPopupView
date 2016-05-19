//
// Created by heyz3a on 16/4/25.
// Copyright (c) 2016 heyz3a. All rights reserved.
//

#import "UIView+DropShadow.h"


@implementation UIView (DropShadow)
- (void)dropShadowWithShadowColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {

    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);

    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;

    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
}


@end