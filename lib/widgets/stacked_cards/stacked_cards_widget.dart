import 'package:flutter/material.dart';

class StackedCardsWidget<T> extends StatefulWidget {
  final List<T> items;
  final double cardHeight;
  final Widget Function(BuildContext context, T item, int index, bool isStacked)
      itemBuilder;

  const StackedCardsWidget({
    super.key,
    required this.items,
    this.cardHeight = 200.0,
    required this.itemBuilder,
  });

  @override
  State<StackedCardsWidget<T>> createState() => _StackedCardsWidgetState<T>();
}

class _StackedCardsWidgetState<T> extends State<StackedCardsWidget<T>>
    with SingleTickerProviderStateMixin {
  late final double _cardHeight;
  late int _totalItems;
  double _scrollOffset = 0.0;

  // Track the drag position
  double _dragStartPosition = 0.0;
  double _dragCurrentPosition = 0.0;

  // Track if cards are expanded or stacked
  bool _isExpanded = false;

  // Animation controller for smooth transitions
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    _cardHeight = widget.cardHeight;
    _totalItems = widget.items.length;

    // Initialize with cards stacked (iOS notification style)
    _scrollOffset = _cardHeight *
        _totalItems; // Start with enough scroll to stack all cards

    // Setup animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _expandAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Listen to animation to update the widget
    _animationController.addListener(() {
      setState(() {
        if (_isExpanded) {
          // Animate from stacked to expanded
          _scrollOffset =
              _cardHeight * _totalItems * (1 - _expandAnimation.value);
        } else {
          // Animate from expanded to stacked
          _scrollOffset = _cardHeight * _totalItems * _expandAnimation.value;
        }
      });
    });
  }

  @override
  void didUpdateWidget(StackedCardsWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update total items if the list changes
    if (widget.items.length != oldWidget.items.length) {
      _totalItems = widget.items.length;

      // Adjust scroll offset if needed
      if (!_isExpanded) {
        _scrollOffset = _cardHeight * _totalItems;
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onVerticalDragStart(DragStartDetails details) {
    // Always track drag start position, even when collapsed
    _dragStartPosition = details.globalPosition.dy;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _dragCurrentPosition = details.globalPosition.dy;
    final dragDelta = _dragStartPosition - _dragCurrentPosition;

    // Calculate the new scroll offset but don't apply it yet
    final newScrollOffset =
        (_scrollOffset + dragDelta).clamp(0.0, _cardHeight * _totalItems);

    // Limit the maximum change per frame to prevent excessive jumps during fast scrolling
    const maxDeltaPerFrame = 30.0; // Pixels
    final limitedDelta = (newScrollOffset - _scrollOffset)
        .clamp(-maxDeltaPerFrame, maxDeltaPerFrame);

    setState(() {
      _scrollOffset = _scrollOffset + limitedDelta;
    });

    // Reset start position for next update
    _dragStartPosition = _dragCurrentPosition;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    // No additional logic needed here
  }

  void _toggleExpanded() {
    if (_isExpanded) {
      _collapseCards();
    } else {
      _expandCards();
    }
  }

  void _expandCards() {
    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
        // Set scroll offset to 0 immediately when expanding to allow scrolling
        _scrollOffset = 0;
        _animationController.forward(from: 0);
      });
    }
  }

  void _collapseCards() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
        // Reset scroll offset to fully stacked position
        _scrollOffset = _cardHeight * _totalItems;
        _animationController.reverse(from: 1.0);
      });
    }
  }

  // Define a threshold for when cards should start stacking
  // This will make the transition smoother
  final double _stackingThreshold = 50.0;

  double _getCardOffset(int index) {
    // Calculate the normal position for the card
    final normalPosition = (index * _cardHeight) - _scrollOffset;

    // First card (index 0) should never go below 0
    if (index == 0) {
      return normalPosition < 0 ? 0 : normalPosition;
    }

    // For other cards, check if we're approaching the stacking threshold
    if (_scrollOffset > 0) {
      // If the card is already above the first card, stack it
      if (normalPosition < 0) {
        return index * 12.0; // Stacked offset
      }

      // If the card is approaching the first card (within threshold),
      // gradually transition to stacked position
      if (normalPosition < _stackingThreshold) {
        // Calculate a transition factor (0 to 1) based on how close we are to threshold
        final transitionFactor = 1.0 - (normalPosition / _stackingThreshold);

        // Blend between normal position and stacked position
        return normalPosition * (1.0 - transitionFactor) +
            (index * 12.0) * transitionFactor;
      }
    }

    // Otherwise, normal list behavior
    return normalPosition;
  }

  bool _shouldRenderCard(int index) {
    // Calculate the normal position for the card
    final normalPosition = (index * _cardHeight) - _scrollOffset;

    // If we're scrolling up and approaching or past stacking threshold
    if (_scrollOffset > 0 && normalPosition < _stackingThreshold) {
      // Show all cards that would be stacked under the first card
      return index < _totalItems; // Show all cards that can be stacked
    }

    // For normal scrolling, only show cards that would be visible
    // or about to become visible
    return normalPosition < _cardHeight * 4 && normalPosition > -_cardHeight;
  }

  // Check if the cards are visually in stacked mode
  bool get _isVisuallyStacked {
    // If we're not expanded or if we have significant scroll offset
    return !_isExpanded || _scrollOffset > _cardHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      onTap: () {
        // Prevent rapid toggle by adding a small delay
        if (!_animationController.isAnimating) {
          _toggleExpanded();
        }
      },
      behavior: HitTestBehavior
          .opaque, // Ensure gestures are captured even on transparent areas
      child: ClipRect(
        // Add ClipRect to prevent overflow
        child: SizedBox.expand(
          child: Stack(
            children: List.generate(widget.items.length, (index) {
              if (!_shouldRenderCard(index)) {
                return const SizedBox.shrink();
              }

              // Calculate the normal position for the card
              final normalPosition = (index * _cardHeight) - _scrollOffset;

              // Determine if this card is in "stack mode" or approaching it
              final isFullyStacked =
                  _scrollOffset > 0 && normalPosition < 0 && index > 0;
              final isApproachingStacked = _scrollOffset > 0 &&
                  normalPosition < _stackingThreshold &&
                  index > 0;

              // Calculate transition factor for visual effects
              final transitionFactor = isApproachingStacked
                  ? (1.0 - (normalPosition / _stackingThreshold))
                      .clamp(0.0, 1.0)
                  : 0.0;

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                top: _getCardOffset(index),
                left: 0,
                right: 0,
                height: _cardHeight,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    // Apply scaling based on transition factor
                    ..scale(
                      isApproachingStacked
                          ? 1.0 -
                              (index * 0.02 * transitionFactor).clamp(0.0, 0.1)
                          : 1.0,
                    ),
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: isFullyStacked && index == 0
                        ? 8
                        : isApproachingStacked
                            ? 4 + (4 * transitionFactor)
                            : 4, // Smooth elevation transition
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: isApproachingStacked
                          ? 4.0 + (index * 1.5 * transitionFactor)
                          : 4.0,
                    ), // Reduced vertical margins to prevent overflow
                    child: widget.itemBuilder(
                      context,
                      widget.items[index],
                      index,
                      _isVisuallyStacked,
                    ),
                  ),
                ),
              );
            }).reversed.toList(), // Reverse to get proper stacking order
          ),
        ),
      ),
    );
  }
}
