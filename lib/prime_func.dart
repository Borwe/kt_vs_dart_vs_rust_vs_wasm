const Map<int, int> primesInRange = {
  100: 25,
  1000: 168,
  10000: 1229,
  100000: 9592
};

int getPrimesTill(int end) {
  List<int> gotten = List.from([2]);
  List<int> factos = List.from([], growable: true);

  for (int i = 3; i < end; i += 2) {
    var isPrime = true;

    for (final j in factos) {
      if (i == j) {
        isPrime = false;
        break;
      }
    }

    if (isPrime) {
      for (int j = 3; j < end; j += 2) {
        if (j * i <= end) {
          factos.add(j * i);
        }
      }
      gotten.add(i);
    }
  }

  return gotten.length;
}

Future<int> getPrimesCount(int end) async {
  var count = 0;
  final now = DateTime.now().millisecondsSinceEpoch;
  final finish = now + (5 * 1000);
  while (DateTime.now().millisecondsSinceEpoch < finish) {
    final result = getPrimesTill(end);
    assert(primesInRange[end] == result);
    count += 1;
  }
  return count;
}
