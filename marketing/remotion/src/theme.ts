import {useEffect, useState} from 'react';
import {continueRender, delayRender, staticFile} from 'remotion';

// Niyyah brand palette — Calm Minimal (light) + Premium Night (dark)
export const C = {
  sage: '#4F6048',
  sageDeep: '#2F4733',
  sageBg: '#EEF1E7',
  sageLine: '#E6E9DD',
  cream: '#FBFBF9',
  ink: '#2A2E28',
  muted: '#6E7468',
  faint: '#9AA08F',
  tag: '#7C8A6E',
  // dark
  gold: '#D8B878',
  goldText: '#E3C98F',
  midnight: '#0C2019',
  surfDark: '#10271E',
  lineDark: '#20402F',
  creamDark: '#ECE6D6',
  mutedDark: '#B3AA92',
};

export const lightBg =
  'radial-gradient(120% 80% at 50% -10%, #eef1e7 0%, #f8f7f2 55%, #f1f0ea 100%)';
export const darkBg =
  'radial-gradient(120% 80% at 50% -10%, #143528 0%, #0c2019 60%, #07140e 100%)';

export const SANS =
  "'Inter', system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif";
export const AMIRI = "'AmiriW', serif";

// Load the bundled Amiri font (copied into public/fonts) before rendering.
export const useAmiri = () => {
  const [handle] = useState(() => delayRender('load-amiri'));
  useEffect(() => {
    const reg = new FontFace('AmiriW', `url(${staticFile('fonts/Amiri-Regular.ttf')})`);
    const bold = new FontFace('AmiriW', `url(${staticFile('fonts/Amiri-Bold.ttf')})`, {
      weight: '700',
    });
    Promise.all([reg.load(), bold.load()])
      .then(([a, b]) => {
        document.fonts.add(a);
        document.fonts.add(b);
        continueRender(handle);
      })
      .catch(() => continueRender(handle));
  }, [handle]);
};
