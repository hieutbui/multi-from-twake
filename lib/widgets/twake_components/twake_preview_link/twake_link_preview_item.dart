import 'package:fluffychat/presentation/model/media/url_preview_presentation.dart';
import 'package:fluffychat/utils/url_launcher.dart';
import 'package:fluffychat/widgets/mxc_image.dart';
import 'package:fluffychat/widgets/twake_components/twake_preview_link/twake_link_preview_item_style.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class TwakeLinkPreviewItem extends StatelessWidget {
  final bool ownMessage;
  final UrlPreviewPresentation urlPreviewPresentation;
  final String? previewLink;

  const TwakeLinkPreviewItem({
    super.key,
    required this.ownMessage,
    required this.urlPreviewPresentation,
    this.previewLink,
  });

  static const linkPreviewBodyKey = ValueKey('TwakeLinkPreviewBodyKey');

  static const linkPreviewNoImageKey = ValueKey('LinkPreviewNoImageKey');

  static const linkPreviewLargeKey = ValueKey('LinkPreviewLargeKey');

  static const linkPreviewSmallKey = ValueKey('LinkPreviewSmallKey');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: linkPreviewBodyKey,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxHeight: double.infinity,
      ),
      decoration: ShapeDecoration(
        color: ownMessage
            ? LinagoraRefColors.material().primary[95]
            : LinagoraStateLayer(
                LinagoraSysColors.material().surfaceTint,
              ).opacityLayer1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            TwakeLinkPreviewItemStyle.radiusBorder,
          ),
        ),
      ),
      child: _buildLinkPreview(context),
    );
  }

  Widget _buildLinkPreview(BuildContext context) {
    if (urlPreviewPresentation.imageUri == null ||
        urlPreviewPresentation.imageWidth == null ||
        urlPreviewPresentation.imageHeight == null) {
      return LinkPreviewNoImage(
        key: linkPreviewNoImageKey,
        urlPreviewPresentation: urlPreviewPresentation,
      );
    }

    return InkWell(
      onTap: () {
        if (previewLink == null) return;
        UrlLauncher(context, url: previewLink).launchUrl();
      },
      child: urlPreviewPresentation.imageHeight! > 200
          ? LinkPreviewLarge(
              key: linkPreviewLargeKey,
              urlPreviewPresentation: urlPreviewPresentation,
              previewLink: previewLink,
            )
          : LinkPreviewSmall(
              key: linkPreviewSmallKey,
              urlPreviewPresentation: urlPreviewPresentation,
              previewLink: previewLink,
            ),
    );
  }
}

class LinkPreviewNoImage extends StatelessWidget {
  const LinkPreviewNoImage({
    super.key,
    required this.urlPreviewPresentation,
  });

  final UrlPreviewPresentation urlPreviewPresentation;

  static const paddingTitleKey = ValueKey('PaddingTitleKey');

  static const paddingSubtitleKey = ValueKey('PaddingSubtitleKey');

  static const titleKey = ValueKey('TextTitleKey');

  static const subtitleKey = ValueKey('TextSubtitleKey');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (urlPreviewPresentation.title != null)
          Padding(
            key: paddingTitleKey,
            padding: TwakeLinkPreviewItemStyle.paddingTitle,
            child: Text(
              key: titleKey,
              urlPreviewPresentation.title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (urlPreviewPresentation.description != null)
          Padding(
            key: paddingSubtitleKey,
            padding: TwakeLinkPreviewItemStyle.paddingSubtitle,
            child: Text(
              key: subtitleKey,
              urlPreviewPresentation.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: LinagoraRefColors.material().neutral[50],
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

class LinkPreviewLarge extends StatelessWidget {
  const LinkPreviewLarge({
    super.key,
    required this.urlPreviewPresentation,
    this.previewLink,
  });

  final UrlPreviewPresentation urlPreviewPresentation;

  final String? previewLink;

  static const clipRRectKey = ValueKey('ClipRRectKey');

  static const mxcImageKey = ValueKey('MxcImageKey');

  static const paddingTitleKey = ValueKey('PaddingTitleKey');

  static const paddingSubtitleKey = ValueKey('PaddingSubtitleKey');

  static const titleKey = ValueKey('TextTitleKey');

  static const subtitleKey = ValueKey('TextSubtitleKey');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (previewLink == null) return;
        UrlLauncher(context, url: previewLink).launchUrl();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (urlPreviewPresentation.imageUri != null)
            ClipRRect(
              key: clipRRectKey,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  TwakeLinkPreviewItemStyle.radiusBorder,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: MxcImage(
                  key: mxcImageKey,
                  uri: urlPreviewPresentation.imageUri,
                  fit: BoxFit.cover,
                  isThumbnail: false,
                  placeholder: (_) => const SizedBox(),
                ),
              ),
            ),
          if (urlPreviewPresentation.title != null)
            Padding(
              key: paddingTitleKey,
              padding: TwakeLinkPreviewItemStyle.paddingTitle,
              child: Text(
                key: titleKey,
                urlPreviewPresentation.title!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (urlPreviewPresentation.description != null)
            Padding(
              key: paddingSubtitleKey,
              padding: TwakeLinkPreviewItemStyle.paddingSubtitle,
              child: Text(
                key: titleKey,
                urlPreviewPresentation.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: LinagoraRefColors.material().neutral[50],
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

class LinkPreviewSmall extends StatelessWidget {
  const LinkPreviewSmall({
    super.key,
    required this.urlPreviewPresentation,
    this.previewLink,
  });

  final String? previewLink;

  final UrlPreviewPresentation urlPreviewPresentation;

  static const clipRRectKey = ValueKey('ClipRRectKey');

  static const mxcImageKey = ValueKey('MxcImageKey');

  static const paddingTitleKey = ValueKey('PaddingTitleKey');

  static const paddingSubtitleKey = ValueKey('PaddingSubtitleKey');

  static const titleKey = ValueKey('TextTitleKey');

  static const subtitleKey = ValueKey('TextSubtitleKey');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (previewLink == null) return;
        UrlLauncher(context, url: previewLink).launchUrl();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (urlPreviewPresentation.imageUri != null)
            Padding(
              padding: TwakeLinkPreviewItemStyle.paddingPreviewImage,
              child: ClipRRect(
                key: clipRRectKey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    TwakeLinkPreviewItemStyle.radiusBorder,
                  ),
                ),
                child: SizedBox(
                  height: TwakeLinkPreviewItemStyle.heightMxcImagePreview,
                  width: TwakeLinkPreviewItemStyle.heightMxcImagePreview,
                  child: MxcImage(
                    key: mxcImageKey,
                    height: TwakeLinkPreviewItemStyle.heightMxcImagePreview,
                    width: TwakeLinkPreviewItemStyle.heightMxcImagePreview,
                    uri: urlPreviewPresentation.imageUri,
                    fit: BoxFit.cover,
                    isThumbnail: false,
                    placeholder: (_) => const SizedBox(),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (urlPreviewPresentation.title != null)
                  Padding(
                    key: paddingTitleKey,
                    padding: TwakeLinkPreviewItemStyle.paddingTitle,
                    child: Text(
                      key: titleKey,
                      urlPreviewPresentation.title!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (urlPreviewPresentation.description != null)
                  Padding(
                    key: paddingSubtitleKey,
                    padding: TwakeLinkPreviewItemStyle.paddingSubtitle,
                    child: Text(
                      key: subtitleKey,
                      urlPreviewPresentation.description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: LinagoraRefColors.material().neutral[50],
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
