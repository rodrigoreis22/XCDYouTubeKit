//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "EmbedVideoPlayerViewController.h"

#import <objc/runtime.h>

@interface EmbedVideoPlayerViewController ()

@end

@implementation EmbedVideoPlayerViewController

/*
 * MPMoviePlayerViewController on iOS 7 and earlier
 * - (id) init
 *        `-- [super init]
 *
 * - (id) initWithContentURL:(NSURL *)contentURL
 *        |-- [self init]
 *        `-- [self.moviePlayer setContentURL:contentURL]
 *
 * MPMoviePlayerViewController on iOS 8 and later
 * - (id) init
 *        `-- [self initWithContentURL:nil]
 *
 * - (id) initWithContentURL:(NSURL *)contentURL
 *        |-- [super init]
 *        `-- [self.moviePlayer setContentURL:contentURL]
 */

- (instancetype) init
{
    return [self initWithVideoUrl:nil];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype) initWithContentURL:(NSURL *)videoUrl
{
	self = [super initWithContentURL:videoUrl];
	return self;
}

- (instancetype) initWithVideoUrl:(NSString *)videoUrl
{
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8)
        self = [super initWithContentURL:nil];
    else
        self = [super init];
    
    if (!self)
        return nil;
    
    // See https://github.com/0xced/XCDYouTubeKit/commit/cadec1c3857d6a302f71b9ce7d1ae48e389e6890
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    if (videoUrl)
        self.videoUrl = videoUrl;
    
    return self;
}
#pragma clang diagnostic pop

#pragma mark - Public

- (void) setVideoUrl:(NSString *)videoUrl
{
    if ([videoUrl isEqual:self.videoUrl])
        return;
    
    _videoUrl = [videoUrl copy];
    
    self.moviePlayer.contentURL = [[NSURL alloc] initWithString: videoUrl];
}

- (void) presentInView:(UIView *)view
{
    static const void * const XCDYouTubeVideoPlayerViewControllerKey = &XCDYouTubeVideoPlayerViewControllerKey;
    
    self.embedded = YES;
    
    self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    self.moviePlayer.view.frame = CGRectMake(0.f, 0.f, view.bounds.size.width, view.bounds.size.height);
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (![view.subviews containsObject:self.moviePlayer.view])
        [view addSubview:self.moviePlayer.view];
    objc_setAssociatedObject(view, XCDYouTubeVideoPlayerViewControllerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Private


#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self isBeingPresented])
        return;
    
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    [self.moviePlayer play];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (![self isBeingDismissed])
        return;
}

@end