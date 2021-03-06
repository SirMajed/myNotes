import 'dart:math';

class AvatarGenerator {
  // https://avataaars.io/?accessoriesType=Blank&avatarStyle=Circle&clotheColor=Black&clotheType=GraphicShirt&eyeType=Close&eyebrowType=Default&facialHairColor=BlondeGolden&facialHairType=Blank&hairColor=PastelPink&mouthType=Sad&skinColor=Tanned&topType=Hat
  static String top() {
    var top = [
      'NoHair',
      'Eyepatch',
      'Hat',
      'Turban',
      'WinterHat1',
      'WinterHat2',
      'WinterHat3',
      'WinterHat4',
      'LongHairCurly',
      'LongHairDreads',
      'LongHairShavedSides',
      'ShortHairDreads01',
      'ShortHairDreads02',
      'ShortHairFrizzle',
      'ShortHairSortCurly',
      'ShortHairShortFlat',
      'ShortHairShortWaved',
      'ShortHairTheCaesarSidePart'
    ];
    final _random = new Random();
    var element = top[_random.nextInt(top.length)];
    return element;
  }

  static String accessories() {
    var acc = [
      'Blank',
      'Kurt',
      'Prescription01',
      'Prescription02',
      'Round',
      'Sunglasses',
      'Wayfarers',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String hairColor() {
    var acc = [
      'Platinum',
      'Auburn',
      'Black',
      'Blonde',
      'BlondeGolden',
      'Brown',
      'BrownDark',
      'PastelPink',
      'Platinum',
      'Red',
      'SilverGray',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String facialHair() {
    var acc = [
      'Blank',
      'BeardLight',
      'MoustacheFancy',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String facialHairColor() {
    String acc = 'black';
    return acc;
  }

  static String clothes() {
    var acc = [
      'BlazerShirt',
      'CollarSweater',
      'GraphicShirt',
      'Hoodie',
      'ShirtCrewNeck',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String clothesColor() {
    var acc = [
      'Black',
      'Blue01',
      'Heather',
      'PastelGreen',
      'PastelOrange',
      'PastelRed',
      'PastelYellow',
      'Pink',
      'Red',
      'White',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String eyeType() {
    var acc = [
      'Close',
      'Cry',
      'Default',
      'Dizzy',
      'EyeRoll',
      'Happy',
      'Hearts',
      'Side',
      'Squint',
      'Suprised',
      'Wink',
      'WinkWacky',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String eyebrowType() {
    var acc = [
      'Angry',
      'AngryNatural',
      'Default',
      'DefaultNormal',
      'FlatNatural',
      'RaisedExcited',
      'SadConcerned',
      'UnibrowNatural',
      'UpDown',
      'UpDownNatural',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];

    return element;
  }

  static String mouth() {
    var acc = [
      'Concerned',
      'Default',
      'Disbelief',
      'Eating',
      'Grimace',
      'Sad',
      'ScreamOpen',
      'Serious',
      'Smile',
      'Tongue',
      'Twinkle',
      'Vomit',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];
    return element;
  }

  static String femaleTop() {
    var acc = [
      'LongHairBigHair',
      'LongHairBob',
      'LongHairBun',
      'LongHairCurly',
      'LongHairCurvy',
      'LongHairDreads',
      'LongHairFrida',
      'LongHairNotTooLong',
      'LongHairStraight',
      'LongHairStraight2',
    ];
    final _random = new Random();
    var element = acc[_random.nextInt(acc.length)];
    return element;
  }

  static String generateMaleAvatar() {
    return 'https://avataaars.io/?accessoriesType=${accessories()}&avatarStyle=Circle&clotheColor=${clothesColor()}&clotheType=${clothes()}&eyeType=${eyeType()}&eyebrowType=${eyebrowType()}&facialHairColor=${facialHairColor()}&facialHairType=${facialHair()}&hairColor=${hairColor()}&mouthType=${mouth()}&skinColor=Light&topType=${top()}';
  }

  static String generateFemaleAvatar() {
    return 'https://avataaars.io/?accessoriesType=${accessories()}&avatarStyle=Circle&clotheColor=${clothesColor()}&clotheType=${clothes()}&eyeType=${eyeType()}&eyebrowType=${eyebrowType()}&hairColor=${hairColor()}&mouthType=${mouth()}&skinColor=Light&topType=${femaleTop()}';
  }
}
