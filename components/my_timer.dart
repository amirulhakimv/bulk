import 'dart:async';
import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {
  final int initialSeconds;
  final bool isWorkoutTimer;
  final VoidCallback? onComplete;
  final bool isRunning;

  const MyTimer({
    Key? key,
    required this.initialSeconds,
    this.isWorkoutTimer = false,
    this.onComplete,
    this.isRunning = false,
  }) : super(key: key);

  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  late int _seconds;
  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.initialSeconds;
    if (widget.isWorkoutTimer) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(MyTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning != oldWidget.isRunning) {
      if (widget.isRunning) {
        _startTimer();
      } else {
        _stopTimer();
      }
    }
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.isWorkoutTimer) {
          _seconds++;
        } else {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _stopTimer();
            widget.onComplete?.call();
          }
        }
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = widget.initialSeconds;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _showTimerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: 21, // 0 to 5 minutes in 30-second intervals
            itemBuilder: (context, index) {
              int minutes = (index * 15) ~/ 60;
              int seconds = (index * 15) % 60;
              return ListTile(
                title: Text('$minutes:${seconds.toString().padLeft(2, '0')}'),
                onTap: () {
                  setState(() {
                    _seconds = minutes * 60 + seconds;
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.isWorkoutTimer ? null : _showTimerOptions,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isWorkoutTimer ? Colors.blue : (_isRunning ? Colors.red : Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatTime(_seconds),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (widget.isWorkoutTimer)
          IconButton(
            icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
            color: Colors.white,
            onPressed: () {
              setState(() {
                if (_isRunning) {
                  _stopTimer();
                } else {
                  _startTimer();
                }
              });
            },
          ),
        if (!widget.isWorkoutTimer) ...[
          IconButton(
            icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
            color: Colors.white,
            onPressed: () {
              setState(() {
                if (_isRunning) {
                  _stopTimer();
                } else {
                  _startTimer();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            color: Colors.white,
            onPressed: () {
              _resetTimer();
              widget.onComplete?.call();
            },
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}