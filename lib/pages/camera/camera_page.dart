import 'package:auto_route/auto_route.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import 'camera_countdown.dart';
import 'camera_layout.dart';

export 'package:camerawesome/camerawesome_plugin.dart' show CaptureMode;

class CameraPageResponse {
  CameraPageResponse({required this.filePath});
  final String filePath;
}

class CameraPage extends StatelessWidget {
  const CameraPage({
    super.key,
    this.captureMode = CaptureMode.photo,
    this.maxVideoDuration,
  });

  final CaptureMode captureMode;
  final Duration? maxVideoDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.custom(
        saveConfig: captureMode == CaptureMode.photo
            ? SaveConfig.photo(
                pathBuilder: () async {
                  final extDir = await getApplicationDocumentsDirectory();
                  return '${extDir.path}/${const Uuid().v4()}.jpg';
                },
              )
            : SaveConfig.video(
                pathBuilder: () async {
                  final extDir = await getApplicationDocumentsDirectory();
                  return '${extDir.path}/${const Uuid().v4()}.mp4';
                },
              ),
        exifPreferences: ExifPreferences(
          saveGPSLocation: true,
        ),
        builder: (cameraState) {
          return cameraState.when(
            onPreparingCamera: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
            onPhotoMode: (state) => _TakePhotoUI(state),
            onVideoMode: (state) => _RecordVideoUI(state),
            onVideoRecordingMode: (state) => _RecordVideoUI(
              state,
              maxVideoDuration: maxVideoDuration,
            ),
          );
        },
      ),
    );
  }
}

class _TakePhotoUI extends StatefulWidget {
  final PhotoCameraState state;

  const _TakePhotoUI(this.state);

  @override
  State<_TakePhotoUI> createState() => _TakePhotoUIState();
}

class _TakePhotoUIState extends State<_TakePhotoUI> {
  @override
  void initState() {
    super.initState();
    widget.state.captureState$.listen((event) {
      if (event != null && event.status == MediaCaptureStatus.success) {
        context.router.pop<CameraPageResponse>(
          CameraPageResponse(filePath: event.filePath),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeCameraLayout(state: widget.state);
  }
}

class _RecordVideoUI extends StatefulWidget {
  final CameraState state;
  final Duration? maxVideoDuration;

  const _RecordVideoUI(
    this.state, {
    this.maxVideoDuration,
  });

  @override
  State<_RecordVideoUI> createState() => _RecordVideoUIState();
}

class _RecordVideoUIState extends State<_RecordVideoUI> {
  @override
  void initState() {
    super.initState();
    widget.state.captureState$.listen((event) async {
      if (event != null && event.status == MediaCaptureStatus.success) {
        final info = await VideoCompress.compressVideo(
          event.filePath,
          quality: VideoQuality.Res640x480Quality,
          deleteOrigin: false, // It's false by default
        );
        if (info?.path != null) {
          context.router.pop<CameraPageResponse>(
            CameraPageResponse(filePath: info!.path!),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AwesomeCameraLayout(state: widget.state),
        if (widget.state is VideoRecordingCameraState &&
            widget.maxVideoDuration != null)
          Positioned(
            bottom: 20,
            right: 10,
            child: CameraCountdown(
              time: widget.maxVideoDuration!,
              callback: () {
                (widget.state as VideoRecordingCameraState).stopRecording();
              },
            ),
          ),
      ],
    );
  }
}
