//
//  VideoPlayerVideoViewController.m
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import "VideoPlayerVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>


static const NSTimeInterval VideoPlayerVideoViewProgressUpdateInterval = 1.0f / 30.0f; // 30 fps


@interface VideoPlayerVideoViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;
@property (nonatomic) CGFloat progress;
@property (nonatomic, strong) NSTimer *progressTimer;

@end


@implementation VideoPlayerVideoViewController


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.progressTimer invalidate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupVideoPlayer];
    
    [self setupNotifications];
    
    [self setupProgressTimer];
}


#pragma mark - Setup


- (void)setupVideoPlayer
{
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"oceans-clip" withExtension:@"mp4"];
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayerController.controlStyle = MPMovieControlStyleNone;
    self.moviePlayerController.shouldAutoplay = NO;
    [self.view addSubview: self.moviePlayerController.view];
    self.moviePlayerController.view.translatesAutoresizingMaskIntoConstraints = NO;
}


- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.moviePlayerController];
}


- (void)setupProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:VideoPlayerVideoViewProgressUpdateInterval target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}


- (NSArray *)constraintsToFillSuperviewWithView:(UIView *)view
{
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:kNilOptions metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:kNilOptions metrics:nil views:views]];
    return [constraints copy];
}


#pragma mark - View Updates


- (void)updateProgress
{
    CGFloat progress = self.moviePlayerController.currentPlaybackTime / self.moviePlayerController.duration;
    
    if (isnan(progress)) {
        progress = 0;
    }
    
    if (self.progress != progress) {
        self.progress = progress;
        [self.delegate videoPlayerPlaybackDidChangeProgress:progress];
    }
}


- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.view addConstraints:[self constraintsToFillSuperviewWithView:self.moviePlayerController.view]];
}


#pragma mark - Video Control


- (void)play
{
    [self.moviePlayerController play];
}


- (void)pause
{
    [self.moviePlayerController pause];
}


#pragma mark - MoviePLayerController Notifications


- (void)playStateDidChange:(NSNotification *)notification
{
    switch (self.moviePlayerController.playbackState) {
        case MPMoviePlaybackStatePlaying:
            [self.delegate videoPlayerPlaybackDidStart];
            break;
            
        case MPMoviePlaybackStatePaused:
            [self.delegate videoPlayerPlaybackDidPause];
            break;
            
        case MPMoviePlaybackStateStopped:
            [self.delegate videoPlayerPlaybackDidStop];
            break;
            
        default:
            break;
    }
}


@end
