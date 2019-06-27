//
//  ToneGenerator.h
//  TouchTone
//
//  Created by Binnur Al-Kazily on 6/5/19.
//  Copyright © 2019 Binnur Al-Kazily. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AudioToolbox;
@import AVFoundation;


#ifndef ToneGenerator_h
#define ToneGenerator_h


#define TONE_GENERATOR_FREQUENCY_DEFAULT 441.0f
#define TONE_GENERATOR_AMPLITUDE_DEFAULT 0.05f

//// Nyquist Rate for calculating default sample rate -- was 44100.0f
//#define TONE_GENERATOR_SAMPLE_RATE_DEFAULT  2 * TONE_GENERATOR_FREQUENCY_DEFAULT


@interface ToneGenerator : NSObject {
@public
    AudioComponentInstance _toneUnit;
    NSInteger _numChannels;
    double _sampleRate;
    double _frequency;
    double _amplitude;
    double _theta;
    AVAudioPCMBuffer *_buffer;

    AVAudioEngine *_engine;     // needs strong reference
    AVAudioPlayerNode *_player;
    AVAudioMixerNode *_mainMixer;
}

- (void)startEngine;
- (void)stopEngine;
- (void)muteEngine;
- (void)unmuteEngine;

@end

#endif /* ToneGenerator_h */
