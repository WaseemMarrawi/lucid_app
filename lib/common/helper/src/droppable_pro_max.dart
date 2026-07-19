//for more information visit this link : https://medium.com/@muhammad.kuifatieh/droppable-pro-max-optimizing-user-experience-with-bloc-concurrency-996fa397daf5
import 'dart:async';

import 'package:bloc/bloc.dart';

mixin EventWithReload {
  bool _isReload = false;
  bool get isReload => _isReload;
  set isReload(bool isReload) {
    _isReload = isReload;
  }
}

EventTransformer<T> droppableProMax<T extends EventWithReload>() {
  return (events, mapper) {
    return events.transform(_ExhaustMapStreamTransformer(mapper));
  };
}

class _ExhaustMapStreamTransformer<T extends EventWithReload>
    extends StreamTransformerBase<T, T> {
  final EventMapper<T> mapper;

  _ExhaustMapStreamTransformer(this.mapper);
  @override
  Stream<T> bind(Stream<T> stream) {
    late StreamSubscription<T> subscription;
    StreamSubscription<T>? mappedSubscription;

    final controller = StreamController<T>(
      onCancel: () async {
        await mappedSubscription?.cancel();
        return subscription.cancel();
      },
      sync: true,
    );
    

    subscription = stream.listen(
      (data) {
        final event = data;
        if (mappedSubscription != null && event.isReload != true) return;
        if (event.isReload) {
          mappedSubscription?.cancel();
        }
        final Stream<T> mappedStream;
        mappedStream = mapper(data);
        mappedSubscription = mappedStream.listen(
          controller.add,
          onError: controller.addError,
          onDone: () => mappedSubscription = null,
        );
      },
      onError: controller.addError,
      onDone: () => mappedSubscription ?? controller.close(),
    );

    return controller.stream;
  }
}
