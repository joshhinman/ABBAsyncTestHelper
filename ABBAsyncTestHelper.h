//
//  ABBAsyncTestHelper.h
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

#import <Foundation/Foundation.h>

/**
 Objects of this class are used to synchronize
 an asynchronous method call.
 */
@interface ABBAsyncTestHelper : NSObject

/**
 Call this method from within the completion 
 block passed to the async function you are 
 testing. It is safe to call this method
 from any thread.
 */
- (void)signal;

/**
 Call this method just before your assertions. It 
 will not return until -signal is called.
 */
- (void)waitForSignal;

/**
 Call this method just before your assertions. It
 will return when -signal is called.
 If "waitTime" expires, an exception is thrown.
 */
- (void)waitForSignal:(NSTimeInterval)waitTime;

/**
 Call this method just before your assertions. It
 will not return until -signal is called.
 When the "waitUntil" date arrives, an exception is thrown.
 */
- (void)waitForSignalUntil:(NSDate *)waitUntil;

@end
