import 'package:flutter/material.dart';
import 'package:lilac_arcana/constants/tarot_data.dart';
import 'package:lilac_arcana/models/tarot_card.dart';
import 'package:lilac_arcana/utils/tarot_calculator.dart';

class TarotProvider with ChangeNotifier {
  final TarotCalculator _calculator = TarotCalculator();

  DateTime? _solarBirthDate; // 양력 생년월일
  DateTime? _lunarBirthDate; // 음력 생년월일
  
  // 선천수 (음력)
  TarotCard? _innateLifeNumberCard; // 선천 생애수 카드
  TarotCard? _innateShadowCard; // 선천 그림자 카드
  
  // 후천수 (양력)
  TarotCard? _acquiredLifeNumberCard; // 후천 생애수 카드
  TarotCard? _acquiredShadowCard; // 후천 그림자 카드
  
  // 직업수
  TarotCard? _vocationLifeNumberCard; // 직업 생애수 카드
  TarotCard? _vocationShadowCard; // 직업 그림자 카드

  bool _isLoading = false;

  // Getters for UI
  DateTime? get solarBirthDate => _solarBirthDate;
  DateTime? get lunarBirthDate => _lunarBirthDate;
  
  // 선천수 가져오기
  TarotCard? get innateLifeNumberCard => _innateLifeNumberCard;
  TarotCard? get innateShadowCard => _innateShadowCard;
  
  // 후천수 가져오기
  TarotCard? get acquiredLifeNumberCard => _acquiredLifeNumberCard;
  TarotCard? get acquiredShadowCard => _acquiredShadowCard;
  
  // 직업수 가져오기
  TarotCard? get vocationLifeNumberCard => _vocationLifeNumberCard;
  TarotCard? get vocationShadowCard => _vocationShadowCard;
  
  bool get isLoading => _isLoading;

  // Method to calculate all numbers and update state
  Future<void> calculateAll(DateTime solarBirthDate, DateTime lunarBirthDate) async {
    _solarBirthDate = solarBirthDate;
    _lunarBirthDate = lunarBirthDate;
    _isLoading = true;
    notifyListeners();

    // Simulate a short delay for a better user experience
    await Future.delayed(const Duration(milliseconds: 500));

    // 1. 선천수(음력) 계산
    final innateResult = _calculator.calculateInnateNumbers(lunarBirthDate);
    final innateLifeNumber = innateResult['lifeNumber']!;
    final innateShadowNumber = innateResult['shadowCardNumber']!;

    // 2. 후천수(양력) 계산
    final acquiredResult = _calculator.calculateAcquiredNumbers(solarBirthDate);
    final acquiredLifeNumber = acquiredResult['lifeNumber']!;
    final acquiredShadowNumber = acquiredResult['shadowCardNumber']!;

    // 3. 직업수 계산
    final vocationResult = _calculator.calculateVocationNumbers(
      innateLifeNumber: innateLifeNumber,
      acquiredLifeNumber: acquiredLifeNumber,
    );
    final vocationLifeNumber = vocationResult['lifeNumber']!;
    final vocationShadowNumber = vocationResult['shadowCardNumber']!;

    // 4. 카드 번호에 해당하는 카드 찾기
    _innateLifeNumberCard = _findCardByNumber(innateLifeNumber);
    _innateShadowCard = _findCardByNumber(innateShadowNumber);
    
    _acquiredLifeNumberCard = _findCardByNumber(acquiredLifeNumber);
    _acquiredShadowCard = _findCardByNumber(acquiredShadowNumber);
    
    _vocationLifeNumberCard = _findCardByNumber(vocationLifeNumber);
    _vocationShadowCard = _findCardByNumber(vocationShadowNumber);

    _isLoading = false;
    notifyListeners();
  }

  TarotCard? _findCardByNumber(int number) {
    try {
      return majorArcanaCards.firstWhere((card) => card.number == number);
    } catch (e) {
      return null; // Card not found
    }
  }

  void clear() {
    _solarBirthDate = null;
    _lunarBirthDate = null;
    
    _innateLifeNumberCard = null;
    _innateShadowCard = null;
    
    _acquiredLifeNumberCard = null;
    _acquiredShadowCard = null;
    
    _vocationLifeNumberCard = null;
    _vocationShadowCard = null;
    
    _isLoading = false;
    notifyListeners();
  }
}

