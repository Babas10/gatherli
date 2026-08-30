// Shared sizing helper for cached network avatar images (Story 35.9).
import 'package:flutter/widgets.dart';

/// Converts a circular avatar's logical [diameter] (e.g. `radius * 2`) to a
/// physical-pixel dimension for `CachedNetworkImage`'s
/// `memCacheWidth`/`memCacheHeight` or `CachedNetworkImageProvider`'s
/// `maxWidth`/`maxHeight`, so decoded bitmaps aren't larger than the device
/// actually needs to render them.
int avatarCacheDimension(BuildContext context, double diameter) {
  return (diameter * MediaQuery.devicePixelRatioOf(context)).round();
}
