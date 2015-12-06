//
//  EmbedVideoPlayerViewController.h
//  Stationfy
//
//  Created by Felipe Cardoso on 12/5/15.
//  Copyright © 2015 Stationfy. All rights reserved.
//

#if !__has_feature(nullability)
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nullable
#endif

#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  A subclass of `MPMoviePlayerViewController` for playing YouTube videos.
 *
 *  Use UIViewController’s `presentMoviePlayerViewControllerAnimated:` method to play a YouTube video fullscreen.
 *
 *  Use the `<presentInView:>` method to play a YouTube video inline.
 */
@interface EmbedVideoPlayerViewController : MPMoviePlayerViewController

@property (nonatomic, assign, getter = isEmbedded) BOOL embedded;

/**
 *  ------------------
 *  @name Initializing
 *  ------------------
 */

/**
 *  Initializes a YouTube video player view controller
 *
 *  @param videoUrl full video url
 *
 *  @return An initialized YouTube video player view controller with the specified video identifier.
 *
 *  @discussion You can pass a nil *videoIdentifier* (or use the standard `init` method instead) and set the `<videoIdentifier>` property later.
 */
- (instancetype) initWithVideoUrl:(nullable NSString *)videoUrl __attribute__((objc_designated_initializer));

/**
 *  ------------------------------------
 *  @name Accessing the video identifier
 *  ------------------------------------
 */

/**
 *  The 11 characters YouTube video identifier.
 */
@property (nonatomic, copy, nullable) NSString *videoUrl;

/**
 *  ------------------------
 *  @name Presenting a video
 *  ------------------------
 */

/**
 *  Present the video inside a view.
 *
 *  @param view The view inside which you want to present the video.
 *
 *  @discussion The video view is added as a subview of the specified view. The video does not start playing immediately, you have to call `[videoPlayerViewController.moviePlayer play]` for playback to start. See `MPMoviePlayerController` documentation for more information.
 *
 *  Ownership of the XCDYouTubeVideoPlayerViewController instance is transferred to the view.
 */
- (void) presentInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
