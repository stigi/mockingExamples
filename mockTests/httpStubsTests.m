//
//  httpStubsTests.m
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
#import <OHHTTPStubs/OHHTTPStubsResponse+HTTPMessage.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import <XCTest/XCTest.h>


#import "NXIncrementor.h"


@interface httpStubsTests : XCTestCase

@end

@implementation httpStubsTests

- (void)setUp
{
    [super setUp];
    
    // install a request handler in case no other handler matches
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSLog(@"Unstubed Network Request: %@", request.URL.absoluteString);
        return [OHHTTPStubsResponse responseWithError:[NSError errorWithDomain:@"UnitTestErrorDomain" code:777 userInfo:nil]];
    }];
}

- (void)tearDown
{
    [OHHTTPStubs removeAllStubs];
    
    [super tearDown];
}


#pragma mark - HTTP Stub

- (void)testExample
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        
        return [[request.URL absoluteString] isEqualToString:@"http://services.faa.gov/airport/status/SFO?format=JSON"];
        
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        // this should be enough, but there's a wrong assertation in OHHTTPStubs, so lets load the data manually
        // return [OHHTTPStubsResponse responseNamed:@"SFO"
        //                                  inBundle:OHResourceBundle(@"Responses")];
        
        NSURL *responseURL = [OHResourceBundle(@"Responses") URLForResource:@"SFO"
                                                              withExtension:@"response"];
        
        NSData *responseData = [NSData dataWithContentsOfURL:responseURL];
        return [OHHTTPStubsResponse responseWithHTTPMessageData:responseData];

        
    }];
    
    
    __block NSDictionary *jsonDict = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://services.faa.gov/airport/status/SFO?format=JSON"]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                           }];
    
    
    expect(jsonDict[@"city"]).will.equal(@"San Francisco");
}

@end
