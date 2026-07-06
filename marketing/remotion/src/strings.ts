import {AMIRI, SANS} from './theme';

export type Lang = 'en' | 'ar';
export type Fmt = 'store' | 'reel';

export const isRTL = (l: Lang) => l === 'ar';
export const fontFor = (l: Lang) => (l === 'ar' ? AMIRI : SANS);

// Reel canvas + how much to shrink the native 900×1808 phone to fit 1080×1920.
export const REEL = {w: 1080, h: 1920, phoneScale: 0.88};

// Map ASCII digits to Arabic-Indic for the Arabic locale (leaves separators alone).
const ARD = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
export const num = (l: Lang, s: string | number) =>
  l === 'ar' ? String(s).replace(/\d/g, (d) => ARD[+d as number]) : String(s);

type Scene = {head: [string, string]; sub: string};

export type Dict = {
  brand: string;
  introSub: string;
  gate: Scene & {tag: string; trans: string; ref: string; cta: string};
  unlock: Scene & {title: string; msg: string};
  tracker: Scene & {
    greeting: string;
    intent: string;
    next: string;
    hijri: string;
    today: string;
    score: string;
    prayers: [string, string, string, string, string];
    stats: [string, string][];
  };
  learn: Scene & {
    title: string;
    pctSuffix: string;
    ofQuran: string;
    stats: [string, string][];
    completed: string;
    surahs: string[];
  };
  qibla: Scene & {
    title: string;
    toKaaba: string;
    aligned: string;
    hold: string;
    dir: {n: string; s: string; e: string; w: string};
  };
  outroSub: string;
  outroCta: string;
};

const en: Dict = {
  brand: 'Niyyah',
  introSub: 'Set your niyyah before you scroll.',
  gate: {
    head: ['Pause before', 'you scroll'],
    sub: "A moment with the Qur'an first.",
    tag: 'Set your niyyah',
    trans: '“Indeed, with hardship comes ease.”',
    ref: 'Surah Ash-Sharh · 94:6',
    cta: 'Continue to Instagram',
  },
  unlock: {
    head: ['Read — then', 'continue'],
    sub: 'Reading unlocks your apps.',
    title: 'Unlocked',
    msg: 'Instagram is open for 15 minutes.',
  },
  tracker: {
    head: ['Track your five', 'daily prayers'],
    sub: 'A gentle home for worship.',
    greeting: 'Assalamu alaykum',
    intent: 'Set your intention for today.',
    next: 'Asr in 1h 12m',
    hijri: '18 Dhul-Hijjah',
    today: "Today's Prayers",
    score: '3/5',
    prayers: ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'],
    stats: [
      ['2', 'Today'],
      ['14m', 'Reading'],
      ['7', 'Streak'],
    ],
  },
  learn: {
    head: ['Your journey through', "the Qur'an"],
    sub: 'True progress through the Qur’an.',
    title: 'My Learning',
    pctSuffix: '%',
    ofQuran: "of the Qur'an",
    stats: [
      ['748', 'Ayahs read'],
      ['9', 'Surahs done'],
    ],
    completed: 'Completed Surahs',
    surahs: ['Al-Fatiha', 'Al-Ikhlas', 'Al-Falaq', 'An-Nas'],
  },
  qibla: {
    head: ['Find the Qibla,', 'wherever you are'],
    sub: 'A precise compass to the Kaaba.',
    title: 'Qibla',
    toKaaba: 'to the Kaaba',
    aligned: 'Aligned with Makkah',
    hold: 'Hold flat and turn slowly',
    dir: {n: 'N', s: 'S', e: 'E', w: 'W'},
  },
  outroSub: 'Pause before you scroll.',
  outroCta: 'On the App Store',
};

const ar: Dict = {
  brand: 'نِيّة',
  introSub: 'اضبط نيّتك قبل أن تتصفّح.',
  gate: {
    head: ['توقّف قبل', 'أن تتصفّح'],
    sub: 'لحظة مع القرآن أولًا.',
    tag: 'اضبط نيّتك',
    trans: '',
    ref: 'سورة الشرح · ٩٤:٦',
    cta: 'المتابعة إلى إنستغرام',
  },
  unlock: {
    head: ['اقرأ ثم', 'تابِع'],
    sub: 'القراءة تفتح تطبيقاتك.',
    title: 'تمّ الفتح',
    msg: 'إنستغرام متاح لمدة ١٥ دقيقة.',
  },
  tracker: {
    head: ['تابِع صلواتك', 'الخمس'],
    sub: 'بيتٌ هادئ للعبادة.',
    greeting: 'السلام عليكم',
    intent: 'اضبط نيّتك لهذا اليوم.',
    next: 'العصر بعد ساعة و١٢ دقيقة',
    hijri: '١٨ ذو الحجة',
    today: 'صلوات اليوم',
    score: '٣/٥',
    prayers: ['الفجر', 'الظهر', 'العصر', 'المغرب', 'العشاء'],
    stats: [
      ['٢', 'اليوم'],
      ['١٤ د', 'قراءة'],
      ['٧', 'تتابع'],
    ],
  },
  learn: {
    head: ['رحلتك مع', 'القرآن'],
    sub: 'تقدّمٌ حقيقي في القرآن.',
    title: 'تعلُّمي',
    pctSuffix: '٪',
    ofQuran: 'من القرآن',
    stats: [
      ['٧٤٨', 'آية مقروءة'],
      ['٩', 'سورة مكتملة'],
    ],
    completed: 'السور المكتملة',
    surahs: ['الفاتحة', 'الإخلاص', 'الفلق', 'الناس'],
  },
  qibla: {
    head: ['اعرف القبلة', 'أينما كنت'],
    sub: 'بوصلة دقيقة نحو الكعبة.',
    title: 'القبلة',
    toKaaba: 'نحو الكعبة',
    aligned: 'في اتجاه مكّة',
    hold: 'أمسكه أفقيًّا وأدِر ببطء',
    dir: {n: 'ش', s: 'ج', e: 'ق', w: 'غ'},
  },
  outroSub: 'توقّف قبل أن تتصفّح.',
  outroCta: 'متوفّر على App Store',
};

export const DICT: Record<Lang, Dict> = {en, ar};
