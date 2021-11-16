import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/counter_block_action.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterBloc bloc = CounterBloc();
    return MultiProvider(
        providers: [
          Provider<Stream<int>>(create: (context) => bloc.output),
          Provider<Sink<CounterAction>>(
            create: (context) => bloc.input,
          )
        ],
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              floatingActionButton: CounterButtons(),
              body: CounterDisplay(),
            ),
          );
        });
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: Provider.of<Stream<int>>(context),
        initialData: 0,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null)
            return Text(snapshot.data.toString());
          else
            return Text("Not ready yet");
        },
      ),
    );
  }
}

class CounterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              var sink =
                  Provider.of<Sink<CounterAction>>(context, listen: false);
              sink.add(CounterAction.Increment);
            },
            child: Text("+")),
        ElevatedButton(
            onPressed: () {
              var sink =
                  Provider.of<Sink<CounterAction>>(context, listen: false);
              sink.add(CounterAction.Decrement);
            },
            child: Text("-")),
      ],
    );
  }
}
