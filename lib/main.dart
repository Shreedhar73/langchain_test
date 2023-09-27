import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lang_chain/langchain_functions/langchain_functions.dart';
// import 'package:langchain/langchain.dart';
// import 'package:langchain_openai/langchain_openai.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;
  var summery = '';
  final cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
              child: TextField(
                controller: cont,
              ),
            ),
            Expanded(
              child: Text(
                summery,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final docs = await Methods().load('');
          final summary =
              await Methods().generateSummary(docs, prompt: cont.text);
          setState(() {
            summery = summary;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// /// The most basic building block of LangChain is calling an LLM on some input.
// Future<void> example1() async {
//   const openaiApiKey = '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';
//   final openai = OpenAI(apiKey: openaiApiKey, temperature: 0.9);
//   final result = await openai('Tell me a joke');
//   debugPrint(result);
// }

// /// The most frequent use case is to create a chat-bot.
// /// This is the most basic one.
// Future<void> example2() async {
//   final openaiApiKey = Platform.environment['OPENAI_API_KEY'];
//   final chat = ChatOpenAI(apiKey: openaiApiKey, temperature: 0);

//   while (true) {
//     stdout.write('> ');
//     final usrMsg = ChatMessage.human(stdin.readLineSync() ?? '');
//     final aiMsg = await chat([usrMsg]);
//     debugPrint(aiMsg.content);
//   }
// }
