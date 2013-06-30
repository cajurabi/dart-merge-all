library merge_all;

import 'dart:async';
import 'package:merge/merge.dart';

class MergeAll<S, T> extends StreamEventTransformer {

  final int _concurrency;
  final List<Stream<S>> _streams;

  const MergeAll(this._concurrency, this._streams);

  Stream<T> bind(Stream<S> stream) {
    var streams    = [stream];
    var controller = new StreamController();
    var merged     = controller.stream.transform(new Merge(this._concurrency));
    streams.addAll(this._streams);
    for (var n in streams) {
      controller.add(n);
    }
    controller.close();
    return merged;
  }

}