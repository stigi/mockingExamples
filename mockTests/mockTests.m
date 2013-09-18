//
//  mockTests.m
//  mockTests
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

@interface mockTests : XCTestCase
@property NXIncrementor *incrementorMockito;
@property id incrementorOCMock;
@end

@implementation mockTests

- (void)setUp
{
    [super setUp];
    
    self.incrementorMockito = mock([NXIncrementor class]);
    
    self.incrementorOCMock = [OCMockObject mockForClass:[NXIncrementor class]];
}

#pragma mark - Simple Verify

- (void)testOCMockitoVerify
{
    [self.incrementorMockito increment];
    
    [verify(self.incrementorMockito) increment];
}

- (void)testOCMockVerify
{
    [[self.incrementorOCMock expect] increment];
    [self.incrementorOCMock increment];
    
    [self.incrementorOCMock verify];
}


#pragma mark - Verify invocation counts

- (void)testOCMockitoVerifyTimes
{
    [self.incrementorMockito increment];
    [self.incrementorMockito increment];
    [self.incrementorMockito increment];
    
    [verifyCount(self.incrementorMockito, times(3)) increment];
    [verifyCount(self.incrementorMockito, atLeast(3)) increment]; // OCMockito only
}

- (void)testOCMockVerifyTimes
{
    [[self.incrementorOCMock expect] increment];
    [[self.incrementorOCMock expect] increment];
    [[self.incrementorOCMock expect] increment];
    
    [self.incrementorOCMock increment];
    [self.incrementorOCMock increment];
    [self.incrementorOCMock increment];
    
    [self.incrementorOCMock verify];
}


#pragma mark - Verify Arguments

- (void)testOCMockitoVerifyArguments
{
    [self.incrementorMockito incrementByX:2];
    
    [verify(self.incrementorMockito) incrementByX:2];
    
    // awesomeness++ by using OCHamcrest matchers
    [[verify(self.incrementorMockito) withMatcher:greaterThan(@1)] incrementByX:0];
    [[verify(self.incrementorMockito) withMatcher:equalToInt(2)] incrementByX:0];
}

- (void)testOCMockVerifyArguments
{
    [[self.incrementorOCMock expect] incrementByX:2];
    
    [self.incrementorOCMock incrementByX:2];
    
    [self.incrementorOCMock verify];
}

- (void)testOCMockVerifyAnyAgrument
{
    // OCMock - does not work with primitives
    [[self.incrementorOCMock expect] incrementByXNumber:OCMOCK_ANY];
    
    [self.incrementorOCMock incrementByXNumber:@2];
    
    [self.incrementorOCMock verify];
}

@end
