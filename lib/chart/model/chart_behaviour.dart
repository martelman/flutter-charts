part of flutter_charts;

class ChartBehaviour {
  const ChartBehaviour({
    this.isScrollable = false,
    this.scrollController,
    this.onItemClicked,
  });

  final bool isScrollable;
  final ScrollController scrollController;

  final ValueChanged<int> onItemClicked;

  void onChartItemClicked(int index) {
    onItemClicked?.call(index);
  }

  static ChartBehaviour lerp(ChartBehaviour a, ChartBehaviour b, double t) {
    return ChartBehaviour(
      isScrollable: t > 0.5 ? b.isScrollable : a.isScrollable,
      scrollController: t > 0.5 ? b.scrollController : a.scrollController,
      onItemClicked: t > 0.5 ? b.onItemClicked : a.onItemClicked,
    );
  }
}