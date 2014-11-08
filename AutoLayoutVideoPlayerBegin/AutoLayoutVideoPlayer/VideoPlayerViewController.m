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
#import "VideoPlayerCaptionController.h"


@interface VideoPlayerViewController () <VideoPlayerControlsViewControllerDelegate, VideoPlayerVideoViewControllerDelegate>

@property (nonatomic, strong) VideoPlayerVideoViewController *videoViewController;
@property (nonatomic, strong) VideoPlayerControlsViewController *controlsViewController;
@property (nonatomic, strong) VideoPlayerCaptionController *captionsController;

@property (weak, nonatomic) IBOutlet UIButton *largePlayButton;
@property (weak, nonatomic) IBOutlet UIView *videoContainerView;

@property (nonatomic, getter=isFullscreen) BOOL fullscreen;

#warning al7

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
    
    self.captionsController = [VideoPlayerCaptionController new];
    
    [self.videoViewController pause];
}


#warning al5


- (void)setFullscreen:(BOOL)fullscreen
{
    _fullscreen = fullscreen;
    
    [self.delegate videoPlayerDidChangeFullscreenMode:fullscreen];
}


#warning al8

#warning al9-11


#pragma mark - Large Play Button


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


- (void)controlsDidTouchSmallscreen
{
    self.fullscreen = NO;
}


- (void)controlsDidTouchFullscreen
{
    self.fullscreen = YES;
}


#pragma mark - VideoPlayerVideoViewControllerDelegate


- (void)videoPlayerPlaybackDidStart
{
    self.largePlayButton.hidden = YES;
    self.controlsViewController.showPauseButton = YES;
    
    // TODO: Hide end slate
}


- (void)videoPlayerPlaybackDidPause
{
    self.controlsViewController.showPauseButton = NO;
}


- (void)videoPlayerPlaybackDidStop
{
    self.controlsViewController.showPauseButton = NO;
    
    // TODO: Show end slate
}


- (void)videoPlayerPlaybackDidChangeProgress:(CGFloat)progress
{
    self.controlsViewController.progress = progress;
    
    // al4
}


@end
