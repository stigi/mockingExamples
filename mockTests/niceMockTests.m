//
//  niceMockTests.m
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


@interface niceMockTests : XCTestCase
@property id seriousMock;
@property id niceMock;
@end

@implementation niceMockTests

- (void)setUp
{
    [super setUp];
    self.niceMock = [OCMockObject niceMockForClass:[NXIncrementor class]];
    self.seriousMock = [OCMockObject mockForClass:[NXIncrementor class]];
}


#pragma mark - Nice Mocks
// OCMockito is always nice

- (void)testOCMockNice
{
    [self.niceMock increment];
    
    [self.niceMock verify];
}

- (void)testOCMockSerious
{
    [[self.seriousMock expect] increment];
    
    [self.seriousMock increment];
    
    [self.seriousMock verify];
}

@end
