//
//  stubTests.m
//  mock
//
//  Created by Ullrich Schäfer on 18/09/13.
//  Copyright (c) 2013 nxtbgthng GmbH. All rights reserved.
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import <XCTest/XCTest.h>

#import "NXIncrementor.h"


@interface stubTests : XCTestCase
@property NXIncrementor *incrementorMockito;
@property id incrementorOCMock;
@end


@implementation stubTests

- (void)setUp
{
    [super setUp];
    
    self.incrementorMockito = mock([NXIncrementor class]);
    
    self.incrementorOCMock = [OCMockObject mockForClass:[NXIncrementor class]];
}


#pragma mark - Simple Stubing

- (void)testMockitoStub
{
    [given([self.incrementorMockito value]) willReturnInteger:3];
    
    expect([self.incrementorMockito value]).to.equal(3);
}


- (void)testOCMockStub
{
    [(NXIncrementor *)[[self.incrementorOCMock stub] andReturnValue:@(3)] value];
    
    expect([(NXIncrementor *)self.incrementorOCMock value]).to.equal(3);
}



#pragma mark - Stubs with callback blocks

- (void)testAsynMockitoStub
{
    // not imeplemented
    // https://github.com/jonreid/OCMockito/issues/12
}

#warning skipped test
- (void)skip__testAsyncOCMockStub
{
    // andCall:onObject: or andDo:
    [[[self.incrementorOCMock stub] andCall:@selector(stubHelper:) onObject:self] asyncIncrementWithCompletionBlock:[OCMArg anyPointer]];
    
    __block NSInteger value = 0;
    [self.incrementorOCMock asyncIncrementWithCompletionBlock:^(NSInteger result) {
        expect(result).to.equal(99);
        value = result;
    }];
    
    expect(value).will.equal(99);
}

- (void)stubHelper:(NXIncrementCompletionBlock)block
{
    block(99);
}



@end
