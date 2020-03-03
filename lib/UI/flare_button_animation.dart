import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

final FlareControls animationControls = FlareControls();

class ButtonAnimationFlare extends StatefulWidget {
  @override
  _ButtonAnimationFlareState createState() => _ButtonAnimationFlareState();
}

class _ButtonAnimationFlareState extends State<ButtonAnimationFlare> {
  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;

  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo) {

              var localTouchPosition = (context.findRenderObject() as RenderBox)
                  .globalToLocal(tapInfo.globalPosition);

              print(localTouchPosition);

              bool topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;
              bool leftSideTouched = localTouchPosition.dx < AnimationWidth / 3;
              bool rightSideTouched =
                  localTouchPosition.dx > (AnimationWidth / 3) * 2;
              bool middleSideTouched = !leftSideTouched && !rightSideTouched;

              if (leftSideTouched && topHalfTouched) {
                _setAnimationToPlay(AnimationToPlay.CameraTapped);
              } else if (middleSideTouched && topHalfTouched) {
                _setAnimationToPlay(AnimationToPlay.PulseTapped);
              } else if (rightSideTouched && topHalfTouched) {
                _setAnimationToPlay(AnimationToPlay.ImageTapped);
              } else {
                if (isOpen) {
                  _setAnimationToPlay(AnimationToPlay.Deactivate);
                } else {
                  print('Not open');
                  _setAnimationToPlay(AnimationToPlay.Activate);
                }
                isOpen = !isOpen;
              }
        },
        child: FlareActor(
          'assets/flare/button-animation.flr',
          controller: animationControls,
          animation: _getAnimationName(_animationToPlay),
        ),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    if(animationToPlay == AnimationToPlay.Deactivate) {
      return "deactivate";
    } else if(animationToPlay == AnimationToPlay.Activate) {
      return "activate";
    } else if(animationToPlay == AnimationToPlay.CameraTapped) {
      return "camera_tapped";
    } else if(animationToPlay == AnimationToPlay.ImageTapped) {
      return "image_tapped";
    } else if(animationToPlay == AnimationToPlay.PulseTapped) {
      return "pulse_tapped";
    } else {
      return "deactivate";
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains("_tapped");

    if (isTappedAnimation &&
        _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    _lastPlayedAnimation = animation;
  }
}
