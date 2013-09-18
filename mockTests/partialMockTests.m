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
@property id incrementorOCMock;
@end

@implementation partialMockTests

- (void)setUp
{
    [super setUp];

    self.incrementorOCMock = [OCMockObject partialMockForObject:[[NXIncrementor alloc] init]];
}


#pragma mark - Partial Mocks

// not available in OCMockito
// there used to be spy() but it was removed a while ago
// see https://github.com/jonreid/OCMockito/commit/1a94939f2e771794d4d64c04da362e3483c599ca#commitcomment-3292036

- (void)testOCMock
{
    expect([(NXIncrementor *)self.incrementorOCMock value]).to.equal(0);
    
    [self.incrementorOCMock incrementByTwo];
    
    expect([(NXIncrementor *)self.incrementorOCMock value]).to.equal(2);
}

#pragma mark - Partial Mocks, beware

- (void)testOCMockPartialMockGotcha
{
    NXIncrementor *ourIncrementor = [[NXIncrementor alloc] init];
    
    expect(ourIncrementor.value).to.equal(0);
    
    @autoreleasepool {
        id partialMock = [OCMockObject partialMockForObject:ourIncrementor];
        
        [(NXIncrementor *)[[partialMock stub] andReturnValue:@2] value];
        
        expect([(NXIncrementor *)partialMock value]).to.equal(2);
        
        
        // so far so good, but what's that!?
        expect(ourIncrementor.value).to.equal(2); // !!!
        
        
        partialMock = nil;
    }

    // mhmm.... let's try that again... wait ! what ?!
    expect(ourIncrementor.value).to.equal(0); // !!! ZOMG^2 !!!
}
@end
