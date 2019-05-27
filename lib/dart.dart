import 'dart:async';

main() async {
  await for (int i in numbersDownFrom(0)) {
    print('$i bottles of beer');
  }
}

Stream numbersDownFrom(int n) async* {
  await new Future.delayed(new Duration(milliseconds: 1000));
  yield n;
  print("dsdsds");
  yield* numbersDownFrom(n + 1);
}
