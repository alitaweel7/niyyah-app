import React from 'react';
import {Composition} from 'remotion';
import {Walkthrough} from './Walkthrough';

// iPhone 6.9" App Store app-preview spec: 1290 x 2796, 30fps, < 30s.
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
      />
    </>
  );
};
