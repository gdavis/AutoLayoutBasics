//
//  VideoPlayerViewController.m
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "VideoPlayerControlsViewController.h"
#import "VideoPlayerVideoViewController.h"


static const CGSize VideoPlayerViewControllerSmallSize = { 720.0f, 480.0f };
static const CGSize VideoPlayerViewControllerSmallLarge = { 1024.0f, 768.0f };



@interface VideoPlayerViewController () <VideoPlayerControlsViewControllerDelegate, VideoPlayerVideoViewControllerDelegate>

@property (nonatomic, strong) VideoPlayerVideoViewController *videoViewController;
@property (nonatomic, strong) VideoPlayerControlsViewController *controlsViewController;

@property (weak, nonatomic) IBOutlet UIButton *largePlayButton;

@property (nonatomic, getter=isLargeSize) BOOL largeSize;

@end



@implementation VideoPlayerViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"controls"]) {
        self.controlsViewController = segue.destinationViewController;
        self.controlsViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"player"]) {
        self.videoViewController = segue.destinationViewController;
        self.videoViewController.delegate = self;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.videoViewController pause];
}


- (CGSize)preferredContentSize
{
    if (self.isLargeSize) {
        return VideoPlayerViewControllerSmallLarge;
    }
    return VideoPlayerViewControllerSmallSize;
}


- (void)setLargeSize:(BOOL)largeSize
{
    _largeSize = largeSize;
    
    [self.view invalidateIntrinsicContentSize];
}

- (IBAction)largePlayButtonTouched:(id)sender
{
    [self.videoViewController play];
}


#pragma mark - VideoPlayerControlsViewControllerDelegate


- (void)controlsDidTouchPlay
{
    [self.videoViewController play];
}


- (void)controlsDidTouchPause
{
    [self.videoViewController pause];
}


- (void)controlsDidTouchSmallPlayer
{
    self.largeSize = NO;
}


- (void)controlsDidTouchLargePlayer
{
    self.largeSize = YES;
}


#pragma mark - VideoPlayerVideoViewControllerDelegate


- (void)videoPlayerPlaybackDidStart
{
    self.largePlayButton.hidden = YES;
    self.controlsViewController.showPauseButton = YES;
}


- (void)videoPlayerPlaybackDidPause
{
    self.largePlayButton.hidden = NO;
    self.controlsViewController.showPauseButton = NO;
}


- (void)videoPlayerPlaybackDidStop
{
    self.largePlayButton.hidden = NO;
    self.controlsViewController.showPauseButton = NO;
}


- (void)videoPlayerPlaybackDidChangeProgress:(CGFloat)progress
{
    self.controlsViewController.progress = progress;
}


@end
