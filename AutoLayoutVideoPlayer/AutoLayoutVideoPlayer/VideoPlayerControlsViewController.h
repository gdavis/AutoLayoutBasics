//
//  VideoPlayerControlsViewController.h
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoPlayerControlsViewControllerDelegate;


@interface VideoPlayerControlsViewController : UIViewController

@property (nonatomic, assign) id <VideoPlayerControlsViewControllerDelegate> delegate;
@property (nonatomic) BOOL showPauseButton;
@property (nonatomic) CGFloat progress;

@end


@protocol VideoPlayerControlsViewControllerDelegate <NSObject>

@required
- (void)controlsDidTouchPlay;
- (void)controlsDidTouchPause;
- (void)controlsDidTouchSmallscreen;
- (void)controlsDidTouchFullscreen;

@end