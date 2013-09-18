//
//  partialMockTests.m
//  mock
//
//  Created by Ullrich Schäfer on 18/09/13.
//  Copyright (c) 2013 nxtbgthng GmbH. All rights reserved.
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import <XCTest/XCTest.h>


#import "NXIncrementor.h"


@interface partialMockTests : XCTestCase
@property NXIncrementor *incrementorMockito;
@property id incrementorOCMock;
@end

@implementation partialMockTests

- (void)setUp
{
    [super setUp];
    self.incrementorOCMock = [OCMockObject partialMockForObject:[[NXIncrementor alloc] init]];
}


#pragma mark - Partial Mocks

- (void)testOCMock
{
    expect([(NXIncrementor *)self.incrementorOCMock value]).to.equal(0);
    
    [self.incrementorOCMock incrementByTwo];
    
    expect([(NXIncrementor *)self.incrementorOCMock value]).to.equal(2);
}

@end
