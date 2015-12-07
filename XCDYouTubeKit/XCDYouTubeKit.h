//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <TargetConditionals.h>

#import <XCDYouTubeKit/XCDYouTubeClient.h>
#import <XCDYouTubeKit/XCDYouTubeError.h>
#import <XCDYouTubeKit/XCDYouTubeOperation.h>
#import <XCDYouTubeKit/XCDYouTubeVideo.h>
#import <XCDYouTubeKit/XCDYouTubeVideoOperation.h>

#if TARGET_OS_IOS || (!defined(TARGET_OS_IOS) && TARGET_OS_IPHONE)
#import <XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeKit/EmbedVideoPlayerViewController.h>
#endif
