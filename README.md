Merge All
=========
An alternative interface to the [merge](https://github.com/JosephMoniz/dart-merge)
stream transformer. It merges multiple streams together into one wiht a given
concurrency. This is interface is useful when all streams to be merged are known
up front, while the base `merge` interface is useful when the streams to merge
aren't known up front and are the results of other streams.

Example
-------
```dart
import 'dart:async';
import 'package:merge_all/merge_all.dart';

main() {
  var numbers    = new StreamController();
  var letters    = new StreamController();
  var animals    = new StreamController();

  // The streams to merge with the numbers stream
  var others = [letters.stream, animals.stream];

  // create a merged stream with a concurrency of 2
  var merged = numbers.stream
                      .transform(new MergeAll(2, others))
                      .listen(print);

  // Pump data through the animal stream first, nothing should happen
  // due to it being the third item w/ a concurrency of 2
  animals.add("Cat");
  animals.add("Dog");

  // Now lets push some numbers and letters through and close those streams
  numbers.add(1);
  letters.add('a');
  numbers.add(2);
  letters.add('b');
  numbers.close();
  letters.close();

  // push some more animals through and close that stream
  animals.add("Bird");
  animals.add("Fish");
  animals.close();
}
```
