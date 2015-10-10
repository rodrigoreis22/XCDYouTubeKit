//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XCDYouTubeKit/XCDYouTubeClient.h>

#import "Xtrace.h"

@interface XCDYouTubeClientTestCase : XCTestCase
@end

@implementation XCDYouTubeClientTestCase

- (void) setUp
{
	[super setUp];
	
	[objc_getClass("__NSURLSessionLocal") xtrace];
}

- (void) testThatVideoIsAvailalbe
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:500 handler:nil];
}

@end
