import 'package:android_kt_vs_dart_vs_wasm/prime_func.dart';
import 'package:android_kt_vs_dart_vs_wasm/rusted.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'godart.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  static const platform = MethodChannel("com.borwe.primes");
  final dropDownValues = ['100', '1000', '10000', '100000'];
  String? selectedDropDown;
  Future<int>? dartFuture;
  Future<int>? kotlinFuture;
  Future<int>? rustFuture;
  Future<int>? goFuture;

  void resetState(){

    setState(() {
      dartFuture = null ;
      kotlinFuture= null;
      rustFuture = null;
      goFuture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropDowns = [];

    dropDownValues.asMap().forEach((i, v) => dropDowns.add(DropdownMenuItem(
          value: dropDownValues[i],
          child: Text(dropDownValues[i]),
        )));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please choose range to get primes from:',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            DropdownButton(
              value: selectedDropDown,
              items: dropDowns,
              onChanged: (t) => {
                setState(() {
                  selectedDropDown = t;
                }),
                resetState()
              },
              hint: const Text('Select item'),
            ),
            LanguageSection(
              language: "Dart",
              selectedDropDown: selectedDropDown,
              langFuture: dartFuture,
            ),
            ElevatedButton(
              child: const Text("Dart performance test"),
              onPressed: () async {
                if (selectedDropDown != null) {
                  setState(() {
                    dartFuture = compute(
                        getPrimesCount, int.parse(selectedDropDown as String));
                  });
                }
              },
            ),
            LanguageSection(
              language: "Kotlin",
              selectedDropDown: selectedDropDown,
              langFuture: kotlinFuture,
            ),
            ElevatedButton(
              child: const Text("Kotlin performance test"),
              onPressed: () async {
                if (selectedDropDown != null) {
                  setState(() {
                    ktFunc(int end) {
                      return platform.invokeMethod<int>(
                          "getPrimesCount", {"end": end}).then((v) => v ?? -1);
                    }
                    kotlinFuture =
                        ktFunc(int.parse(selectedDropDown as String));
                  });
                }
              },
            ),
            LanguageSection(
              language: "Rust",
              selectedDropDown: selectedDropDown,
              langFuture: rustFuture,
            ),
            ElevatedButton(
              child: const Text("Rust performance test"),
              onPressed: () async {
                if (selectedDropDown != null) {
                  setState(() {
                    rustFuture = compute(
                        rustPrimes, int.parse(selectedDropDown as String));
                  });
                }
              },
            ),


            LanguageSection(language: 'Golang', selectedDropDown: selectedDropDown, langFuture: goFuture),
            ElevatedButton(onPressed: () async{
              if(selectedDropDown !=null){

                setState(() {
                  goFuture = compute(goPrimes, int.parse(selectedDropDown!));
                });

              }
            }, child: const Text("Golang Performance Test"))
          ],
        ),
      ),
    );
  }
}

class LanguageSection extends StatelessWidget {
  final String language;
  final String? selectedDropDown;
  final Future<int>? langFuture;

  const LanguageSection(
      {super.key,
      required this.language,
      required this.selectedDropDown,
      required this.langFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: langFuture,
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
            return Text("Press button bellow to start $language times");
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const CircularProgressIndicator();
          case ConnectionState.done:
            return Text(
                "$language did ${snap.data} of times that for primes 0-$selectedDropDown");
          default:
            return const Text("ERROR occured");
        }
      },
    );
  }
}
