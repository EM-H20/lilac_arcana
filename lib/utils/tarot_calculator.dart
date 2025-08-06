const int _MAJOR_ARCANA_COUNT = 22;

class TarotCalculator {
  // 숫자를 한 자릿수가 될 때까지 더하는 함수 (Digital Root)
  int _reduceToSingleDigit(int n) {
    while (n > 9) {
      int sum = 0;
      while (n > 0) {
        sum += n % 10;
        n = n ~/ 10;
      }
      n = sum;
    }
    return n;
  }

  /// 생년월일을 기반으로 생애수를 계산합니다.
  /// 생애수: (년 + 월 + 일)의 합을 한 자릿수로 만든 값.
  int calculateLifeNumber(DateTime birthDate) {
    final sum = birthDate.year + birthDate.month + birthDate.day;
    return _reduceToSingleDigit(sum);
  }

  /// 생애수를 기반으로 그림자 카드 번호를 계산합니다.
  /// 그림자 카드: 22 - 생애수.
  int calculateShadowCardNumber(int lifeNumber) {
    int cardNumber = _MAJOR_ARCANA_COUNT - lifeNumber;
    // 0-21 범위로 정규화 (22는 0으로 처리)
    return cardNumber % _MAJOR_ARCANA_COUNT;
  }

  /// 선천수(음력)와 관련된 숫자들을 계산합니다.
  /// 반환값: {'lifeNumber': 선천 생애수, 'shadowCardNumber': 선천 그림자 카드 번호}
  Map<String, int> calculateInnateNumbers(DateTime lunarBirthDate) {
    final lifeNumber = calculateLifeNumber(lunarBirthDate);
    final shadowCardNumber = calculateShadowCardNumber(lifeNumber);

    return {
      'lifeNumber': lifeNumber,
      'shadowCardNumber': shadowCardNumber,
    };
  }

  /// 후천수(양력)와 관련된 숫자들을 계산합니다.
  /// 반환값: {'lifeNumber': 후천 생애수, 'shadowCardNumber': 후천 그림자 카드 번호}
  Map<String, int> calculateAcquiredNumbers(DateTime solarBirthDate) {
    final lifeNumber = calculateLifeNumber(solarBirthDate);
    final shadowCardNumber = calculateShadowCardNumber(lifeNumber);

    return {
      'lifeNumber': lifeNumber,
      'shadowCardNumber': shadowCardNumber,
    };
  }

  /// 직업수와 관련된 숫자들을 계산합니다.
  /// 반환값: {'lifeNumber': 직업 생애수, 'shadowCardNumber': 직업 그림자 카드 번호}
  Map<String, int> calculateVocationNumbers({
    required int innateLifeNumber,
    required int acquiredLifeNumber,
  }) {
    final sum = innateLifeNumber + acquiredLifeNumber;
    final lifeNumber = _reduceToSingleDigit(sum);
    final shadowCardNumber = calculateShadowCardNumber(lifeNumber);

    return {
      'lifeNumber': lifeNumber % _MAJOR_ARCANA_COUNT,
      'shadowCardNumber': shadowCardNumber,
    };
  }
}
