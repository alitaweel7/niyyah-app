import React from 'react';
import {AbsoluteFill, Img, staticFile} from 'remotion';
import {C, darkBg, lightBg, AMIRI, SANS, useAmiri} from './theme';
import {fontFor, isRTL, Lang, num} from './strings';

// Brand mark sage, sampled from the App Store icon.
const SAGE_ICON = '#4f5d45';

// ── Shared frame ────────────────────────────────────────────────────────
type Tone = 'light' | 'dark';

const Frame: React.FC<{
  lang: Lang;
  tone: Tone;
  pad?: number;
  children: React.ReactNode;
}> = ({lang, tone, pad = 110, children}) => (
  <AbsoluteFill
    style={{
      background: tone === 'dark' ? darkBg : lightBg,
      fontFamily: fontFor(lang),
      direction: isRTL(lang) ? 'rtl' : 'ltr',
      padding: pad,
      display: 'flex',
      flexDirection: 'column',
    }}
  >
    {children}
  </AbsoluteFill>
);

const Brand: React.FC<{tone: Tone; size?: number}> = ({tone, size = 50}) => (
  <span style={{fontFamily: AMIRI, fontSize: size, color: tone === 'dark' ? C.goldText : C.sageDeep}}>
    نِيّة
  </span>
);

const Pill: React.FC<{label: string}> = ({label}) => (
  <div
    style={{
      display: 'inline-block',
      border: `2px solid ${C.gold}`,
      color: C.goldText,
      padding: '26px 56px',
      borderRadius: 44,
      fontSize: 40,
      fontWeight: 600,
    }}
  >
    {label}
  </div>
);

// ── Carousel (1080 × 1350) ──────────────────────────────────────────────
type Slide = {kind: 'cover' | 'point' | 'cta'; head: string; sub: string};

const CAROUSEL: Record<Lang, Slide[]> = {
  en: [
    {kind: 'cover', head: 'Your screen,\nbut make it intentional.', sub: 'An ayah before every scroll.'},
    {kind: 'point', head: 'You open Instagram\non autopilot.', sub: 'Again. And the hour disappears.'},
    {kind: 'point', head: 'Niyyah intercepts\nthe tap.', sub: 'Read one ayah → set your niyyah → unlocked for 15 min.'},
    {kind: 'point', head: 'Five prayers,\none streak.', sub: 'Fajr to Isha — never lose the thread.'},
    {kind: 'point', head: 'Watch the Qur’an\nadd up.', sub: '% read · ayahs counted · surahs completed.'},
    {kind: 'point', head: 'Always facing\nthe right way.', sub: 'Qibla compass to the Kaaba — and a streak that keeps you going.'},
    {kind: 'cta', head: 'Set your niyyah\nbefore you scroll.', sub: 'Now on the App Store.'},
  ],
  ar: [
    {kind: 'cover', head: 'شاشتك…\nولكن بنيّة.', sub: 'آيةٌ قبل كل تصفّح.'},
    {kind: 'point', head: 'تفتح إنستغرام\nدون أن تشعر.', sub: 'مرّةً أخرى… وتضيع الساعة.'},
    {kind: 'point', head: '«نِيّة» يعترض\nاللمسة.', sub: 'اقرأ آية ← اعقد نيّتك ← يُفتح ١٥ دقيقة.'},
    {kind: 'point', head: 'خمس صلوات…\nسلسلةٌ واحدة.', sub: 'من الفجر إلى العشاء — لا تنقطع.'},
    {kind: 'point', head: 'شاهد القرآن\nيتراكم.', sub: 'نسبة مقروءة · آياتٌ تُحصى · سُوَرٌ تُختم.'},
    {kind: 'point', head: 'وجهتك صحيحةٌ\nدائمًا.', sub: 'بوصلة القبلة نحو الكعبة — وسلسلةٌ تشدّ عزيمتك.'},
    {kind: 'cta', head: 'اعقد نيّتك\nقبل أن تتصفّح.', sub: 'متوفّر الآن على App Store.'},
  ],
};

const Lines: React.FC<{text: string; style: React.CSSProperties}> = ({text, style}) => (
  <div style={style}>
    {text.split('\n').map((l, i) => (
      <div key={i}>{l}</div>
    ))}
  </div>
);

export const CarouselSlide: React.FC<{lang: Lang; i: number}> = ({lang, i}) => {
  useAmiri();
  const ar = isRTL(lang);
  const s = CAROUSEL[lang][i - 1];
  const tone: Tone = s.kind === 'cover' || s.kind === 'cta' ? 'dark' : 'light';
  const headColor = tone === 'dark' ? C.goldText : C.sageDeep;
  const subColor = tone === 'dark' ? C.mutedDark : C.muted;
  const headFont = ar ? AMIRI : fontFor(lang);

  return (
    <Frame lang={lang} tone={tone}>
      {/* header */}
      <div style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center'}}>
        <Brand tone={tone} size={52} />
        <span style={{fontSize: 30, fontWeight: 600, letterSpacing: ar ? 0 : 2, color: subColor, direction: 'ltr'}}>
          {num(lang, i)} / {num(lang, 7)}
        </span>
      </div>

      {/* body */}
      <div style={{flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center'}}>
        {s.kind === 'cover' ? <Brand tone="dark" size={150} /> : null}
        <Lines
          text={s.head}
          style={{
            marginTop: s.kind === 'cover' ? 40 : 0,
            fontFamily: headFont,
            fontSize: ar ? 92 : 84,
            fontWeight: 800,
            letterSpacing: ar ? 0 : -1.5,
            lineHeight: ar ? 1.4 : 1.06,
            color: headColor,
          }}
        />
        <div style={{marginTop: 34, fontSize: 42, fontWeight: 500, lineHeight: 1.4, color: subColor, maxWidth: 760}}>
          {s.sub}
        </div>
        {s.kind === 'cta' ? (
          <div style={{marginTop: 56}}>
            <Pill label={lang === 'ar' ? 'متوفّر على App Store' : 'On the App Store'} />
          </div>
        ) : null}
      </div>

      {/* footer */}
      <div style={{fontSize: 32, fontWeight: 600, color: tone === 'dark' ? C.gold : C.tag}}>
        {s.kind === 'cta' ? (ar ? 'نِيّة — توقّف قبل أن تتصفّح' : 'Niyyah — pause before you scroll') : ar ? 'اسحب ←' : 'Swipe →'}
      </div>
    </Frame>
  );
};

// ── Story (1080 × 1920) ─────────────────────────────────────────────────
type Story = {tone: Tone; big?: string; head: string; sub?: string; cta?: boolean};

const STORIES: Record<Lang, Story[]> = {
  en: [
    {tone: 'light', big: '96×', head: 'a day, you unlock your phone.', sub: 'Most of it on autopilot.'},
    {tone: 'light', head: 'Niyyah adds one pause\nbefore the scroll.', sub: 'An ayah. An intention. Then 15 mindful minutes.'},
    {tone: 'dark', head: 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', sub: 'Read it. Set your niyyah. Continue.'},
    {tone: 'dark', head: 'Pause before\nyou scroll.', cta: true},
  ],
  ar: [
    {tone: 'light', big: '٩٦×', head: 'مرّة تفتح فيها هاتفك يوميًّا.', sub: 'وأكثرها دون وعي.'},
    {tone: 'light', head: 'يضيف «نِيّة» وقفةً\nواحدة قبل التصفّح.', sub: 'آيةٌ، ونيّةٌ، ثم خمس عشرة دقيقةً بوعي.'},
    {tone: 'dark', head: 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', sub: 'اقرأها، اعقد نيّتك، ثم تابِع.'},
    {tone: 'dark', head: 'توقّف قبل\nأن تتصفّح.', cta: true},
  ],
};

export const StoryFrame: React.FC<{lang: Lang; i: number}> = ({lang, i}) => {
  useAmiri();
  const ar = isRTL(lang);
  const st = STORIES[lang][i - 1];
  const isAyah = st.tone === 'dark' && !st.cta;
  const headColor = st.tone === 'dark' ? C.goldText : C.sageDeep;
  const subColor = st.tone === 'dark' ? C.mutedDark : C.muted;
  const headFont = ar || isAyah ? AMIRI : fontFor(lang);

  return (
    <Frame lang={lang} tone={st.tone} pad={120}>
      {/* top brand, kept clear of IG story chrome */}
      <div style={{marginTop: 70, textAlign: 'center'}}>
        <Brand tone={st.tone} size={64} />
      </div>

      {/* centered message band (safe from top/bottom UI) */}
      <div style={{flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center'}}>
        {st.big ? (
          <div style={{fontSize: 300, fontWeight: 800, lineHeight: 1, color: C.sage, direction: 'ltr'}}>{st.big}</div>
        ) : null}
        <Lines
          text={st.head}
          style={{
            marginTop: st.big ? 24 : 0,
            fontFamily: headFont,
            fontSize: isAyah ? 110 : ar ? 96 : st.big ? 60 : 92,
            fontWeight: 800,
            letterSpacing: ar || isAyah ? 0 : -1.5,
            lineHeight: ar || isAyah ? 1.5 : 1.08,
            color: headColor,
            direction: isAyah ? 'rtl' : undefined,
            maxWidth: 840,
          }}
        />
        {st.sub ? (
          <div style={{marginTop: 40, fontSize: 44, fontWeight: 500, lineHeight: 1.4, color: subColor, maxWidth: 760}}>
            {st.sub}
          </div>
        ) : null}
        {st.cta ? (
          <div style={{marginTop: 64, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 26}}>
            <Pill label={lang === 'ar' ? 'متوفّر على App Store' : 'On the App Store'} />
            <span style={{fontSize: 34, color: C.gold, fontWeight: 600}}>{ar ? 'اضغط للتحميل ↓' : 'Tap to download ↓'}</span>
          </div>
        ) : null}
      </div>

      <div style={{height: 180}} />
    </Frame>
  );
};

// ── Facebook profile picture (1080 × 1080, displays as a circle) ─────────
export const Profile: React.FC = () => (
  <AbsoluteFill
    style={{
      overflow: 'hidden',
      background: `radial-gradient(circle at 50% 44%, #58674d 0%, ${SAGE_ICON} 62%, #45513c 100%)`,
      alignItems: 'center',
      justifyContent: 'center',
    }}
  >
    <Img src={staticFile('icon_fg.png')} style={{width: 1180, height: 1180}} />
  </AbsoluteFill>
);

// ── Facebook cover photo (1640 × 624) ───────────────────────────────────
// Keep all text within the central ~1080px-wide safe zone (mobile crops the sides).
export const FBCover: React.FC = () => {
  useAmiri();
  return (
    <AbsoluteFill style={{overflow: 'hidden', background: 'linear-gradient(115deg, #57664c 0%, #44523d 100%)', fontFamily: SANS}}>
      {/* faint decorative wordmark, bleeds off the crop-safe edge */}
      <div style={{position: 'absolute', right: -70, top: -150, fontFamily: AMIRI, fontSize: 640, color: '#FBFBF9', opacity: 0.05, lineHeight: 1}}>
        نِيّة
      </div>

      <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center'}}>
        <div style={{display: 'flex', flexDirection: 'column', alignItems: 'center', transform: 'translateY(-8px)'}}>
          {/* lockup */}
          <div style={{display: 'flex', alignItems: 'center', gap: 6}}>
            <Img src={staticFile('icon_fg.png')} style={{width: 300, height: 300, marginRight: -36}} />
            <div style={{textAlign: 'left'}}>
              <div style={{fontFamily: AMIRI, fontSize: 116, color: C.creamDark, lineHeight: 1}}>نِيّة</div>
              <div style={{fontSize: 50, fontWeight: 800, letterSpacing: 6, color: C.creamDark, marginTop: 2}}>NIYYAH</div>
            </div>
          </div>

          <div style={{width: 120, height: 2, background: C.gold, opacity: 0.85, margin: '26px 0 22px'}} />

          <div style={{fontSize: 36, fontWeight: 500, color: '#C8D0B9'}}>Pause before you scroll.</div>
          <div style={{fontFamily: AMIRI, fontSize: 40, color: '#C8D0B9', marginTop: 4}}>توقّف قبل أن تتصفّح.</div>
          <div style={{fontSize: 27, color: C.goldText, marginTop: 22, letterSpacing: 0.5}}>
            Now on the App Store · متوفّر الآن على App Store
          </div>
        </div>
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
