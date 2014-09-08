//
//  VideoPlayerVideoViewController.h
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoPlayerVideoViewControllerDelegate;

@interface VideoPlayerVideoViewController : UIViewController

@property (nonatomic, assign) id <VideoPlayerVideoViewControllerDelegate> delegate;

- (void)play;
- (void)pause;

@end


@protocol VideoPlayerVideoViewControllerDelegate <NSObject>

@required
- (void)videoPlayerPlaybackDidStart;
- (void)videoPlayerPlaybackDidPause;
- (void)videoPlayerPlaybackDidStop;
- (void)videoPlayerPlaybackDidChangeProgress:(CGFloat)progress;

@end