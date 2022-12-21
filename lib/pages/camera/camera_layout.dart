import 'package:auto_route/auto_route.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

class AwesomeCameraLayout extends StatelessWidget {
  final CameraState state;

  const AwesomeCameraLayout({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        AwesomeTopActions(state: state),
        const Spacer(),
        AwesomeBackground(
          child: Column(children: [
            const SizedBox(height: 12),
            AwesomeCameraModeSelector(state: state),
            AwesomeBottomActions(state: state),
            const SizedBox(height: 32),
          ]),
        ),
      ],
    );
  }
}

class AwesomeTopActions extends StatelessWidget {
  final CameraState state;

  const AwesomeTopActions({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const AutoLeadingButton(
          color: Colors.white,
        ),
        AwesomeFlashButton(state: state),
        AwesomeAspectRatioButton(state: state),
      ],
    );
  }
}

class AwesomeBottomActions extends StatelessWidget {
  final CameraState state;

  const AwesomeBottomActions({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 0,
            child: AwesomeCameraSwitchButton(state: state),
          ),
          AwesomeCaptureButton(
            state: state,
          ),
          const Flexible(
            flex: 0,
            child: SizedBox(width: 72, height: 72),
          ),
        ],
      ),
    );
  }
}

class AwesomeBackground extends StatelessWidget {
  final Widget child;

  const AwesomeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: child,
    );
  }
}
