//
//  VideoPlayerCaptionLabel.m
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import "VideoPlayerCaptionLabel.h"


@implementation VideoPlayerCaptionLabel


#warning Example Code
- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return CGSizeZero;
    }
    
    return CGSizeMake(size.width + 20.0f, size.height + 20.0f);
}
#warning Example Code End


@end
