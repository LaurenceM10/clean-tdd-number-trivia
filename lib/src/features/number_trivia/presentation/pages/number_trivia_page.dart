import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd/injection_container.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: buildBody(),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody() {
    return BlocProvider(
      create: (_) => serviceLocator<NumberTriviaBloc>(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return Text('Start searching!');
                  } else if(state is Loading) {
                    return CircularProgressIndicator();
                  }

                  return Text('');
                },
              ),
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Input a number',
            ),
            onChanged: (value) {
              inputStr = value;
            },
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                onPressed: () {},
                child: Text('Random'),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      Colors.lightBlueAccent.shade700),
                ),
                onPressed: () {},
                child: Text('Concrete'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
