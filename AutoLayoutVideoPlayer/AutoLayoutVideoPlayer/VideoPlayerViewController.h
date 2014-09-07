//
//  VideoPlayerViewController.h
//  AutoLayoutVideoPlayer
//
//  Created by Grant Davis on 9/7/14.
//  Copyright (c) 2014 Grant Davis Interactive, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VideoPlayerViewControllerDelegate;

@interface VideoPlayerViewController : UIViewController

@property (nonatomic, getter=isFullscreen, readonly) BOOL fullscreen;
@property (nonatomic, assign) id <VideoPlayerViewControllerDelegate> delegate;

@end


@protocol VideoPlayerViewControllerDelegate <NSObject>

- (void)videoPlayerDidChangeFullscreenMode:(BOOL)isFullscreen;

@end
