import 'dart:async';

import 'package:kafka/kafka.dart';

Future main() async {
  var host = ContactPoint('localhost', 9093);
  var session = KafkaSession([host]);

  var producer = Producer(session, 1, 1000);
  var result = await producer.produce([
    ProduceEnvelope('test', 0, [Message('Hello World'.codeUnits)]),
  ]);
  print(result.hasErrors);
  print(result.offsets);
  session.close();
}
