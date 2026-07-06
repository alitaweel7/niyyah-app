import React from 'react';
import {
  AbsoluteFill,
  interpolate,
  Sequence,
  spring,
  useCurrentFrame,
  useVideoConfig,
} from 'remotion';
import {useVid, VidProvider} from './ctx';
import {Fade, Headline, Phone, Stage} from './Phone';
import {AMIRI, C, useAmiri} from './theme';
import {Fmt, Lang, num} from './strings';

const Check: React.FC<{size: number; color?: string; opacity?: number}> = ({
  size,
  color = '#fff',
  opacity = 1,
}) => (
  <svg width={size} height={size} viewBox="0 0 24 24" style={{opacity}}>
    <path
      d="M5 12.5l4.2 4.2L19 7"
      stroke={color}
      strokeWidth={2.6}
      fill="none"
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </svg>
);

// ── Intro ──────────────────────────────────────────────────────────────
const Intro: React.FC = () => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const {t} = useVid();
  const s = spring({frame: f, fps, config: {damping: 13}});
  return (
    <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center'}}>
      <div style={{transform: `scale(${0.82 + 0.18 * s})`, textAlign: 'center'}}>
        <div style={{fontFamily: AMIRI, fontSize: 210, color: C.sageDeep, lineHeight: 1}}>نِيّة</div>
        <div style={{fontSize: 92, fontWeight: 800, color: C.sageDeep, letterSpacing: -1, marginTop: 18}}>
          Niyyah
        </div>
        <div style={{fontSize: 44, color: C.muted, marginTop: 26}}>{t.introSub}</div>
      </div>
    </AbsoluteFill>
  );
};

// ── Gate / reading ─────────────────────────────────────────────────────
export const GateScene: React.FC = () => {
  const f = useCurrentFrame();
  const {t, lang, rtl, font} = useVid();
  const secs = Math.max(0, 133 - Math.floor(f / 30));
  const mm = Math.floor(secs / 60);
  const ss = secs % 60;
  const progress = secs / 133;
  const ay = interpolate(f, [6, 32], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const r = 112;
  const circ = 2 * Math.PI * r;
  return (
    <div style={{flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '118px 60px 0'}}>
      <div
        style={{
          fontSize: 26,
          fontWeight: 600,
          letterSpacing: rtl ? 0 : 3,
          textTransform: rtl ? 'none' : 'uppercase',
          color: C.tag,
        }}
      >
        {t.gate.tag}
      </div>
      <div
        style={{
          opacity: ay,
          marginTop: 64,
          fontFamily: AMIRI,
          fontSize: 124,
          color: C.ink,
          direction: 'rtl',
          textAlign: 'center',
          lineHeight: 1.85,
        }}
      >
        إِنَّ مَعَ الْعُسْرِ يُسْرًا
      </div>
      {t.gate.trans ? (
        <div style={{opacity: ay, marginTop: 44, fontSize: 42, color: '#5b6157', textAlign: 'center', maxWidth: 680}}>
          {t.gate.trans}
        </div>
      ) : null}
      <div style={{opacity: ay, marginTop: 26, fontSize: 30, fontStyle: 'italic', color: C.faint}}>
        {t.gate.ref}
      </div>
      <div style={{flex: 1}} />
      <svg width="264" height="264" style={{marginBottom: 34}}>
        <circle cx="132" cy="132" r={r} stroke={C.sageLine} strokeWidth="14" fill="none" />
        <circle
          cx="132"
          cy="132"
          r={r}
          stroke={C.sage}
          strokeWidth="14"
          fill="none"
          strokeLinecap="round"
          strokeDasharray={circ}
          strokeDashoffset={circ * (1 - progress)}
          transform="rotate(-90 132 132)"
        />
        <text x="132" y="150" textAnchor="middle" fontSize="58" fontWeight="700" fill={C.sageDeep} fontFamily={font}>
          {num(lang, mm)}:{num(lang, ss.toString().padStart(2, '0'))}
        </text>
      </svg>
      <div
        style={{
          width: '100%',
          marginBottom: 68,
          background: C.sageDeep,
          color: '#fff',
          textAlign: 'center',
          padding: 44,
          borderRadius: 36,
          fontSize: 44,
          fontWeight: 600,
        }}
      >
        {t.gate.cta}
      </div>
    </div>
  );
};

// ── Unlock ─────────────────────────────────────────────────────────────
export const UnlockScene: React.FC = () => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const {t} = useVid();
  const s = spring({frame: f - 6, fps, config: {damping: 12}});
  return (
    <div
      style={{
        flex: 1,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '0 80px',
      }}
    >
      <div
        style={{
          transform: `scale(${s})`,
          width: 300,
          height: 300,
          borderRadius: '50%',
          background: C.sage,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        <Check size={168} />
      </div>
      <div style={{marginTop: 70, fontSize: 64, fontWeight: 800, color: C.sageDeep}}>{t.unlock.title}</div>
      <div style={{marginTop: 18, fontSize: 42, color: C.muted, textAlign: 'center'}}>{t.unlock.msg}</div>
    </div>
  );
};

// ── Prayer tracker ─────────────────────────────────────────────────────
export const TrackerScene: React.FC = () => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const {t} = useVid();
  const filled = [0, 1, 2];
  return (
    <div style={{flex: 1, padding: '6px 50px 0'}}>
      <div style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '22px 8px'}}>
        <span style={{fontFamily: AMIRI, fontSize: 54, color: C.sageDeep}}>{t.brand}</span>
        <span style={{fontSize: 34, color: C.tag, letterSpacing: 6}}>◧ ▷</span>
      </div>
      <div style={{fontFamily: AMIRI, fontSize: 60, color: C.sageDeep, marginTop: 8}}>{t.tracker.greeting}</div>
      <div style={{fontSize: 36, color: C.muted, marginTop: 6}}>{t.tracker.intent}</div>
      <div
        style={{
          marginTop: 38,
          background: C.sageBg,
          borderRadius: 30,
          padding: '30px 38px',
          display: 'flex',
          justifyContent: 'space-between',
          fontSize: 36,
          color: C.sage,
          fontWeight: 600,
        }}
      >
        <span>{t.tracker.next}</span>
        <span style={{color: C.faint, fontWeight: 500}}>{t.tracker.hijri}</span>
      </div>
      <div
        style={{
          marginTop: 32,
          background: '#fff',
          border: `2px solid ${C.sageLine}`,
          borderRadius: 40,
          padding: '40px 38px',
        }}
      >
        <div style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center'}}>
          <span style={{fontSize: 40, fontWeight: 600, color: C.ink}}>{t.tracker.today}</span>
          <span style={{fontSize: 40, fontWeight: 800, color: C.sage}}>{t.tracker.score}</span>
        </div>
        <div style={{display: 'flex', justifyContent: 'space-between', marginTop: 42}}>
          {t.tracker.prayers.map((p, i) => {
            const on = filled.includes(i);
            const s = on ? spring({frame: f - 18 - i * 12, fps, config: {damping: 12}}) : 0;
            return (
              <div key={p} style={{display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 18}}>
                <div
                  style={{
                    width: 98,
                    height: 98,
                    borderRadius: '50%',
                    border: on ? 'none' : '4px solid #cdd4c0',
                    background: on ? C.sage : 'transparent',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    transform: on ? `scale(${0.55 + 0.45 * s})` : 'none',
                  }}
                >
                  {on ? <Check size={52} opacity={s} /> : null}
                </div>
                <span style={{fontSize: 28, color: on ? C.sage : C.muted, fontWeight: on ? 600 : 400}}>{p}</span>
              </div>
            );
          })}
        </div>
      </div>
      <div style={{display: 'flex', gap: 26, marginTop: 32}}>
        {t.tracker.stats.map(([n, l]) => (
          <div
            key={l}
            style={{
              flex: 1,
              background: '#fff',
              border: `2px solid ${C.sageLine}`,
              borderRadius: 34,
              padding: '34px 0',
              textAlign: 'center',
            }}
          >
            <div style={{fontSize: 58, fontWeight: 800, color: C.sageDeep}}>{n}</div>
            <div style={{fontSize: 28, color: C.muted, marginTop: 8}}>{l}</div>
          </div>
        ))}
      </div>
    </div>
  );
};

// ── Learning ───────────────────────────────────────────────────────────
export const LearningScene: React.FC = () => {
  const f = useCurrentFrame();
  const {t, lang, font} = useVid();
  const pct = interpolate(f, [10, 74], [0, 12], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const r = 230;
  const circ = 2 * Math.PI * r;
  return (
    <div style={{flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '28px 60px 0'}}>
      <div style={{alignSelf: 'flex-start', fontSize: 44, fontWeight: 700, color: C.sageDeep}}>{t.learn.title}</div>
      <svg width="560" height="560" style={{marginTop: 46}}>
        <circle cx="280" cy="280" r={r} stroke={C.sageLine} strokeWidth="34" fill="none" />
        <circle
          cx="280"
          cy="280"
          r={r}
          stroke={C.sage}
          strokeWidth="34"
          fill="none"
          strokeLinecap="round"
          strokeDasharray={circ}
          strokeDashoffset={circ * (1 - pct / 100)}
          transform="rotate(-90 280 280)"
        />
        <text x="280" y="282" textAnchor="middle" fontSize="132" fontWeight="800" fill={C.sageDeep} fontFamily={font}>
          {num(lang, Math.round(pct))}
          {t.learn.pctSuffix}
        </text>
        <text x="280" y="352" textAnchor="middle" fontSize="40" fill={C.muted} fontFamily={font}>
          {t.learn.ofQuran}
        </text>
      </svg>
      <div style={{display: 'flex', gap: 30, marginTop: 58, width: '100%'}}>
        {t.learn.stats.map(([n, l]) => (
          <div
            key={l}
            style={{
              flex: 1,
              background: '#fff',
              border: `2px solid ${C.sageLine}`,
              borderRadius: 36,
              padding: '40px 0',
              textAlign: 'center',
            }}
          >
            <div style={{fontSize: 66, fontWeight: 800, color: C.sageDeep}}>{n}</div>
            <div style={{fontSize: 30, color: C.muted, marginTop: 8}}>{l}</div>
          </div>
        ))}
      </div>
      <div style={{alignSelf: 'flex-start', marginTop: 56, fontSize: 36, fontWeight: 700, color: C.ink}}>
        {t.learn.completed}
      </div>
      <div style={{display: 'flex', flexWrap: 'wrap', gap: 22, marginTop: 26, alignSelf: 'flex-start'}}>
        {t.learn.surahs.map((s) => (
          <span
            key={s}
            style={{
              background: C.sageBg,
              color: '#3a4034',
              borderRadius: 36,
              padding: '22px 36px',
              fontSize: 34,
              fontWeight: 500,
            }}
          >
            ✓ {s}
          </span>
        ))}
      </div>
    </div>
  );
};

// ── Qibla ──────────────────────────────────────────────────────────────
export const QiblaScene: React.FC = () => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const {t, lang} = useVid();
  const angle = interpolate(spring({frame: f - 10, fps, config: {damping: 14}}), [0, 1], [42, 138]);
  return (
    <div
      style={{
        flex: 1,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '0 60px',
      }}
    >
      <div style={{alignSelf: 'flex-start', fontSize: 44, fontWeight: 700, color: C.goldText, marginBottom: 50}}>
        {t.qibla.title}
      </div>
      <div style={{position: 'relative', width: 640, height: 640}}>
        <div
          style={{
            position: 'absolute',
            inset: 0,
            borderRadius: '50%',
            border: `3px solid ${C.lineDark}`,
            background: 'radial-gradient(circle at 50% 40%, rgba(18,52,36,.5) 0%, #0c2019 70%)',
            boxShadow: 'inset 0 0 70px rgba(0,0,0,.5)',
          }}
        />
        <span style={{position: 'absolute', top: 18, left: '50%', transform: 'translateX(-50%)', fontSize: 36, fontWeight: 700, color: C.goldText}}>{t.qibla.dir.n}</span>
        <span style={{position: 'absolute', bottom: 18, left: '50%', transform: 'translateX(-50%)', fontSize: 36, fontWeight: 700, color: C.mutedDark}}>{t.qibla.dir.s}</span>
        <span style={{position: 'absolute', right: 24, top: '50%', transform: 'translateY(-50%)', fontSize: 36, fontWeight: 700, color: C.mutedDark}}>{t.qibla.dir.e}</span>
        <span style={{position: 'absolute', left: 24, top: '50%', transform: 'translateY(-50%)', fontSize: 36, fontWeight: 700, color: C.mutedDark}}>{t.qibla.dir.w}</span>
        <div style={{position: 'absolute', inset: 0, transform: `rotate(${angle}deg)`}}>
          <div
            style={{
              position: 'absolute',
              left: '50%',
              top: 92,
              width: 9,
              height: 200,
              marginLeft: -4.5,
              background: 'linear-gradient(rgba(216,184,120,0), #D8B878)',
              borderRadius: 6,
            }}
          />
          <div
            style={{
              position: 'absolute',
              left: '50%',
              top: -6,
              transform: `translateX(-50%) rotate(${-angle}deg)`,
              width: 112,
              height: 112,
              borderRadius: 26,
              background: '#1c130b',
              border: `3px solid ${C.gold}`,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            <div style={{width: 70, height: 70, border: `2px solid ${C.gold}`, borderRadius: 8, opacity: 0.7}} />
          </div>
        </div>
        <div style={{position: 'absolute', left: '50%', top: '50%', transform: 'translate(-50%,-50%)', textAlign: 'center'}}>
          <div style={{fontSize: 124, fontWeight: 800, color: C.goldText, lineHeight: 1, direction: 'ltr'}}>
            {num(lang, Math.round(angle))}°
          </div>
          <div style={{fontSize: 36, color: C.mutedDark, marginTop: 12}}>{t.qibla.toKaaba}</div>
        </div>
      </div>
      <div
        style={{
          marginTop: 80,
          width: '100%',
          background: C.surfDark,
          border: `2px solid ${C.lineDark}`,
          borderRadius: 40,
          padding: '40px 46px',
          display: 'flex',
          alignItems: 'center',
          gap: 28,
        }}
      >
        <div style={{width: 26, height: 26, borderRadius: '50%', background: C.gold, flex: '0 0 auto'}} />
        <div>
          <div style={{fontSize: 40, color: C.creamDark, fontWeight: 600}}>{t.qibla.aligned}</div>
          <div style={{fontSize: 32, color: C.mutedDark, marginTop: 6}}>{t.qibla.hold}</div>
        </div>
      </div>
    </div>
  );
};

// ── Outro ──────────────────────────────────────────────────────────────
const Outro: React.FC = () => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const {t} = useVid();
  const s = spring({frame: f, fps, config: {damping: 13}});
  return (
    <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center'}}>
      <div style={{transform: `scale(${0.86 + 0.14 * s})`, textAlign: 'center'}}>
        <div style={{fontFamily: AMIRI, fontSize: 180, color: C.goldText, lineHeight: 1}}>نِيّة</div>
        <div style={{fontSize: 84, fontWeight: 800, color: C.goldText, marginTop: 16}}>Niyyah</div>
        <div style={{fontSize: 44, color: C.mutedDark, marginTop: 26}}>{t.outroSub}</div>
        <div
          style={{
            marginTop: 54,
            display: 'inline-block',
            border: `2px solid ${C.gold}`,
            color: C.goldText,
            padding: '26px 56px',
            borderRadius: 44,
            fontSize: 40,
            fontWeight: 600,
          }}
        >
          {t.outroCta}
        </div>
      </div>
    </AbsoluteFill>
  );
};

// ── Assembly ───────────────────────────────────────────────────────────
const Body: React.FC = () => {
  const {t} = useVid();
  useAmiri();
  return (
    <AbsoluteFill style={{backgroundColor: '#f1f0ea'}}>
      <Sequence from={0} durationInFrames={80} name="Intro">
        <Fade dur={80}>
          <Stage>
            <Intro />
          </Stage>
        </Fade>
      </Sequence>

      <Sequence from={70} durationInFrames={200} name="Gate">
        <Fade dur={200}>
          <Stage>
            <Headline sub={t.gate.sub}>
              {t.gate.head[0]}
              <br />
              {t.gate.head[1]}
            </Headline>
            <Phone>
              <GateScene />
            </Phone>
          </Stage>
        </Fade>
      </Sequence>

      <Sequence from={258} durationInFrames={110} name="Unlock">
        <Fade dur={110}>
          <Stage>
            <Headline sub={t.unlock.sub}>
              {t.unlock.head[0]}
              <br />
              {t.unlock.head[1]}
            </Headline>
            <Phone>
              <UnlockScene />
            </Phone>
          </Stage>
        </Fade>
      </Sequence>

      <Sequence from={356} durationInFrames={150} name="Tracker">
        <Fade dur={150}>
          <Stage>
            <Headline sub={t.tracker.sub}>
              {t.tracker.head[0]}
              <br />
              {t.tracker.head[1]}
            </Headline>
            <Phone>
              <TrackerScene />
            </Phone>
          </Stage>
        </Fade>
      </Sequence>

      <Sequence from={494} durationInFrames={135} name="Learning">
        <Fade dur={135}>
          <Stage>
            <Headline sub={t.learn.sub}>
              {t.learn.head[0]}
              <br />
              {t.learn.head[1]}
            </Headline>
            <Phone>
              <LearningScene />
            </Phone>
          </Stage>
        </Fade>
      </Sequence>

      <Sequence from={617} durationInFrames={150} name="Qibla">
        <Fade dur={150}>
          <Stage dark>
            <Headline dark sub={t.qibla.sub}>
              {t.qibla.head[0]}
              <br />
              {t.qibla.head[1]}
            </Headline>
            <Phone dark>
              <QiblaScene />
            </Phone>
          </Stage>
        </Fade>
      </Sequence>

      <Sequence from={757} durationInFrames={90} name="Outro">
        <Fade dur={90}>
          <Stage dark>
            <Outro />
          </Stage>
        </Fade>
      </Sequence>
    </AbsoluteFill>
  );
};

export const Walkthrough: React.FC<{lang?: Lang; fmt?: Fmt}> = ({lang = 'en', fmt = 'store'}) => {
  return (
    <VidProvider lang={lang} fmt={fmt}>
      <Body />
    </VidProvider>
  );
};
