part of charts_painter;

/// Bubble painter
GeometryPainter<T> bubblePainter<T>(ChartItem<T> item, ChartState<T> state) =>
    BubbleGeometryPainter<T>(item, state);

/// Extension options for bar items
/// [geometryPainter] is set to [BubbleGeometryPainter]
///
/// Extra options included in [BubbleGeometryPainter] are:
/// [border] Define border width and color
/// [gradient] Item can have gradient color
class BubbleItemOptions extends ItemOptions {
  /// Constructor for bubble item options, has some options just for [BubbleGeometryPainter]
  const BubbleItemOptions({
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets multiValuePadding = EdgeInsets.zero,
    double maxBarWidth,
    double minBarWidth,
    Color color = Colors.red,
    ColorForValue colorForValue,
    ColorForKey colorForKey,
    this.gradient,
    this.border,
  }) : super(
          color: color,
          colorForValue: colorForValue,
          colorForKey: colorForKey,
          padding: padding,
          multiValuePadding: multiValuePadding,
          minBarWidth: minBarWidth,
          maxBarWidth: maxBarWidth,
          geometryPainter: bubblePainter,
        );

  /// Set gradient for each bubble item
  final Gradient gradient;

  /// Draw border on bubble items
  final BorderSide border;

  @override
  ItemOptions animateTo(ItemOptions endValue, double t) {
    return BubbleItemOptions(
      gradient: Gradient.lerp(gradient,
          endValue is BubbleItemOptions ? endValue.gradient : null, t),
      color: Color.lerp(color, endValue.color, t),
      colorForKey: ColorForKeyLerp.lerp(this, endValue, t),
      colorForValue: ColorForValueLerp.lerp(this, endValue, t),
      padding: EdgeInsets.lerp(padding, endValue.padding, t),
      multiValuePadding:
          EdgeInsets.lerp(multiValuePadding, endValue.multiValuePadding, t),
      maxBarWidth: lerpDouble(maxBarWidth, endValue.maxBarWidth, t),
      minBarWidth: lerpDouble(minBarWidth, endValue.minBarWidth, t),
      border: BorderSide.lerp(
          border ?? BorderSide.none,
          endValue is BubbleItemOptions
              ? (endValue.border ?? BorderSide.none)
              : BorderSide.none,
          t),
    );
  }

  @override
  Paint getPaintForItem(ChartItem<Object> item, Size size, int key) {
    final _paint = super.getPaintForItem(item, size, key);

    if (gradient != null) {
      _paint
        ..shader = gradient.createShader(
            Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    }

    return _paint;
  }
}
