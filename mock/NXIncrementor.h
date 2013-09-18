//
//  NXIncrementor.h
//  mock
//
//  Created by Ullrich Schäfer on 18/09/13.
//  Copyright (c) 2013 nxtbgthng GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NXIncrementCompletionBlock)(NSInteger result);
@interface NXIncrementor : NSObject

@property (readonly) NSInteger value;
- (void)increment;
- (void)incrementByTwo;

- (void)incrementByX:(NSInteger)x;
- (void)incrementByXNumber:(NSNumber *)x;

- (void)asyncIncrementWithCompletionBlock:(NXIncrementCompletionBlock)block;

@end
