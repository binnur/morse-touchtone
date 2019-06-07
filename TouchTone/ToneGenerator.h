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


#define SINE_WAVE_TONE_GENERATOR_FREQUENCY_DEFAULT 440.0f

#define SINE_WAVE_TONE_GENERATOR_SAMPLE_RATE_DEFAULT 44100.0f

#define SINE_WAVE_TONE_GENERATOR_AMPLITUDE_LOW 0.01f
#define SINE_WAVE_TONE_GENERATOR_AMPLITUDE_MEDIUM 0.02f
#define SINE_WAVE_TONE_GENERATOR_AMPLITUDE_HIGH 0.03f
#define SINE_WAVE_TONE_GENERATOR_AMPLITUDE_FULL 0.25f
#define SINE_WAVE_TONE_GENERATOR_AMPLITUDE_DEFAULT SINE_WAVE_TONE_GENERATOR_AMPLITUDE_MEDIUM

typedef struct {
    double frequency;
    double amplitude;
    double theta;
} TGChannelInfo;

@interface ToneGenerator : NSObject {
@public
    AudioComponentInstance _toneUnit;
    double _sampleRate;
    TGChannelInfo *_channels;
    UInt32 _numChannels;
}

- (id)initWithChannels:(UInt32)size;
- (id)initWithFrequency:(double)hertz amplitude:(double)volume;
- (void)playForDuration:(NSTimeInterval)time;
- (void)play;
- (void)stop;

@end

#endif /* ToneGenerator_h */
