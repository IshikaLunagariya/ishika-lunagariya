import 'package:flutter/material.dart';

/*class KeyboardDemo extends StatefulWidget {
  KeyboardDemo({key, this.onSubmit});
  Function? onSubmit;
  @override
  _KeyboardDemoState createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  final TextEditingController _controller = TextEditingController();
  bool _readOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 50),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            style: const TextStyle(fontSize: 24),
            autofocus: true,
            showCursor: true,
            readOnly: _readOnly,
          ),
          IconButton(
            icon: const Icon(Icons.keyboard),
            onPressed: () {
              setState(() {
                _readOnly = !_readOnly;
              });
            },
          ),
          const Spacer(),
          CustomKeyboard(onTextInput: (myText) {
            _insertText(myText);
          }, onBackspace: () {
            _backspace();
          }, onSubmit: () {
            widget.onSubmit;
          }),
        ],
      ),
    );
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}*/

class CustomKeyboard extends StatelessWidget {
  CustomKeyboard({
    Key? key,
    this.onTextInput,
    this.onBackspace,
    this.onSubmit,
  }) : super(key: key);

  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final void Function()? onSubmit;

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _backspaceHandler() => onBackspace?.call();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      // color: const Color(0xffEBF0EA),
      color: const Color(0xff1D1A1A),
      child: Column(
        children: [
          buildRowOne(),
          buildRowTwo(),
          buildRowThree(),
          buildRowFour(onSubmit: onSubmit),
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '1',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '3',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '4',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '5',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '6',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '7',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '8',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '9',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowFour({void Function()? onSubmit}) {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '✔️',
            onSubmit: onSubmit,
          ),
          TextKey(
            text: '0',
            onTextInput: _textInputHandler,
          ),
          BackspaceKey(
            onBackspace: _backspaceHandler,
          ),
        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  TextKey({
    Key? key,
    @required this.text,
    this.onTextInput,
    this.flex = 1,
    this.onSubmit,
  }) : super(key: key);

  final String? text;
  final ValueSetter<String>? onTextInput;
  final int? flex;
  void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 0,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          // color: const Color(0xffEBF0EA),
          color: const Color(0xff1D1A1A),
          child: InkWell(
            onTap: onSubmit ??
                () {
                  onTextInput?.call(text ?? "");
                },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  // color: /*Color(0xffFCFDF8)*/ Colors.grey.withOpacity(0.5),
                  color: Color(0xff4B4442),
                ),
                child: Center(
                    child: Text(
                  text ?? "",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onBackspace;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 0,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          // color: const Color(0xffEBF0EA),
          color: const Color(0xff1D1A1A),
          child: InkWell(
            onTap: () {
              onBackspace?.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  // color: /*Color(0xffFCFDF8)*/ Colors.grey.withOpacity(0.5),
                  color: Color(0xff4B4442),
                ),
                child: const Center(
                  child: Icon(
                    Icons.backspace,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
