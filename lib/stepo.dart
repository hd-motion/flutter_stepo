import 'package:flutter/material.dart';

enum Direction { increment, decrement }
enum Style { vertical, horizontal }

class Stepo extends StatefulWidget {
  final double width, fontSize, iconSize;
  final Function(int) onIncrementClicked, onDecrementClicked;
  final Color textColor, iconColor, backgroundColor;
  final Duration animationDuration;
  final int initialCounter, upperBound, lowerBound;
  final Style style;
  Stepo({
    @required Key key,
    this.initialCounter,
    this.onIncrementClicked,
    this.onDecrementClicked,
    this.style,
    this.width,
    this.backgroundColor,
    this.fontSize,
    this.iconSize,
    this.textColor,
    this.iconColor,
    this.upperBound,
    this.lowerBound,
    this.animationDuration,
  }) : super(key: key);

  @override
  _StepoState createState() => _StepoState();
}

class _StepoState extends State<Stepo> with TickerProviderStateMixin {
  int _counter, upperBound, lowerBound;
  bool _isDecrementIconClicked = false;
  bool _isIncrementIconClicked = false;
  double rootWidth, rootHeight, fontSize, iconSize, cornerRadius;
  double textOpacity = 1;
  double textAnimationEndValue;
  Duration textAnimationDuration;
  Duration iconAnimationDuration;
  Duration scaleDuration = Duration(milliseconds: 100);
  Function onIncrementClicked, onDecrementClicked;
  Color textColor, iconColor, backgroundColor;
  Style style;

  Animation<double> textIncrementAnimation,
      textDecrementAnimation,
      incrementIconAnimation,
      decrementIconAnimation,
      scaleAnimation;
  AnimationController textIncrementAnimationController,
      textDecrementAnimationController,
      incrementIconAnimationController,
      decrementIconAnimationController,
      scaleAnimationController;

  @override
  void initState() {
    super.initState();

    initProperties();
    initBackgroundScaleAnimationController();
    initTextIncrementAnimationController();
    initTextDecrementAnimationController();
    initIncrementIconAnimationController();
    initDecrementIconAnimationController();
  }

  @override
  void dispose() {
    textIncrementAnimationController?.dispose();
    textDecrementAnimationController?.dispose();
    incrementIconAnimationController?.dispose();
    decrementIconAnimationController?.dispose();
    scaleAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.scale(
          scale: scaleAnimation.value,
          child: Container(
            height: rootHeight,
            width: rootWidth,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(cornerRadius),
              ),
            ),
            child: Material(
              type: MaterialType.canvas,
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: <Widget>[
                  Align(
                    alignment: style == Style.horizontal
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.topCenter,
                    child: Transform.translate(
                      offset: style == Style.horizontal
                          ? Offset(decrementIconAnimation.value, 0)
                          : Offset(
                              0,
                              decrementIconAnimation.value,
                            ),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () async {
                          handleOnTap(Direction.decrement);
                        },
                        child: Icon(
                          style == Style.horizontal
                              ? Icons.chevron_left
                              : Icons.keyboard_arrow_up,
                          color: _isDecrementIconClicked
                              ? iconColor
                              : iconColor.withOpacity(0.5),
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Transform.translate(
                      offset: style == Style.horizontal
                          ? Offset(
                              _isIncrementIconClicked
                                  ? textIncrementAnimation.value
                                  : textDecrementAnimation.value,
                              0,
                            )
                          : Offset(
                              0,
                              _isIncrementIconClicked
                                  ? textIncrementAnimation.value
                                  : textDecrementAnimation.value,
                            ),
                      child: Text(
                        _counter.toString(),
                        style: TextStyle(
                          fontSize: fontSize,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: style == Style.horizontal
                        ? AlignmentDirectional.centerEnd
                        : AlignmentDirectional.bottomCenter,
                    child: Transform.translate(
                      offset: style == Style.horizontal
                          ? Offset(incrementIconAnimation.value, 0)
                          : Offset(0, incrementIconAnimation.value),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () async {
                          handleOnTap(Direction.increment);
                        },
                        child: Icon(
                          style == Style.horizontal
                              ? Icons.chevron_right
                              : Icons.keyboard_arrow_down,
                          color: _isIncrementIconClicked
                              ? iconColor
                              : iconColor.withOpacity(0.5),
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initProperties() {
    style = widget.style ?? Style.horizontal;
    upperBound = widget.upperBound ?? 100;
    lowerBound = widget.lowerBound ?? 0;
    backgroundColor = widget.backgroundColor ?? Colors.white;
    textColor = widget.textColor ?? Color(0xffEC645B);
    iconColor = widget.iconColor ?? Color(0xffEC645B);
    textAnimationEndValue =
        widget.width == null ? 100.0 : (widget.width * 0.75);
    _counter = widget.initialCounter ?? 0;
    rootWidth = widget.width ?? ((style == Style.horizontal) ? 160 : 80);
    if (style == Style.vertical) {
      rootHeight = rootWidth * 2;
    } else {
      rootHeight = rootWidth / 2;
    }
    cornerRadius =
        style == Style.horizontal ? (rootWidth / 4) : (rootHeight / 4);
    textAnimationDuration =
        widget.animationDuration ?? Duration(milliseconds: 200);
    iconAnimationDuration = Duration(
      milliseconds: (textAnimationDuration.inMilliseconds / 2).floor(),
    );
    iconSize =
        style == Style.horizontal ? rootWidth * 0.25 : (rootHeight * 0.25);

    fontSize = style == Style.horizontal ? (rootWidth / 5) : (rootHeight / 5);
    onIncrementClicked = widget.onIncrementClicked ?? (val) {};
    onDecrementClicked = widget.onDecrementClicked ?? (val) {};
  }

  void initBackgroundScaleAnimationController() {
    scaleAnimationController = getAnimationController(
      vsync: this,
      duration: scaleDuration,
    );
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.9).animate(scaleAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              scaleAnimationController.reverse();
            }
          })
          ..addListener(() {
            setState(() {});
          });
  }

  void initTextIncrementAnimationController() {
    textIncrementAnimationController = getAnimationController(
      vsync: this,
      duration: textAnimationDuration,
    );

    textIncrementAnimation = getAnimation(
      beginValue: 0.0,
      endValue: textAnimationEndValue,
      animationController: textIncrementAnimationController,
      direction: Direction.increment,
    );
  }

  void initTextDecrementAnimationController() {
    textDecrementAnimationController = getAnimationController(
      vsync: this,
      duration: textAnimationDuration,
    );

    textDecrementAnimation = getAnimation(
      beginValue: 0,
      endValue: textAnimationEndValue,
      animationController: textDecrementAnimationController,
      direction: Direction.decrement,
    );
  }

  void initIncrementIconAnimationController() {
    incrementIconAnimationController = getAnimationController(
      vsync: this,
      duration: iconAnimationDuration,
    );

    incrementIconAnimation = getAnimation(
      beginValue: 0.0,
      endValue: textAnimationEndValue / 2,
      animationController: incrementIconAnimationController,
      direction: Direction.increment,
    );
  }

  void initDecrementIconAnimationController() {
    decrementIconAnimationController = getAnimationController(
      vsync: this,
      duration: iconAnimationDuration,
    );

    decrementIconAnimation = getAnimation(
      beginValue: 0.0,
      endValue: textAnimationEndValue / 2,
      animationController: decrementIconAnimationController,
      direction: Direction.decrement,
    );
  }

  AnimationController getAnimationController(
      {@required TickerProvider vsync, @required Duration duration}) {
    return AnimationController(
      vsync: vsync,
      duration: duration,
    );
  }

  Animation<double> getAnimation(
      {@required double beginValue,
      @required double endValue,
      @required AnimationController animationController,
      @required Direction direction}) {
    endValue = direction == Direction.increment ? endValue : (-endValue);
    return Tween<double>(begin: beginValue, end: endValue)
        .animate(animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  void handleOnTap(Direction direction) {
    if (direction == Direction.increment) {
      handleIncrementAnimation();
    } else {
      handleDecrementAnimation();
    }
  }

  void handleIncrementAnimation() async {
    _isIncrementIconClicked = true;
    scaleAnimationController.forward();
    incrementIconAnimationController.forward();
    await Future.delayed(iconAnimationDuration);
    textIncrementAnimationController.forward();
    await Future.delayed(textAnimationDuration);

    incrementCounter();
    onIncrementClicked(_counter);

    textIncrementAnimationController.reverse();
    await Future.delayed(iconAnimationDuration);
    incrementIconAnimationController.reverse();

    await Future.delayed(iconAnimationDuration);
    this.setState(() {
      _isIncrementIconClicked = false;
    });
  }

  void handleDecrementAnimation() async {
    _isDecrementIconClicked = true;
    scaleAnimationController.forward();
    decrementIconAnimationController.forward();
    await Future.delayed(iconAnimationDuration);
    textDecrementAnimationController.forward();
    await Future.delayed(textAnimationDuration);

    decrementCounter();
    onDecrementClicked(_counter);

    textDecrementAnimationController.reverse();
    await Future.delayed(iconAnimationDuration);
    decrementIconAnimationController.reverse();

    await Future.delayed(iconAnimationDuration);
    this.setState(() {
      _isDecrementIconClicked = false;
    });
  }

  void incrementCounter() {
    setState(() {
      if (_counter < upperBound) {
        _counter++;
      }
    });
  }

  void decrementCounter() {
    setState(() {
      if (_counter > lowerBound) {
        _counter--;
      }
    });
  }
}
