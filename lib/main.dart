import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(key: Key('value')));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EGP Portfolio',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(254, 238, 227, 1),

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 1050,
                height: 40,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 10,
                        child: Text(
                          "  Equity Gals",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontFamily: 'PalmerLake',
                                  color: const Color.fromRGBO(56, 88, 78, 1)),
                        ),
                      ),
                      SizedBox(width: 1300, height: 10, child: Container()),
                      SizedBox(
                        width: 100,
                        height: 70,
                        child: Text(
                          "MENU",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontFamily: 'Impact',
                                  color: const Color.fromRGBO(242, 11, 249, 1)),
                        ),
                      ),
                      const Icon(Icons.camera_alt_outlined)
                    ]),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 900,
                      height: 100,
                      child: Text(
                        "EGP GROWTH ETF PORTFOLIO",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontFamily: 'Impact',
                            color: const Color.fromRGBO(242, 11, 249, 1)),
                      ),
                    ),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 1500,
                      height: 100,
                      child: Text(
                        "EGP's Growth ETF Portfolio has been constructed as an educational resource. The aim is to highlight the importance of diversification, provide examples of ETFs, and to help you understand asset classes and what they mean.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontFamily: 'AvenirLight',
                            color: const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 300,
                      color: const Color.fromRGBO(56, 88, 78, 1),
                      child: Text(
                        'LISTEN HERE',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontFamily: 'Impact',
                            color: const Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    )
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ASSET CLASS')),
                          DataColumn(label: Text('CODE')),
                          DataColumn(label: Text('30 DAYS GROWTH (%)')),
                          DataColumn(label: Text('GROWTH SINCE INCEPTION (%)')),
                          DataColumn(label: Text('INFO')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text('Airlie Australian Share Fund')),
                            DataCell(Text('(ASX:AASF)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text('US: IShares Core S&P 500 ETF')),
                            DataCell(Text('(ASX:IVV.AU)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Asia: IShares Asia 50 ETF')),
                            DataCell(Text('(ASX:IAA)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text('EU: Europe IShares S&P Europe 350')),
                            DataCell(Text('(ASX:IEU)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(Text('iShares Core Composite Bond ETF')),
                            DataCell(Text('(ASX:IAF)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(
                                Text('BetaShares Aus High Interest Cash ETF')),
                            DataCell(Text('(ASX:AAA)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(
                                Text('Vanguard Australian Property Secs ETF')),
                            DataCell(Text('(ASX:VAP)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(
                                Text('BetaShares Gold Bullion ETF Ccy Hedged')),
                            DataCell(Text('(ASX:QAU)')),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            ),
                            DataCell(
                              Text('Fill in Name'),
                              placeholder: true,
                            )
                          ]),
                        ],
                      ),
                    )
                  ]),
            ]),
      ),
    ));
  }
}
