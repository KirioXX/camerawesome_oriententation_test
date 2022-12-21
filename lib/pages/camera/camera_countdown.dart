import 'dart:async';

import 'package:flutter/material.dart';

class CameraCountdown extends StatefulWidget {
  const CameraCountdown({
    Key? key,

    /// Sets the inital countimer time
    required this.time,

    /// Triggered when the countown hits 0
    required this.callback,
  }) : super(key: key);

  final Duration time;
  final Function callback;

  @override
  State<CameraCountdown> createState() => _CameraCountdownState();
}

class _CameraCountdownState extends State<CameraCountdown> {
  late Duration _currentTime;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.time;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newTime = _currentTime - const Duration(seconds: 1);
      if (newTime == Duration.zero) {
        widget.callback();
        _timer.cancel();
      } else {
        setState(() {
          _currentTime = newTime;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_currentTime.inSeconds}s',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30.0,
      ),
    );
  }
}
