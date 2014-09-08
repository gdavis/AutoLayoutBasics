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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoHeightConstraint;

@end


@implementation ViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedVideoPlayer"]) {
        self.videoPlayerViewController = segue.destinationViewController;
        self.videoPlayerViewController.delegate = self;
    }
}

#warning Exercise Code
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.view setNeedsUpdateConstraints];
}


- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self updateVideoPlayerConstraints];
}


- (void)updateVideoPlayerConstraints
{
    CGSize videoSize;
    
    if (self.videoPlayerViewController.isFullscreen) {
        videoSize = self.view.bounds.size;
    }
    else {
        videoSize = CGSizeMake(720.0f, 480.0f);
    }
    
    self.videoWidthConstraint.constant = videoSize.width;
    self.videoHeightConstraint.constant = videoSize.height;
}


- (void)videoPlayerDidChangeFullscreenMode:(BOOL)isFullscreen
{
    [self updateVideoPlayerConstraints];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}
#warning Exercise Code END


@end
