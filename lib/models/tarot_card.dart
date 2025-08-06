class TarotCard {
  final int number;
  final String name;
  final String keyword;
  final String interpretation;
  final String reversedInterpretation;
  final String imagePath; // 이미지 경로

  const TarotCard({
    required this.number,
    required this.name,
    required this.keyword,
    required this.interpretation,
    required this.reversedInterpretation,
    required this.imagePath,
  });
}
