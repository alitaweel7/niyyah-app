import React from 'react';
import {
  AbsoluteFill,
  Easing,
  Img,
  interpolate,
  Sequence,
  spring,
  staticFile,
  useCurrentFrame,
  useVideoConfig,
} from 'remotion';
import {VidProvider} from './ctx';
import {Phone} from './Phone';
import {GateScene, LearningScene, QiblaScene, TrackerScene} from './Walkthrough';
import {AMIRI, C, SANS, useAmiri} from './theme';
import {fontFor, isRTL, Lang} from './strings';

// ── Release copy ────────────────────────────────────────────────────────
type RL = {
  eyebrow: string;
  tagline: [string, string];
  features: [string, string, string, string];
  nowAvail: string;
  badgeSmall: string;
  badgeBig: string;
  closing: string;
};

const RELEASE: Record<Lang, RL> = {
  en: {
    eyebrow: 'INTRODUCING',
    tagline: ['Pause before', 'you scroll.'],
    features: [
      'Read an ayah before you scroll.',
      'Track your five daily prayers.',
      'Follow your journey through the Qur’an.',
      'Find the qibla, anywhere.',
    ],
    nowAvail: 'Now on the App Store',
    badgeSmall: 'Download on the',
    badgeBig: 'App Store',
    closing: 'Pause before you scroll.',
  },
  ar: {
    eyebrow: 'نقدّم لكم',
    tagline: ['توقّف قبل', 'أن تتصفّح.'],
    features: [
      'اقرأ آيةً قبل أن تتصفّح.',
      'تابِع صلواتك الخمس.',
      'تابِع رحلتك في القرآن.',
      'اعرف القبلة أينما كنت.',
    ],
    nowAvail: 'متوفّر الآن على App Store',
    badgeSmall: 'متوفّر على',
    badgeBig: 'App Store',
    closing: 'توقّف قبل أن تتصفّح.',
  },
};

const APPLE_PATH =
  'M318.7 268.7c-.2-36.7 16.4-64.4 50-84.8-18.8-26.9-47.2-41.7-84.7-44.6-35.5-2.8-74.3 20.7-88.5 20.7-15 0-49.4-19.7-76.4-19.7C63.3 141.2 4 184.8 4 273.5q0 39.3 14.4 81.2c12.8 36.7 59 126.7 107.2 125.2 25.2-.6 43-17.9 75.8-17.9 31.8 0 48.3 17.9 76.4 17.9 48.6-.7 90.4-82.5 102.6-119.3-65.2-30.7-61.7-90-61.7-91.9zm-56.6-164.2c27.3-32.4 24.8-61.9 24-72.5-24.1 1.4-52 16.4-67.9 34.9-17.5 19.8-27.8 44.3-25.6 71.9 26.1 2 49.9-11.4 69.5-34.3z';

// ── Ambient background (persists across the whole trailer) ───────────────
const Backdrop: React.FC = () => {
  const f = useCurrentFrame();
  const drift = Math.sin(f / 90);
  const drift2 = Math.cos(f / 70);
  return (
    <AbsoluteFill style={{background: 'radial-gradient(130% 90% at 50% -8%, #16382a 0%, #0b1d15 55%, #060f0a 100%)'}}>
      <div
        style={{
          position: 'absolute',
          width: 1400,
          height: 1400,
          left: 250 + drift * 60,
          top: -500 + drift2 * 40,
          background: 'radial-gradient(circle, rgba(216,184,120,0.16) 0%, rgba(216,184,120,0) 62%)',
          filter: 'blur(8px)',
        }}
      />
      <div
        style={{
          position: 'absolute',
          width: 1200,
          height: 1200,
          right: 100 - drift2 * 70,
          bottom: -460 - drift * 50,
          background: 'radial-gradient(circle, rgba(79,96,72,0.5) 0%, rgba(79,96,72,0) 60%)',
          filter: 'blur(8px)',
        }}
      />
      <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center'}}>
        <div style={{fontFamily: AMIRI, fontSize: 1500, color: '#fff', opacity: 0.022, lineHeight: 1, transform: `translateY(${drift * 14}px)`}}>
          نِيّة
        </div>
      </AbsoluteFill>
      {/* fine grain vignette */}
      <AbsoluteFill style={{boxShadow: 'inset 0 0 360px 60px rgba(0,0,0,0.55)'}} />
      {/* film grain to dither gradient banding under H.264 */}
      <AbsoluteFill
        style={{
          opacity: 0.06,
          mixBlendMode: 'overlay',
          backgroundSize: '220px 220px',
          backgroundImage:
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='220' height='220'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='2' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E\")",
        }}
      />
    </AbsoluteFill>
  );
};

// Light sweep that passes once over its children between [from,to].
const Sweep: React.FC<{from: number; to: number; children: React.ReactNode}> = ({from, to, children}) => {
  const f = useCurrentFrame();
  const p = interpolate(f, [from, to], [-140, 240], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  return (
    <div style={{position: 'relative', display: 'inline-block'}}>
      {children}
      <div
        style={{
          position: 'absolute',
          inset: 0,
          background: `linear-gradient(105deg, transparent ${p - 16}%, rgba(255,255,255,0.55) ${p}%, transparent ${p + 16}%)`,
          mixBlendMode: 'overlay',
          pointerEvents: 'none',
        }}
      />
    </div>
  );
};

const Mark: React.FC<{size: number; glow?: number}> = ({size, glow = 70}) => {
  const f = useCurrentFrame();
  const float = Math.sin(f / 26) * 6;
  return (
    <div style={{position: 'relative', width: size, height: size, transform: `translateY(${float}px)`}}>
      <div
        style={{
          position: 'absolute',
          inset: '12%',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(216,184,120,0.5) 0%, rgba(216,184,120,0) 65%)',
          filter: `blur(${glow * 0.4}px)`,
        }}
      />
      <Img src={staticFile('icon_fg.png')} style={{width: size, height: size, position: 'relative'}} />
    </div>
  );
};

// "Download on the App Store" badge (styled stand-in for Apple's official badge).
const AppleBadge: React.FC<{small: string; big: string; rtl: boolean}> = ({small, big, rtl}) => (
  <div
    style={{
      display: 'inline-flex',
      flexDirection: rtl ? 'row-reverse' : 'row',
      alignItems: 'center',
      gap: 18,
      background: '#000',
      border: '1px solid rgba(255,255,255,0.55)',
      borderRadius: 18,
      padding: '16px 30px',
    }}
  >
    <svg width="46" height="56" viewBox="0 0 384 512">
      <path d={APPLE_PATH} fill="#fff" />
    </svg>
    <div style={{textAlign: rtl ? 'right' : 'left', direction: rtl ? 'rtl' : 'ltr', fontFamily: rtl ? AMIRI : SANS}}>
      <div style={{fontSize: 24, color: '#fff', opacity: 0.92, lineHeight: 1.1}}>{small}</div>
      <div style={{fontSize: 44, fontWeight: 600, color: '#fff', letterSpacing: rtl ? 0 : -0.5, lineHeight: 1.05}}>{big}</div>
    </div>
  </div>
);

// ── Beat 1: brand reveal ────────────────────────────────────────────────
const BrandReveal: React.FC<{lang: Lang}> = ({lang}) => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const r = RELEASE[lang];
  const s = spring({frame: f - 6, fps, config: {damping: 200, mass: 1.1}});
  const markScale = interpolate(s, [0, 1], [0.6, 1]);
  const eyebrowO = interpolate(f, [44, 64], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const wordO = interpolate(f, [60, 82], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const wordY = interpolate(f, [60, 86], [26, 0], {easing: Easing.out(Easing.cubic), extrapolateRight: 'clamp'});
  const exit = interpolate(f, [150, 180], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const exitY = interpolate(f, [150, 180], [0, -28], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  return (
    <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center', opacity: exit, transform: `translateY(${exitY}px)`}}>
      <div style={{display: 'flex', flexDirection: 'column', alignItems: 'center'}}>
        <div style={{opacity: interpolate(f, [4, 24], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'}), transform: `scale(${markScale})`}}>
          <Mark size={300} />
        </div>
        <div style={{height: 26}} />
        <div style={{fontFamily: SANS, fontSize: 26, letterSpacing: lang === 'ar' ? 4 : 10, color: C.gold, opacity: eyebrowO, fontWeight: 600}}>
          {r.eyebrow}
        </div>
        <div style={{opacity: wordO, transform: `translateY(${wordY}px)`, textAlign: 'center', marginTop: 14}}>
          <Sweep from={96} to={140}>
            <div style={{fontFamily: AMIRI, fontSize: 150, color: C.goldText, lineHeight: 1}}>نِيّة</div>
          </Sweep>
          <div style={{fontFamily: SANS, fontSize: 64, fontWeight: 800, letterSpacing: 2, color: C.creamDark, marginTop: 6}}>Niyyah</div>
        </div>
      </div>
    </AbsoluteFill>
  );
};

// ── Beat 2: tagline ─────────────────────────────────────────────────────
const Tagline: React.FC<{lang: Lang}> = ({lang}) => {
  const f = useCurrentFrame();
  const r = RELEASE[lang];
  const headFont = lang === 'ar' ? AMIRI : SANS;
  const line = (txt: string, delay: number) => {
    const o = interpolate(f, [delay, delay + 18], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
    const y = interpolate(f, [delay, delay + 24], [40, 0], {easing: Easing.out(Easing.cubic), extrapolateRight: 'clamp'});
    return (
      <div style={{opacity: o, transform: `translateY(${y}px)`}}>
        {txt}
      </div>
    );
  };
  const exit = interpolate(f, [88, 110], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  return (
    <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center', opacity: exit}}>
      <Sweep from={40} to={86}>
        <div
          style={{
            fontFamily: headFont,
            fontSize: 130,
            fontWeight: 800,
            letterSpacing: lang === 'ar' ? 0 : -3,
            lineHeight: lang === 'ar' ? 1.4 : 1.04,
            color: C.creamDark,
            textAlign: 'center',
          }}
        >
          {line(r.tagline[0], 6)}
          <span style={{color: C.goldText}}>{line(r.tagline[1], 16)}</span>
        </div>
      </Sweep>
    </AbsoluteFill>
  );
};

// ── Beat 3: product shots ───────────────────────────────────────────────
const SCENES = [GateScene, TrackerScene, LearningScene, QiblaScene];
const DARK = [false, false, false, true];

const ProductShot: React.FC<{lang: Lang; idx: number; dur: number}> = ({lang, idx, dur}) => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const r = RELEASE[lang];
  const rtl = isRTL(lang);
  const Scene = SCENES[idx];
  const headFont = lang === 'ar' ? AMIRI : SANS;

  // phone slides in from the trailing side and settles
  const sIn = spring({frame: f - 2, fps, config: {damping: 200, mass: 1}});
  const side = rtl ? -1 : 1; // phone on right for LTR, left for RTL
  const phoneX = interpolate(sIn, [0, 1], [side * 140, 0]) + side * 360;
  const phoneScaleBox = 0.6; // reel box is 792×1591 → ~955px tall
  const phoneRot = interpolate(sIn, [0, 1], [side * 6, side * 2]);
  const enter = interpolate(f, [0, 14], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const exit = interpolate(f, [dur - 16, dur], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const op = Math.min(enter, exit);

  // text on the leading side
  const txtO = interpolate(f, [12, 34], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const txtY = interpolate(f, [12, 40], [34, 0], {easing: Easing.out(Easing.cubic), extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill style={{opacity: op}}>
      {/* phone */}
      <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center'}}>
        <div
          style={{
            transform: `translateX(${phoneX}px) scale(${phoneScaleBox}) rotate(${phoneRot}deg)`,
            filter: 'drop-shadow(0 60px 90px rgba(0,0,0,0.55))',
          }}
        >
          <Phone dark={DARK[idx]}>
            <Scene />
          </Phone>
        </div>
      </AbsoluteFill>

      {/* feature text on the leading side (phone on the trailing side) */}
      <AbsoluteFill
        style={{
          direction: 'ltr',
          alignItems: rtl ? 'flex-end' : 'flex-start',
          justifyContent: 'center',
          padding: rtl ? '0 130px 0 0' : '0 0 0 130px',
        }}
      >
        <div
          style={{
            opacity: txtO,
            transform: `translateY(${txtY}px)`,
            direction: rtl ? 'rtl' : 'ltr',
            textAlign: rtl ? 'right' : 'left',
            maxWidth: 640,
          }}
        >
          <div style={{direction: 'ltr', textAlign: rtl ? 'right' : 'left', fontFamily: SANS, fontSize: 30, fontWeight: 700, letterSpacing: 2, color: C.gold}}>
            {String(idx + 1).padStart(2, '0')} / 04
          </div>
          <div style={{width: 64, height: 3, background: C.gold, margin: '22px 0 26px', borderRadius: 2, marginLeft: rtl ? 'auto' : 0}} />
          <div
            style={{
              fontFamily: headFont,
              fontSize: 74,
              fontWeight: 800,
              letterSpacing: rtl ? 0 : -1.5,
              lineHeight: rtl ? 1.45 : 1.08,
              color: C.creamDark,
            }}
          >
            {r.features[idx]}
          </div>
        </div>
      </AbsoluteFill>
    </AbsoluteFill>
  );
};

// ── Beat 4: end card ────────────────────────────────────────────────────
const EndCard: React.FC<{lang: Lang}> = ({lang}) => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const r = RELEASE[lang];
  const rtl = isRTL(lang);
  const s = spring({frame: f, fps, config: {damping: 200, mass: 1.1}});
  const scale = interpolate(s, [0, 1], [0.9, 1]);
  const o = interpolate(f, [0, 18], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const availO = interpolate(f, [22, 40], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const badgeO = interpolate(f, [40, 58], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const badgeY = interpolate(f, [40, 64], [24, 0], {easing: Easing.out(Easing.cubic), extrapolateRight: 'clamp'});
  return (
    <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center', opacity: o}}>
      <div style={{display: 'flex', flexDirection: 'column', alignItems: 'center', transform: `scale(${scale})`}}>
        <Mark size={188} />
        <div style={{fontFamily: AMIRI, fontSize: 96, color: C.goldText, lineHeight: 1, marginTop: 8}}>نِيّة</div>
        <div style={{fontFamily: SANS, fontSize: 46, fontWeight: 800, letterSpacing: 2, color: C.creamDark, marginTop: 2}}>Niyyah</div>
        <div
          style={{
            opacity: availO,
            fontFamily: rtl ? AMIRI : SANS,
            fontSize: 40,
            fontWeight: 600,
            color: C.gold,
            marginTop: 30,
            letterSpacing: rtl ? 0 : 0.5,
          }}
        >
          {r.nowAvail}
        </div>
        <div style={{opacity: badgeO, transform: `translateY(${badgeY}px)`, marginTop: 28}}>
          <AppleBadge small={r.badgeSmall} big={r.badgeBig} rtl={rtl} />
        </div>
        <div style={{fontFamily: rtl ? AMIRI : SANS, fontSize: 24, color: C.mutedDark, marginTop: 30, opacity: availO}}>
          {r.closing}
        </div>
      </div>
    </AbsoluteFill>
  );
};

// ── Assembly ────────────────────────────────────────────────────────────
const INTRO = 180;
const TAG = 110;
const SHOT = 80;
const SHOTS = SHOT * 4;
const END = 150;
export const RELEASE_FRAMES = INTRO + TAG + SHOTS + END; // 760

const ReleaseBody: React.FC<{lang: Lang}> = ({lang}) => {
  useAmiri();
  return (
    <AbsoluteFill style={{backgroundColor: '#060f0a'}}>
      <Backdrop />
      <Sequence from={0} durationInFrames={INTRO} name="Brand">
        <BrandReveal lang={lang} />
      </Sequence>
      <Sequence from={INTRO} durationInFrames={TAG} name="Tagline">
        <Tagline lang={lang} />
      </Sequence>
      {[0, 1, 2, 3].map((i) => (
        <Sequence key={i} from={INTRO + TAG + i * SHOT} durationInFrames={SHOT + 12} name={`Shot ${i + 1}`}>
          <ProductShot lang={lang} idx={i} dur={SHOT + 12} />
        </Sequence>
      ))}
      <Sequence from={INTRO + TAG + SHOTS} durationInFrames={END} name="End">
        <EndCard lang={lang} />
      </Sequence>
    </AbsoluteFill>
  );
};

export const ReleaseTrailer: React.FC<{lang?: Lang}> = ({lang = 'en'}) => (
  <VidProvider lang={lang} fmt="reel">
    <ReleaseBody lang={lang} />
  </VidProvider>
);
