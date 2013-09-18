//
//  NXIncrementor.m
//  mock
//
//  Created by Ullrich Schäfer on 18/09/13.
//  Copyright (c) 2013 nxtbgthng GmbH. All rights reserved.
//

#import "NXIncrementor.h"

@implementation NXIncrementor

- (void)increment;
{
    _value++;
}

- (void)incrementByTwo;
{
    _value += 2;
}

- (void)incrementByX:(NSInteger)x;
{
    _value += x;
}

- (void)incrementByXNumber:(NSNumber *)x;
{
    _value += [x integerValue];
}

- (void)asyncIncrementWithCompletionBlock:(NXIncrementCompletionBlock)block
{
    block = [block copy];
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        _value++;
        if (block) {
            block(_value);
        }
    });
}
@end
