//
//  Audio.cpp
//  BirdSong
//
//  Created by thealphanerd on 1/29/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "Audio.h"

//-----------------------------------------------------------------------------
// name: audio_callback()
// desc: audio callback, yeah
//-----------------------------------------------------------------------------
void audio_callback( Float32 * buffer, UInt32 numFrames, void * userData )
{
    // zero!!!
    memset( buffer, 0, sizeof(SAMPLE)*numFrames*2 );
    // Get dat buffer
    Simulation::flocks->synthesize(buffer, numFrames, NULL);
    
    Globals::clock += numFrames;
}

bool Audio::init()
{
    // init the audio layer
    bool result = MoAudio::init( SAMPRATE, FRAMESIZE, 2 );
    if( !result )
    {
        // something went wrong
        NSLog( @"cannot initialize real-time audio!" );
        // bail out
        return false;
    }
    Audio::setTempo(128);
    return true;
}

bool Audio::start()
{
    // start the audio layer, registering a callback method
    bool result = MoAudio::start( audio_callback, NULL );
    if( !result )
    {
        // something went wrong
        NSLog( @"cannot start real-time audio!" );
        // bail out
        return false;
    }
    NSLog( @"starting real-time audio..." );
    return true;
}

void Audio::setTempo(double tempo)
{
    // Assuming 4/4
    Globals::clock = 0;
    Globals::tempo = 128;
    double beat = (SAMPRATE * 60) / Globals::tempo;
    Globals::whole = beat * 4;
    Globals::half = beat * 2;
    Globals::quarter = beat;
    Globals::eigth = beat / 2;
    Globals::sixteenth = beat / 4;
    Globals::thirtysecond = beat / 8;
};
