import React from 'react';
import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {C, darkBg, lightBg, SANS} from './theme';

// Cross-fade + subtle rise for each scene.
export const Fade: React.FC<{dur: number; children: React.ReactNode}> = ({dur, children}) => {
  const f = useCurrentFrame();
  const opacity = interpolate(f, [0, 14, dur - 14, dur], [0, 1, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const y = interpolate(f, [0, 16], [26, 0], {extrapolateRight: 'clamp'});
  return <AbsoluteFill style={{opacity, transform: `translateY(${y}px)`}}>{children}</AbsoluteFill>;
};

export const Stage: React.FC<{dark?: boolean; children: React.ReactNode}> = ({dark, children}) => (
  <AbsoluteFill
    style={{
      background: dark ? darkBg : lightBg,
      fontFamily: SANS,
      alignItems: 'center',
    }}
  >
    {children}
  </AbsoluteFill>
);

export const Headline: React.FC<{
  dark?: boolean;
  sub?: string;
  children: React.ReactNode;
}> = ({dark, sub, children}) => (
  <div style={{paddingTop: 120, textAlign: 'center', width: 1140}}>
    <div
      style={{
        fontSize: 104,
        fontWeight: 800,
        letterSpacing: -2,
        lineHeight: 1.05,
        color: dark ? C.goldText : C.sageDeep,
      }}
    >
      {children}
    </div>
    {sub ? (
      <div style={{marginTop: 26, fontSize: 44, fontWeight: 500, color: dark ? C.mutedDark : C.muted}}>
        {sub}
      </div>
    ) : null}
  </div>
);

export const Phone: React.FC<{dark?: boolean; children: React.ReactNode}> = ({dark, children}) => (
  <div
    style={{
      marginTop: 78,
      width: 900,
      height: 1808,
      background: dark ? '#05100b' : '#11130f',
      borderRadius: 96,
      padding: 20,
      boxShadow: dark ? '0 50px 120px rgba(0,0,0,.55)' : '0 50px 120px rgba(60,70,40,.28)',
    }}
  >
    <div
      style={{
        width: '100%',
        height: '100%',
        background: dark ? C.midnight : C.cream,
        borderRadius: 80,
        overflow: 'hidden',
        position: 'relative',
        display: 'flex',
        flexDirection: 'column',
      }}
    >
      <div
        style={{
          position: 'absolute',
          top: 28,
          left: '50%',
          transform: 'translateX(-50%)',
          width: 280,
          height: 66,
          background: '#11130f',
          borderRadius: 40,
          zIndex: 5,
        }}
      />
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          padding: '34px 64px 0',
          fontSize: 30,
          fontWeight: 600,
          color: dark ? C.creamDark : C.ink,
        }}
      >
        <span>9:41</span>
        <span style={{letterSpacing: 3}}>●●●</span>
      </div>
      {children}
    </div>
  </div>
);
