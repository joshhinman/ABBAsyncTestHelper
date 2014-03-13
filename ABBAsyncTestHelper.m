//
//  ABBAsyncTestHelper.m
//  Copyright (c) 2014 Josh Hinman
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "ABBAsyncTestHelper.h"

@implementation ABBAsyncTestHelper
{
    dispatch_semaphore_t _semaphore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

#if !OS_OBJECT_USE_OBJC_RETAIN_RELEASE
- (void)dealloc
{
    dispatch_release(_semaphore);
}
#endif

- (void)signal
{
    dispatch_semaphore_signal(_semaphore);
}

- (void)waitForSignal
{
    [self waitForSignalUntil:[NSDate distantFuture]];
}

- (void)waitForSignal:(NSTimeInterval)waitTime
{
    NSDate *waitUntil = [NSDate dateWithTimeIntervalSinceNow:waitTime];
    [self waitForSignalUntil:waitUntil];
}

- (void)waitForSignalUntil:(NSDate *)waitUntil
{
    while (dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_NOW))
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        if ([waitUntil timeIntervalSinceNow] <= 0)
        {
            [NSException raise:NSInternalInconsistencyException format:@"Asynchronous block never signaled"];
        }
    }
}

@end
