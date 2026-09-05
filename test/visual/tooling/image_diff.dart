import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Per-channel difference below this is treated as anti-aliasing/encoding
/// noise, not a real visual change.
const int _perPixelNoiseThreshold = 30;

class ImageDiffResult {
  ImageDiffResult({
    required this.percentDifferent,
    required this.diffImageBytes,
    required this.dimensionMismatch,
  });

  final double percentDifferent;
  final Uint8List diffImageBytes;
  final bool dimensionMismatch;
}

/// Compares [goldenBytes] against [capturedBytes] (both PNG), returning the
/// percentage of pixels that differ by more than the noise threshold and a
/// diff-highlight PNG (mismatched pixels drawn in red over the captured
/// image).
ImageDiffResult diffImages({
  required Uint8List goldenBytes,
  required Uint8List capturedBytes,
}) {
  final golden = img.decodePng(goldenBytes);
  final captured = img.decodePng(capturedBytes);

  if (golden == null || captured == null) {
    throw ArgumentError('Failed to decode PNG for diffing');
  }

  if (golden.width != captured.width || golden.height != captured.height) {
    return ImageDiffResult(
      percentDifferent: 100,
      diffImageBytes: img.encodePng(captured),
      dimensionMismatch: true,
    );
  }

  final diffImage = img.Image(width: golden.width, height: golden.height);
  var diffPixelCount = 0;
  final totalPixels = golden.width * golden.height;

  for (var y = 0; y < golden.height; y++) {
    for (var x = 0; x < golden.width; x++) {
      final a = golden.getPixel(x, y);
      final b = captured.getPixel(x, y);
      final dr = (a.r - b.r).abs();
      final dg = (a.g - b.g).abs();
      final db = (a.b - b.b).abs();
      final pixelDiff = (dr + dg + db) / 3;

      if (pixelDiff > _perPixelNoiseThreshold) {
        diffPixelCount++;
        diffImage.setPixelRgb(x, y, 255, 0, 0);
      } else {
        diffImage.setPixelRgb(
          x,
          y,
          b.r.toInt(),
          b.g.toInt(),
          b.b.toInt(),
        );
      }
    }
  }

  final percentDifferent = (diffPixelCount / totalPixels) * 100;
  return ImageDiffResult(
    percentDifferent: percentDifferent,
    diffImageBytes: img.encodePng(diffImage),
    dimensionMismatch: false,
  );
}
