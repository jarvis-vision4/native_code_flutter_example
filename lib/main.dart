import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:native_code_flutter_example/native_class/native_communication.dart';

void main() {
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
        // the application has a purple toolbar. Then, without quitting the app,
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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: "Native Communication",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double num1 = 0.0;
  double num2 = 0.0;
  double theSum = 0.0;

  String fullName = "";
  void calculateSum()async{
    NativeCommunication nativeCommunication=NativeCommunication();
    double sum=await nativeCommunication.getSumFromNative(num1, num2);
    String getFullName = await nativeCommunication.getStringFromNative("Thurein","Htet");
    fullName=getFullName;
    log('Sum from native: $sum');
    setState(() {
      theSum=sum;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Number 1'),
                onChanged: (value) {
                  num1 = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Number 1'),
                onChanged: (value) {
                  num2 = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'sum: $theSum' + "\n" + fullName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: calculateSum,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
