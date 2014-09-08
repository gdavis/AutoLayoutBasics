//
//  VideoPlayerCaptionViewController.m
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import "VideoPlayerCaptionController.h"

@implementation VideoPlayerCaptionController


- (NSString *)captionTextForProgress:(CGFloat)progress
{
    __block NSString *captionText;
    
    [[self captions] enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
        
        NSNumber *start = dictionary[@"start"];
        NSNumber *end = dictionary[@"end"];
        
        if (progress >= [start floatValue] && progress <= [end floatValue]) {
            captionText = dictionary[@"text"];
            *stop = YES;
        }
    }];
    
    return captionText;
}


- (NSArray *)captions
{
    static NSArray *captions;
    if (captions == nil) {
        captions = @[
                     @{
                         @"start": @(0.1),
                         @"end": @(0.5),
                         @"text": @"[Exciting music]"
                         },
                     @{
                         @"start": @(0.7),
                         @"end": @(0.9),
                         @"text": @"Caption two with a really long line of text that will wrap to multiple lines. Its so very long. I can't believe these birds are still diving."
                         },
                     ];
    }
    return captions;
}

@end
