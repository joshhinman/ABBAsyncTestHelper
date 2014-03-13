ABBAsyncTestHelper: Unit Tests for Asynchronous Methods
==================

ABBAsyncTestHelper provides a simple way to pause the execution of a unit test while waiting for a callback method to be invoked.

Example
-------


    - (void)testMyAsyncObject
    {
        ABBAsyncTestHelper *asyncHelper = [[ABBAsyncTestHelper alloc] init];
        [myObj doThingInBackgroundWithCompletionHandler:^(NSObject *result)
        {
            XCTAssertNotNil(result);
            [asyncHelper signal];
        }];
        [asyncHelper waitForSignal:1.0]; // This line will block until -signal is called in the callback
    }

Why?
----

In XCTest, OCUnit, and many other testing frameworks, when the execution of a single unit test reaches the end of a test method, the test is considered done, and if no assertions have failed, the test is considered a pass. This presents a problem when writing tests for methods that return immediately and perform their work on a background thread---how do you prevent your unit test from exiting before the background thread is finished?

ABBAsyncTestHelper blocks execution of a test while background processing is happening. To use it, call `-waitForSignal` after calling an asynchronous method. That will temporarily block the unit test from executing while your asynchronous method is doing its work on a background thread. Once that work is complete, your callback block should call `-signal`, which resumes execution of your test method.

What if my callbacks get called on the main thread? Won't they be blocked?
----

While `-waitForSignal` is blocking, the main run loop is still processing inputs and running blocks submitted to the main queue. All your main thread operations should run normally.

