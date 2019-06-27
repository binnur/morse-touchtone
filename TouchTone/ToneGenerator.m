//
//  ToneGenerator.m
//  TouchTone
//
//  Created by Binnur Al-Kazily on 6/5/19.
//  Copyright © 2019 Binnur Al-Kazily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "TouchTone-Bridging-Header.h"


/**
 * Sine wave tone generation with AudioEngine. Morse code sounds achieved by
 * muting mixer on/off during touch
 *
 * Basic AudioEngine recipe:
 *   1. create engine
 *   2. create nodes
 *   3. attach nodes to engine
 *   4. connect nodes together
 *   5. start engine
 *
 * Helpful resources:
 *   - https:christianfloisand.wordpress.com/2013/07/30/building-a-tone-generator-for-ios-using-audio-units/
 *   - https:github.com/MMercieca/Handshake/tree/master/Handshake
 *   - https:github.com/picciano/iOS-Tone-Generator/blob/master/TGSineWaveToneGenerator.m
 */

@implementation ToneGenerator

// MARK: -
// Initialize ToneGenerator for operation
- (id)init
{
    if (self = [super init]) {
        _frequency = TONE_GENERATOR_FREQUENCY_DEFAULT;
        _amplitude = TONE_GENERATOR_AMPLITUDE_DEFAULT;

        // Setup AudioSession management
        [self _initAudioSession];

        // init AudioEngine
        [self _initAudioEngineNodes];
        [self _createEngineAndAttachNodes];
        [self _makeEngineConnections];
    }

    return self;
}

- (void)dealloc {
    NSLog(@"deallocating ToneGenerator\n");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// AudioEngine setup and initialization
- (void)_initAudioEngineNodes {
    // create instance of all needed nodes
    _player = [[AVAudioPlayerNode alloc] init];
    NSAssert(_player !=nil, @"Error! Couldn't start player");
}

- (void)_createEngineAndAttachNodes {
    // create an instance of engine
    _engine = [[AVAudioEngine alloc] init];
    NSAssert(_engine != nil, @"Error! Couldn't start AudioEngine");

    // attach player node to engine
    [_engine attachNode: _player];
}

// Audio flow: player(sine buffer source) -> mixer (sound control) -> output
- (void)_makeEngineConnections {
    // initialize mixer for output
    // The engine constructs a singleton main mixer and connects it to the
    //  outputNode on demand. Additional nodes can then be connected to the mixer
    //  By default, the mixer's output format (sample rate and channel count) tracks
    //  the format of the output node.

    _mainMixer = [_engine mainMixerNode];
    NSAssert(_mainMixer != nil, @"Error! Couldn't initialize mixer");

    // update samplerate and number of channels given mixer
    _sampleRate = [[_mainMixer outputFormatForBus:0] sampleRate];
    _numChannels = [[_mainMixer outputFormatForBus:0] channelCount];

    // setup sine wave buffer
    [self _initAudioBuffer];

    // schedule player for looping model
    [_player scheduleBuffer:_buffer
                     atTime:nil
                    options:AVAudioPlayerNodeBufferLoops
          completionHandler:nil];

    // connect player node to engine's main mixer
    [_engine connect:_player to:_mainMixer format:[_mainMixer outputFormatForBus: 0]];

    // TODO: add tap here

}

// generate sine wave
- (void)_initAudioBuffer {
    // With default frequency of 441.0 and sample rate of 44.1 kHz, we have a
    // 1:100 ratio for number of samples in the buffer.
    // With a whole multitude result, we have a complete sine wave (vs. 440/44100),
    // which is good for a smooth looping experience
    AVAudioFrameCount frameBufferLength = floor(_sampleRate / _frequency) * 1;

    _buffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:[_player outputFormatForBus:0]
                                            frameCapacity:frameBufferLength];
    _buffer.frameLength = frameBufferLength;

    float *const *floatChannelData = _buffer.floatChannelData;

    NSLog(@"Sine generator: sample rate = %.1f, %ld channels, frame length = %u.", _sampleRate, (long)_numChannels, _buffer.frameLength);

    // fill the buffer w/ sine wave
    for (int i = 0; i < _buffer.frameLength ; i ++) {
        float theta = _frequency * i * 2.0 * M_PI / _sampleRate;
        float value = sinf(theta);
        for (int channelNumber = 0; channelNumber < _numChannels; channelNumber++) {
            float * const channelBuffer = floatChannelData[channelNumber];
            channelBuffer[i] = value * _amplitude;
        }
    }
}

// MARK: -
// Audio control functions
-(void)startEngine {
    // start engine -- starts the audio hardware and audio flow
    NSError *error;
    NSAssert([_engine startAndReturnError:&error], @"couldn't start engine, %@", [error localizedDescription]);
}

- (void)stopEngine {
    [_engine stop];
    [_player stop];
}

- (void)unmuteEngine {
    // mixer volume full on
    if ([_player isPlaying] == false) {
        [_player play];
    }
    _mainMixer.outputVolume = 1.0;
}

- (void)muteEngine {
    // mixer volume muted
    _mainMixer.outputVolume = 0.0;
}


// MARK: -
// MARK: AudioSession configuration
- (void)_initAudioSession {
    // TODO: Add AudioSession mgmt
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;

    BOOL ok = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    NSAssert1(ok, @"Audio error %@", setCategoryError);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handleInterruption:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:audioSession];
}

- (void)_handleInterruption:(id)sender {
    [self muteEngine];
}


@end

