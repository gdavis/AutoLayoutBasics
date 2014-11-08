//
//  ViewController.m
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayerViewController.h"


@interface ViewController () <VideoPlayerViewControllerDelegate>

@property (nonatomic, strong) VideoPlayerViewController *videoPlayerViewController;

@end


@implementation ViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedVideoPlayer"]) {
        self.videoPlayerViewController = segue.destinationViewController;
        self.videoPlayerViewController.delegate = self;
    }
}


#warning al1


- (void)videoPlayerDidChangeFullscreenMode:(BOOL)isFullscreen
{
    #warning al2
}


#warning al3


@end
