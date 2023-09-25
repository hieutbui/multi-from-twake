import 'dart:typed_data';

import 'package:fluffychat/pages/chat/events/message_content_style.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/event_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:matrix/matrix.dart';
import 'package:fluffychat/widgets/mxc_image.dart';

class ImageBubble extends StatelessWidget {
  final Event event;
  final bool tapToView;
  final BoxFit fit;
  final bool maxSize;
  final Color? backgroundColor;
  final bool thumbnailOnly;
  final bool animated;
  final double width;
  final double height;
  final void Function()? onTapPreview;
  final void Function()? onTapSelectMode;
  final Uint8List? imageData;
  final Duration animationDuration;

  const ImageBubble(
    this.event, {
    this.imageData,
    this.tapToView = true,
    this.maxSize = true,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.thumbnailOnly = true,
    this.width = 256,
    this.height = 300,
    this.animated = false,
    this.onTapSelectMode,
    this.onTapPreview,
    this.animationDuration = const Duration(milliseconds: 500),
    Key? key,
  }) : super(key: key);

  Widget _buildPlaceholder(BuildContext context) {
    if (event.messageType == MessageTypes.Sticker) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    final String blurHashString =
        event.blurHash ?? AppConfig.defaultImageBlurHash;
    final ratio = event.infoMap['w'] is int && event.infoMap['h'] is int
        ? event.infoMap['w'] / event.infoMap['h']
        : 1.0;
    var width = 32;
    var height = 32;
    if (ratio > 1.0) {
      height = (width / ratio).round();
    } else {
      width = (height * ratio).round();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: BlurHash(
          hash: blurHashString,
          decodingWidth: width,
          decodingHeight: height,
          imageFit: fit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bubbleWidth = MessageContentStyle.imageBubbleWidth(width);
    final bubbleHeight = MessageContentStyle.imageBubbleWidth(height);
    return Hero(
      tag: event.eventId,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: MessageContentStyle.borderRadiusBubble,
          ),
          constraints: maxSize
              ? BoxConstraints(
                  maxWidth: bubbleWidth,
                  maxHeight: bubbleHeight,
                )
              : null,
          child: ClipRRect(
            borderRadius: MessageContentStyle.borderRadiusBubble,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: bubbleWidth,
                  height: bubbleHeight,
                  child:
                      const BlurHash(hash: MessageContentStyle.defaultBlurHash),
                ),
                MxcImage(
                  event: event,
                  width: width,
                  height: height,
                  fit: fit,
                  animated: animated,
                  isThumbnail: thumbnailOnly,
                  placeholder: _buildPlaceholder,
                  onTapPreview: onTapPreview,
                  onTapSelectMode: onTapSelectMode,
                  imageData: imageData,
                  isPreview: true,
                  animationDuration: animationDuration,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
