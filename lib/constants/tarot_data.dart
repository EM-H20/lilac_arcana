import 'package:lilac_arcana/models/tarot_card.dart';

/// 웨이트 유니버셜 메이저 아르카나 22장
const List<TarotCard> majorArcanaCards = [
  // 0. The Fool
  TarotCard(
    number: 0,
    name: '바보 (The Fool)',
    keyword: '시작, 순수, 모험, 자유',
    interpretation: '새로운 시작과 무한한 가능성을 상징합니다. 순수한 마음과 열린 사고로 새로운 여정을 시작하세요.',
    reversedInterpretation: '무모함, 어리석음, 잘못된 판단, 위험을 간과함.',
    imagePath: 'assets/images/tarot/0.png',
  ),
  // 1. The Magician
  TarotCard(
    number: 1,
    name: '마법사 (The Magician)',
    keyword: '의지, 창조, 재능, 실행력',
    interpretation:
        '당신에게는 목표를 현실로 만들 수 있는 모든 능력이 있습니다. 강한 의지와 집중력으로 원하는 것을 성취하세요.',
    reversedInterpretation: '기만, 재능의 남용, 조작, 실력 부족.',
    imagePath: 'assets/images/tarot/1.png',
  ),
  // 2. The High Priestess
  TarotCard(
    number: 2,
    name: '여사제 (The High Priestess)',
    keyword: '직관, 지혜, 비밀, 내면의 목소리',
    interpretation: '내면의 목소리와 직관에 귀를 기울여야 할 때입니다. 숨겨진 진실과 지혜를 발견하게 될 것입니다.',
    reversedInterpretation: '숨겨진 비밀, 피상적인 지식, 직관의 무시.',
    imagePath: 'assets/images/tarot/2.png',
  ),
  // ... (나머지 19개 카드 데이터 추가)
  // 3. The Empress
  TarotCard(
    number: 3,
    name: '여제 (The Empress)',
    keyword: '풍요, 다산, 모성애, 아름다움',
    interpretation: '풍요와 창조의 에너지가 가득합니다. 사랑과 아름다움을 즐기고, 주변을 돌보는 따뜻한 마음을 나누세요.',
    reversedInterpretation: '창의력 고갈, 의존, 소유욕.',
    imagePath: 'assets/images/tarot/3.png',
  ),
  // 4. The Emperor
  TarotCard(
    number: 4,
    name: '황제 (The Emperor)',
    keyword: '권위, 안정, 리더십, 통제',
    interpretation: '안정과 질서를 통해 목표를 달성할 수 있습니다. 강력한 리더십과 책임감으로 상황을 통제하세요.',
    reversedInterpretation: '독재, 통제력 상실, 미성숙함.',
    imagePath: 'assets/images/tarot/4.png',
  ),
  // 5. The Hierophant
  TarotCard(
    number: 5,
    name: '교황 (The Hierophant)',
    keyword: '전통, 신념, 교육, 종교',
    interpretation:
        '전통적인 가치와 신념 체계 속에서 지혜를 얻을 수 있습니다. 신뢰할 수 있는 스승이나 집단의 가르침을 따르세요.',
    reversedInterpretation: '인습 타파, 편협함, 잘못된 조언.',
    imagePath: 'assets/images/tarot/5.png',
  ),
  // 6. The Lovers
  TarotCard(
    number: 6,
    name: '연인 (The Lovers)',
    keyword: '사랑, 관계, 선택, 조화',
    interpretation: '중요한 관계나 선택의 기로에 서 있습니다. 마음이 이끄는 대로 조화로운 결정을 내리세요.',
    reversedInterpretation: '관계의 불화, 잘못된 선택, 갈등.',
    imagePath: 'assets/images/tarot/6.png',
  ),
  // 7. The Chariot
  TarotCard(
    number: 7,
    name: '전차 (The Chariot)',
    keyword: '승리, 의지, 돌진, 자기 통제',
    interpretation: '강력한 의지력과 자신감으로 목표를 향해 돌진하면 승리할 수 있습니다. 상반된 힘을 잘 통제해야 합니다.',
    reversedInterpretation: '패배, 방향성 상실, 통제 불능.',
    imagePath: 'assets/images/tarot/7.png',
  ),
  // 8. Strength
  TarotCard(
    number: 8,
    name: '힘 (Strength)',
    keyword: '용기, 인내, 내면의 힘, 부드러움',
    interpretation: '진정한 힘은 내면의 용기와 부드러움에서 나옵니다. 두려움을 이겨내고 상황을 온화하게 다루세요.',
    reversedInterpretation: '나약함, 자기 의심, 억압된 분노.',
    imagePath: 'assets/images/tarot/8.png',
  ),
  // 9. The Hermit
  TarotCard(
    number: 9,
    name: '은둔자 (The Hermit)',
    keyword: '성찰, 탐구, 지혜, 고독',
    interpretation: '내면을 깊이 성찰하고 진리를 탐구할 시간입니다. 고독 속에서 자신만의 길을 밝혀줄 지혜를 찾으세요.',
    reversedInterpretation: '고립, 외로움, 지혜의 오용.',
    imagePath: 'assets/images/tarot/9.png',
  ),
  // 10. Wheel of Fortune
  TarotCard(
    number: 10,
    name: '운명의 수레바퀴 (Wheel of Fortune)',
    keyword: '운명, 변화, 전환점, 행운',
    interpretation: '삶의 전환점을 맞이했습니다. 운명의 흐름에 몸을 맡기고 긍정적인 변화를 받아들이세요.',
    reversedInterpretation: '불운, 예상치 못한 변화, 저항.',
    imagePath: 'assets/images/tarot/10.png',
  ),
  // 11. Justice
  TarotCard(
    number: 11,
    name: '정의 (Justice)',
    keyword: '공정, 균형, 진실, 책임',
    interpretation: '공정하고 균형 잡힌 판단이 필요한 시기입니다. 자신의 행동에 책임을 지고 진실을 마주하세요.',
    reversedInterpretation: '불공정, 편견, 책임 회피.',
    imagePath: 'assets/images/tarot/11.png',
  ),
  // 12. The Hanged Man
  TarotCard(
    number: 12,
    name: '매달린 남자 (The Hanged Man)',
    keyword: '희생, 인내, 새로운 관점, 정체',
    interpretation:
        '상황을 다른 관점에서 바라볼 필요가 있습니다. 잠시 멈추어 희생과 인내를 통해 새로운 깨달음을 얻으세요.',
    reversedInterpretation: '헛된 희생, 정체, 관점의 부족.',
    imagePath: 'assets/images/tarot/12.png',
  ),
  // 13. Death
  TarotCard(
    number: 13,
    name: '죽음 (Death)',
    keyword: '끝, 변화, 전환, 새로운 시작',
    interpretation: '하나의 단계가 끝나고 새로운 시작이 다가오고 있습니다. 과거를 보내고 변화를 받아들이세요.',
    reversedInterpretation: '변화에 대한 저항, 정체, 끝을 맺지 못함.',
    imagePath: 'assets/images/tarot/13.png',
  ),
  // 14. Temperance
  TarotCard(
    number: 14,
    name: '절제 (Temperance)',
    keyword: '조화, 균형, 중용, 인내',
    interpretation: '서로 다른 요소들을 조화롭게 결합하여 균형을 찾아야 합니다. 인내심을 갖고 중용의 미덕을 발휘하세요.',
    reversedInterpretation: '불균형, 과도함, 갈등.',
    imagePath: 'assets/images/tarot/14.png',
  ),
  // 15. The Devil
  TarotCard(
    number: 15,
    name: '악마 (The Devil)',
    keyword: '속박, 중독, 물질주의, 부정적 패턴',
    interpretation:
        '부정적인 생각이나 습관에 얽매여 있을 수 있습니다. 자신을 속박하는 것이 무엇인지 깨닫고 벗어나야 합니다.',
    reversedInterpretation: '속박에서의 해방, 통제력 회복.',
    imagePath: 'assets/images/tarot/15.png',
  ),
  // 16. The Tower
  TarotCard(
    number: 16,
    name: '탑 (The Tower)',
    keyword: '급작스러운 변화, 파괴, 깨달음, 재앙',
    interpretation:
        '예상치 못한 급격한 변화가 낡은 구조를 무너뜨릴 것입니다. 고통스럽지만 이를 통해 새로운 진실을 깨닫게 됩니다.',
    reversedInterpretation: '재앙의 회피, 변화에 대한 두려움.',
    imagePath: 'assets/images/tarot/16.png',
  ),
  // 17. The Star
  TarotCard(
    number: 17,
    name: '별 (The Star)',
    keyword: '희망, 영감, 치유, 긍정',
    interpretation: '어려움 끝에 희망의 빛이 보입니다. 긍정적인 마음으로 미래에 대한 믿음을 갖고 영감을 따르세요.',
    reversedInterpretation: '절망, 믿음의 상실, 비관주의.',
    imagePath: 'assets/images/tarot/17.png',
  ),
  // 18. The Moon
  TarotCard(
    number: 18,
    name: '달 (The Moon)',
    keyword: '불안, 환상, 잠재의식, 혼란',
    interpretation:
        '상황이 불분명하고 불안하게 느껴질 수 있습니다. 환상과 현실을 구분하고 잠재의식의 목소리에 귀 기울여야 합니다.',
    reversedInterpretation: '혼란의 해소, 진실의 발견.',
    imagePath: 'assets/images/tarot/18.png',
  ),
  // 19. The Sun
  TarotCard(
    number: 19,
    name: '태양 (The Sun)',
    keyword: '성공, 긍정, 활력, 행복',
    interpretation: '성공과 행복이 당신을 비추고 있습니다. 긍정적인 에너지와 자신감으로 삶의 기쁨을 만끽하세요.',
    reversedInterpretation: '일시적인 우울, 성공의 지연.',
    imagePath: 'assets/images/tarot/19.png',
  ),
  // 20. Judgement
  TarotCard(
    number: 20,
    name: '심판 (Judgement)',
    keyword: '부활, 성찰, 구원, 결정',
    interpretation: '과거를 성찰하고 중요한 결정을 내려야 할 때입니다. 새로운 차원으로 다시 태어날 기회입니다.',
    reversedInterpretation: '자기 비판, 기회를 놓침, 잘못된 판단.',
    imagePath: 'assets/images/tarot/20.png',
  ),
  // 21. The World
  TarotCard(
    number: 21,
    name: '세계 (The World)',
    keyword: '완성, 통합, 성취, 여행',
    interpretation: '하나의 주기가 성공적으로 완성되었습니다. 성취감을 느끼고 새로운 단계로 나아갈 준비를 하세요.',
    reversedInterpretation: '미완성, 정체, 목표 달성 실패.',
    imagePath: 'assets/images/tarot/21.png',
  ),
];
