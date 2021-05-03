import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd/injection_container.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/presentation/widgets/trivia_controls.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<NumberTriviaBloc>(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return Text('Start searching!');
                    } else if (state is Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is Loaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.numberTrivia.number}',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            '${state.numberTrivia.text}',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else if (state is Error) {
                      return Center(child: Text('${state.message}'));
                    }

                    return Text('');
                  },
                ),
              ),
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}

