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
                         @"start": @(0.01),
                         @"end": @(0.08),
                         @"text": @"[Building Suspense]"
                         },
                     @{
                         @"start": @(0.1),
                         @"end": @(0.15),
                         @"text": @"Splash!"
                         },
                     @{
                         @"start": @(0.175),
                         @"end": @(0.3),
                         @"text": @"Diving birds are birds which plunge into water to catch fish or other food. They may enter the water from flight, as does the brown pelican (Pelecanus occidentalis), or they may dive from the surface of the water."
                         },
                     @{
                         @"start": @(0.35),
                         @"end": @(0.4),
                         @"text": @"[Fish panic and flee]"
                         },
                     @{
                         @"start": @(0.5),
                         @"end": @(0.6),
                         @"text": @"Some diving birds - for example, the extinct Hesperornithes of the Cretaceous Period - propelled themselves with their feet. They were large, streamlined, flightless birds with teeth for grasping slippery prey."
                         },
                     ];
    }
    return captions;
}

@end
