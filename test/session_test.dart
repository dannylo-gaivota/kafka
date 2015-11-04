library kafka.test.client;

import 'package:test/test.dart';
import 'package:kafka/kafka.dart';
import 'setup.dart';

void main() {
  group('Session', () {
    KafkaSession _session;

    tearDown(() async {
      await _session.close();
    });

    test('it can fetch topic metadata', () async {
      var host = await getDefaultHost();
      _session = new KafkaSession([new KafkaHost(host, 9092)]);
      var response = await _session.getMetadata();
      expect(response, new isInstanceOf<MetadataResponse>());
      expect(response.brokers, isNotEmpty);
    });

    test('it caches metadata', () async {
      var host = await getDefaultHost();
      _session = new KafkaSession([new KafkaHost(host, 9092)]);
      var response = await _session.getMetadata();
      expect(response, new isInstanceOf<MetadataResponse>());

      var response2 = await _session.getMetadata();
      expect(response2, same(response));
    });

    test('it invalidates cached metadata', () async {
      var host = await getDefaultHost();
      _session = new KafkaSession([new KafkaHost(host, 9092)]);
      var response = await _session.getMetadata();
      expect(response, new isInstanceOf<MetadataResponse>());

      var response2 = await _session.getMetadata(invalidateCache: true);
      expect(response2, isNot(same(response)));
    });
  });
}