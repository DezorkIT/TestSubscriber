# TestSubscriber

Package for testing publishers in `Combine` framework.

# Usage

To start you need to create TestSubscriber and subscribe your publisher to it

```swift
  let subject = PassthroughSubject<Int, TestError>()
  let subscriber = TestSubscriber<Int, TestError>()
  subject.subscribe(subscriber)
```
Assertion works by throwing exceptions, your tests methods should be declared with `throws` keyword.

## Examples

Value assertion:

```swift
  subject.send(1)
  subject.send(2)
  subject.send(completion: .finished)

  try subscriber
      .assertValues(1,2)
```

Error assertion:

```swift
  subject.send(completion: .failure(.known))

  try subscriber
      .assertError(.known)
```

If your publisher is a subject you have to:

call finish on it

```swift
  subject.send(completion: .finished)
```

or failure

```swift
  subject.send(completion: .failure(.known))
```

or call unsubscribe method declared in TestSubscriber

```swift
  try subscriber
    .assertNoIntrecationsResult()
    .unsubscribe()
```

You can find more examples in [test directory](https://github.com/DezorkIT/TestSubscriber/tree/main/Tests/TestSubscriberTests)
