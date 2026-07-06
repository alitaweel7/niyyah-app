import React from 'react';
import {Composition} from 'remotion';
import {Walkthrough} from './Walkthrough';
import {CarouselSlide, FBCover, Profile, StoryFrame} from './Posts';
import {ReleaseTrailer, RELEASE_FRAMES} from './Release';

// iPhone 6.9" App Store app-preview spec: 1290 x 2796, 30fps, < 30s.
// Instagram Reel spec: 1080 x 1920 (9:16), 30fps.
export const RemotionRoot: React.FC = () => {
  return (
    <>
      <Composition
        id="Walkthrough"
        component={Walkthrough}
        durationInFrames={847}
        fps={30}
        width={1290}
        height={2796}
        defaultProps={{lang: 'en' as const, fmt: 'store' as const}}
      />
      <Composition
        id="ReelEN"
        component={Walkthrough}
        durationInFrames={847}
        fps={30}
        width={1080}
        height={1920}
        defaultProps={{lang: 'en' as const, fmt: 'reel' as const}}
      />
      <Composition
        id="ReelAR"
        component={Walkthrough}
        durationInFrames={847}
        fps={30}
        width={1080}
        height={1920}
        defaultProps={{lang: 'ar' as const, fmt: 'reel' as const}}
      />
      <Composition
        id="Carousel"
        component={CarouselSlide}
        durationInFrames={1}
        fps={30}
        width={1080}
        height={1350}
        defaultProps={{lang: 'en' as const, i: 1}}
      />
      <Composition
        id="Story"
        component={StoryFrame}
        durationInFrames={1}
        fps={30}
        width={1080}
        height={1920}
        defaultProps={{lang: 'en' as const, i: 1}}
      />
      <Composition id="Profile" component={Profile} durationInFrames={1} fps={30} width={1080} height={1080} />
      <Composition id="FBCover" component={FBCover} durationInFrames={1} fps={30} width={1640} height={624} />
      <Composition
        id="ReleaseEN"
        component={ReleaseTrailer}
        durationInFrames={RELEASE_FRAMES}
        fps={30}
        width={1920}
        height={1080}
        defaultProps={{lang: 'en' as const}}
      />
      <Composition
        id="ReleaseAR"
        component={ReleaseTrailer}
        durationInFrames={RELEASE_FRAMES}
        fps={30}
        width={1920}
        height={1080}
        defaultProps={{lang: 'ar' as const}}
      />
    </>
  );
};
