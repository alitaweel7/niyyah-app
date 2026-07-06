import React, {createContext, useContext} from 'react';
import {DICT, Dict, Fmt, fontFor, isRTL, Lang} from './strings';

export type Vid = {lang: Lang; fmt: Fmt; t: Dict; rtl: boolean; font: string};

const Ctx = createContext<Vid>({
  lang: 'en',
  fmt: 'store',
  t: DICT.en,
  rtl: false,
  font: fontFor('en'),
});

export const VidProvider: React.FC<{lang: Lang; fmt: Fmt; children: React.ReactNode}> = ({
  lang,
  fmt,
  children,
}) => (
  <Ctx.Provider value={{lang, fmt, t: DICT[lang], rtl: isRTL(lang), font: fontFor(lang)}}>
    {children}
  </Ctx.Provider>
);

export const useVid = () => useContext(Ctx);
