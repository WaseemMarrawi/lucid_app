import 'dart:math' as math;
import 'dart:typed_data';

class BargeInDetector {
  BargeInDetector({
    this.calibrationDuration = const Duration(milliseconds: 400),
    this.speechHoldDuration = const Duration(milliseconds: 220),
    this.minimumSpeechDb = -50,
    this.noiseFloorMarginDb = 6,
  });

  final Duration calibrationDuration;
  final Duration speechHoldDuration;
  final double minimumSpeechDb;
  final double noiseFloorMarginDb;

  DateTime? _startedAt;
  DateTime? _speechStartedAt;
  double _noiseFloorDb = -55;
  bool _triggered = false;

  void reset({DateTime? now}) {
    _startedAt = now ?? DateTime.now();
    _speechStartedAt = null;
    _noiseFloorDb = -55;
    _triggered = false;
  }

  bool addPcm16(Uint8List bytes, {DateTime? now}) {
    if (_triggered || bytes.length < 2) {
      return false;
    }

    final timestamp = now ?? DateTime.now();
    _startedAt ??= timestamp;
    final db = pcm16Dbfs(bytes);

    if (timestamp.difference(_startedAt!) < calibrationDuration) {
      _noiseFloorDb = db > _noiseFloorDb
          ? db
          : _blend(_noiseFloorDb, db, 0.12);
      _speechStartedAt = null;
      return false;
    }

    final threshold = math.max(
      minimumSpeechDb,
      _noiseFloorDb + noiseFloorMarginDb,
    );
    if (db < threshold) {
      _speechStartedAt = null;
      final weight = db < _noiseFloorDb ? 0.18 : 0.015;
      _noiseFloorDb = _blend(_noiseFloorDb, db, weight);
      return false;
    }

    _speechStartedAt ??= timestamp;
    if (timestamp.difference(_speechStartedAt!) < speechHoldDuration) {
      return false;
    }

    _triggered = true;
    return true;
  }

  static double pcm16Dbfs(Uint8List bytes) {
    final data = ByteData.sublistView(bytes);
    final sampleCount = bytes.length ~/ 2;
    var sumSquares = 0.0;

    for (var index = 0; index < sampleCount; index++) {
      final sample = data.getInt16(index * 2, Endian.little) / 32768.0;
      sumSquares += sample * sample;
    }

    final rms = math.sqrt(sumSquares / sampleCount);
    if (rms <= 0.00001) {
      return -100;
    }

    return 20 * math.log(rms) / math.ln10;
  }

  static double _blend(double current, double next, double weight) {
    return current + ((next - current) * weight);
  }
}
