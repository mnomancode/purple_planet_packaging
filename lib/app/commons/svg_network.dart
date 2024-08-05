import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

class SvgNetwork extends StatelessWidget {
  const SvgNetwork({super.key, required this.url, this.padding = const EdgeInsets.all(8.0)});

  final String url;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CachedNetworkSVGImage(
        fadeDuration: const Duration(milliseconds: 300),
        url,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        // placeholder: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
