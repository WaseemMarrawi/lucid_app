import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/barge_in_detector.dart';

void main() {
  test('ignores the calibrated noise floor and short spikes', () {
    final detector = BargeInDetector();
    final startedAt = DateTime(2026);
    detector.reset(now: startedAt);

    expect(
      detector.addPcm16(_pcm16(0.01), now: startedAt),
      isFalse,
    );
    expect(
      detector.addPcm16(
        _pcm16(0.01),
        now: startedAt.add(const Duration(milliseconds: 450)),
      ),
      isFalse,
    );
    expect(
      detector.addPcm16(
        _pcm16(0.2),
        now: startedAt.add(const Duration(milliseconds: 550)),
      ),
      isFalse,
    );
    expect(
      detector.addPcm16(
        _pcm16(0.01),
        now: startedAt.add(const Duration(milliseconds: 650)),
      ),
      isFalse,
    );
  });

  test('triggers after sustained customer speech', () {
    final detector = BargeInDetector();
    final startedAt = DateTime(2026);
    detector.reset(now: startedAt);

    detector.addPcm16(_pcm16(0.005), now: startedAt);
    expect(
      detector.addPcm16(
        _pcm16(0.18),
        now: startedAt.add(const Duration(milliseconds: 450)),
      ),
      isFalse,
    );
    expect(
      detector.addPcm16(
        _pcm16(0.18),
        now: startedAt.add(const Duration(milliseconds: 700)),
      ),
      isTrue,
    );
  });

  test('calibrates against AI speaker echo before detecting a louder voice', () {
    final detector = BargeInDetector();
    final startedAt = DateTime(2026);
    detector.reset(now: startedAt);

    detector.addPcm16(_pcm16(0.03), now: startedAt);
    detector.addPcm16(
      _pcm16(0.03),
      now: startedAt.add(const Duration(milliseconds: 250)),
    );
    expect(
      detector.addPcm16(
        _pcm16(0.03),
        now: startedAt.add(const Duration(milliseconds: 450)),
      ),
      isFalse,
    );
    expect(
      detector.addPcm16(
        _pcm16(0.08),
        now: startedAt.add(const Duration(milliseconds: 550)),
      ),
      isFalse,
    );
    expect(
      detector.addPcm16(
        _pcm16(0.08),
        now: startedAt.add(const Duration(milliseconds: 780)),
      ),
      isTrue,
    );
  });

  test('calculates PCM16 decibels relative to full scale', () {
    expect(BargeInDetector.pcm16Dbfs(_pcm16(0)), -100);
    expect(BargeInDetector.pcm16Dbfs(_pcm16(0.5)), closeTo(-6.02, 0.1));
  });
}

Uint8List _pcm16(double amplitude, {int samples = 1600}) {
  final bytes = Uint8List(samples * 2);
  final data = ByteData.sublistView(bytes);
  final sample = (amplitude.clamp(-1.0, 1.0) * 32767).round();

  for (var index = 0; index < samples; index++) {
    data.setInt16(index * 2, sample, Endian.little);
  }

  return bytes;
}
