import 'package:flutter/material.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}



class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Input a number',
                hintStyle: TextStyle(color: Colors.grey.shade500)),
            onChanged: (value) {
              setState(() {
                inputStr = value;
              });
            },
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade50),
                ),
                onPressed: _dispatchRandom,
                child: Text(
                  'Random',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade50),
                ),
                onPressed: inputStr.isNotEmpty ? _dispatchConcrete : null,
                child: Text(
                  'Concrete',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _dispatchConcrete() {
    // Clearing the TextField to prepare it for the next inputted number
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(number: inputStr));
  }

  void _dispatchRandom() {
    // Clearing the TextField to prepare it for the next inputted number
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandom());
  }
}
