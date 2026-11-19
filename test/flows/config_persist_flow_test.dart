import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'harness.dart';

/// Storage whose config write stays pending until the test releases the gate.
class _GatedStorage extends LocalStorageService {
  // ignore: use_super_parameters — the super constructor's field is private.
  _GatedStorage(SharedPreferences prefs, this.gate) : super(prefs);

  final Completer<bool> gate;

  @override
  Future<bool> saveConfig(WatermarkConfig config) async {
    await gate.future;
    return super.saveConfig(config);
  }
}

/// Storage whose config write always fails, as a full/blocked disk would.
class _FailingSaveStorage extends LocalStorageService {
  // ignore: use_super_parameters — the super constructor's field is private.
  _FailingSaveStorage(SharedPreferences prefs) : super(prefs);

  @override
  Future<bool> saveConfig(WatermarkConfig config) async {
    throw ArgumentError('penyimpanan tidak tersedia');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FLOW-WMK-02-T07 mutasi konfigurasi menunggu tulisan storage selesai', () async {
    await freshStorage();
    final gate = Completer<bool>();
    final gated = _GatedStorage(await SharedPreferences.getInstance(), gate);
    final c = containerWith(gated);
    addTearDown(c.dispose);
    final sub = c.listen(watermarkConfigProvider, (_, _) {});
    addTearDown(sub.close);

    final dynamic notifier = c.read(watermarkConfigProvider.notifier);
    var finished = false;
    final write = (notifier.updateOpacity(0.5) as Future<void>)
        .then((_) => finished = true);

    // The write is gated, so the caller's future must still be pending. A
    // fire-and-forget mutator would hand back nothing at all.
    await Future<void>.delayed(Duration.zero);
    expect(
      finished,
      isFalse,
      reason: 'future mutasi tidak boleh selesai sebelum tulisan selesai',
    );

    gate.complete(true);
    await write;
    expect(finished, isTrue);
    expect(gated.loadConfig().opacity, 0.5);
  });

  test('FLOW-WMK-02-T08 kegagalan menulis konfigurasi dilaporkan ke pemanggil, bukan ditelan', () async {
    await freshStorage();
    final failing =
        _FailingSaveStorage(await SharedPreferences.getInstance());
    final c = containerWith(failing);
    addTearDown(c.dispose);

    final dynamic notifier = c.read(watermarkConfigProvider.notifier);
    await expectLater(
      notifier.updateOpacity(0.4),
      throwsA(isA<ArgumentError>()),
    );
  });
}
