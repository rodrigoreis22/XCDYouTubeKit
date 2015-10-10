//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

@interface XCTest (Private)
- (void) setUpTestWithSelector:(SEL)selector;
@end

@interface NSURLRequest (Private)
+ (void) setAllowsAnyHTTPSCertificate:(BOOL)allowsAnyHTTPSCertificate forHost:(NSString *)host;
@end

@interface XCDYouTubeKitTestCase ()
@property NSURL *cassetteURL;
@end

static NSString *const offlineSuffix = @"_offline";

@implementation XCDYouTubeKitTestCase

+ (void) setUp
{
	NSDictionary *environment = NSProcessInfo.processInfo.environment;
	if ([environment[@"ONLINE_TESTS"] boolValue])
	{
		[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"www.youtube.com"];
		[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"s.ytimg.com"];
	}
}

// When running tests with the `ONLINE_TESTS` environment variable, tests whose
// selector ends with `_offline` are not executed.
+ (NSArray *) testInvocations
{
	BOOL onlineTests = [[[[NSProcessInfo processInfo] environment] objectForKey:@"ONLINE_TESTS"] boolValue];
	if (!onlineTests)
		return [super testInvocations];
	
	NSMutableArray *testInvocations = [NSMutableArray new];
	for (NSInvocation *invocation in [super testInvocations])
	{
		if (![NSStringFromSelector(invocation.selector) hasSuffix:offlineSuffix])
			[testInvocations addObject:invocation];
	}
	return [testInvocations copy];
}

@end
