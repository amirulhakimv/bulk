import 'package:flutter/material.dart';

class MyAddSet extends StatefulWidget {
  final Map<String, dynamic> set;
  final Function(bool) onComplete;

  const MyAddSet({Key? key, required this.set, required this.onComplete}) : super(key: key);

  @override
  _MyAddSetState createState() => _MyAddSetState();
}

class _MyAddSetState extends State<MyAddSet> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              widget.set['set'].toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${widget.set['weight']} ${widget.set['multiplier']} ${widget.set['reps']}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.set['reps'].toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.set['weight'].toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _isCompleted = !_isCompleted;
                widget.onComplete(_isCompleted);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isCompleted ? Colors.green : Colors.grey,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}