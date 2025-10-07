import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final TextStyle textStyle;
  final double fieldWidth;
  final double fieldHeight;

  const OTPInput({
    Key? key,
    this.length = 6,
    required this.onCompleted,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.fillColor = Colors.transparent,
    this.textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    this.fieldWidth = 50,
    this.fieldHeight = 50,
  }) : super(key: key);

  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _controllers = List.generate(
      widget.length,
          (index) => TextEditingController(),
    );

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < widget.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
        _updateOTPCode();
      });
    }
  }

  void _updateOTPCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
    setState(() => _otpCode = code);
  }

  void _onFieldTap(int index) {
    if (_controllers[index].text.isEmpty) {
      for (int i = 0; i < widget.length; i++) {
        if (_controllers[i].text.isEmpty) {
          _focusNodes[i].requestFocus();
          break;
        }
      }
    } else {
      _focusNodes[index].requestFocus();
    }
  }

  void _onKey(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controllers[index].text.isEmpty && index > 0) {
          _focusNodes[index - 1].requestFocus();
          _controllers[index - 1].clear();
        } else {
          _controllers[index].clear();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) => _onKey(event, index),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: widget.textStyle,
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: widget.fillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: widget.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: widget.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor,
                    width: 2,
                  ),
                ),
              ),
              onTap: () => _onFieldTap(index),
            ),
          ),
        );
      }),
    );
  }
}
