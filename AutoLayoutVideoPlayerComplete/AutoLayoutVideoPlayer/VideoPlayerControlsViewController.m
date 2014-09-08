//
//  VideoPlayerControlsViewController.m
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import "VideoPlayerControlsViewController.h"


@interface VideoPlayerControlsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (nonatomic, strong) UIImage *playImage;
@property (nonatomic, strong) UIImage *pauseImage;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end


@implementation VideoPlayerControlsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.playImage = [UIImage imageNamed:@"play"];
    self.pauseImage = [UIImage imageNamed:@"pause"];
    
    [self updatePlayPauseButtonImage];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 1.0f / [UIScreen mainScreen].scale;
        view.backgroundColor = [UIColor blackColor];
    }];
}


#pragma mark - Properties


- (void)setShowPauseButton:(BOOL)showPauseButton
{
    _showPauseButton = showPauseButton;
    
    [self updatePlayPauseButtonImage];
}


- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self updateProgress];
}


#pragma mark - View Updating


- (void)updatePlayPauseButtonImage
{
    if (self.showPauseButton) {
        [self.playPauseButton setImage:self.pauseImage forState:UIControlStateNormal];
    }
    else {
        [self.playPauseButton setImage:self.playImage forState:UIControlStateNormal];
    }
}


- (void)updateProgress
{
    self.progressView.progress = self.progress;
}


#pragma mark - UI Actions


- (IBAction)playPauseButtonTouched:(id)sender
{
    if ([[self.playPauseButton imageForState:UIControlStateNormal] isEqual:self.pauseImage]) {
        [self.delegate controlsDidTouchPause];
    }
    else {
        [self.delegate controlsDidTouchPlay];
    }
}


- (IBAction)largeButtonTouched:(id)sender
{
    [self.delegate controlsDidTouchFullscreen];
}


- (IBAction)smallButtonTouched:(id)sender
{
    [self.delegate controlsDidTouchSmallscreen];
}


@end
