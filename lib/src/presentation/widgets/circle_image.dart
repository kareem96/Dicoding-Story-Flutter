import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String url;
  final double? size;

  const CircleImage({
    Key? key,
    required this.url,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        width: size,
        height: size,
        fadeInDuration: const Duration(milliseconds: 300),
        imageUrl: url,
        placeholder: (context, url) => SizedBox(
          width: Dimens.space46,
          height: Dimens.space46,
          child: const Loading(showMessage: false,),
        ),

      ),
    );
  }
}
