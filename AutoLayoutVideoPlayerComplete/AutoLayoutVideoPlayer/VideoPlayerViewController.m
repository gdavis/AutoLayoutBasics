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

#warning Exercise code block
@property (weak, nonatomic) IBOutlet UILabel *closedCaptionLabel;
#warning END Exercise code block

#warning Exercise Code Block
@property (nonatomic, strong) UIViewController *endSlate;
#warning End Exercise Code Block

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


#warning Exercise Code Block - Fixes issue with closed captioning text not adjusting lines when resizing.
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.closedCaptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.frame);
    [self.closedCaptionLabel layoutIfNeeded];
}
#warning Exercise Code Block END


- (void)setFullscreen:(BOOL)fullscreen
{
    _fullscreen = fullscreen;
    
    [self.delegate videoPlayerDidChangeFullscreenMode:fullscreen];
}


#pragma mark - Large Play Button


- (IBAction)largePlayButtonTouched:(id)sender
{
    [self.videoViewController play];
}


#warning Example Code
// al8
#pragma mark - End Slate

- (void)showEndSlateView
{
    self.endSlate = [self.storyboard instantiateViewControllerWithIdentifier:@"endSlate"];
    [self.view insertSubview:self.endSlate.view aboveSubview:self.videoContainerView];
    
    // Important!
    self.endSlate.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // TODO: add some constraints
    NSArray *constraints = [self constraintsToFillSuperviewWithView:self.endSlate.view];
//    NSArray *constraints = [self constraintsWithVisualFormatToFillSuperviewWithView:self.endSlate.view];
//    NSArray *constraints = [self constraintsWithVisualFormatToCenterView:self.endSlate.view size:CGSizeMake(200.0f, 200.0f)];
    
    [self.view addConstraints:constraints];
}

- (void)hideEndSlateView
{
    [self.endSlate.view removeFromSuperview];
    self.endSlate = nil;
}
#warning Example Code END


#warning Example Code
// al9
- (NSArray *)constraintsToFillSuperviewWithView:(UIView *)view
{
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    return [constraints copy];
}
#warning Example Code END

#warning Example Code
// al10
- (NSArray *)constraintsWithVisualFormatToFillSuperviewWithView:(UIView *)view
{
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:kNilOptions metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:kNilOptions metrics:nil views:views]];
    return [constraints copy];
}
#warning Example Code END

#warning Example Code
// al11
- (NSArray *)constraintsWithVisualFormatToCenterView:(UIView *)view size:(CGSize)viewSize
{
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSDictionary *metrics = @{ @"width" : @(viewSize.width),
                               @"height" : @(viewSize.height) };
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(==width)]" options:kNilOptions metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(==height)]" options:kNilOptions metrics:metrics views:views]];
    
    // its currently not possible to do it with visual format alone!
    [constraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    return [constraints copy];
}
#warning Example Code END


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
    
#warning Exercise code block
    [self hideEndSlateView];
#warning Exercise code block END
}


- (void)videoPlayerPlaybackDidPause
{
    self.controlsViewController.showPauseButton = NO;
}


- (void)videoPlayerPlaybackDidStop
{
    self.controlsViewController.showPauseButton = NO;
    
#warning Exercise code block
    [self showEndSlateView];
#warning Exercise code block END
}


- (void)videoPlayerPlaybackDidChangeProgress:(CGFloat)progress
{
    self.controlsViewController.progress = progress;
    
#warning Exercise code block
    NSString *currentText = self.closedCaptionLabel.text;
    NSString *captionText = [self.captionsController captionTextForProgress:progress];
    
    if (currentText != captionText) {
        self.closedCaptionLabel.text = captionText;
    }
#warning END Exercise code block
}


@end
