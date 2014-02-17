//
//  Audio.cpp
//  BirdSong
//
//  Created by thealphanerd on 1/29/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "Audio.h"

// Set defaults for scheduler
UInt32 Audio::clock = 0;
double Audio::tempo = 128;
double beat = (SRATE * 60) / Audio::tempo;
UInt32 Audio::whole = beat * 4;
UInt32 Audio::half = beat * 2;
UInt32 Audio::quarter = beat;
UInt32 Audio::sixteenth = beat / 2;
UInt32 Audio::thirtysecond = beat / 4;

//-----------------------------------------------------------------------------
// name: audio_callback()
// desc: audio callback, yeah
//-----------------------------------------------------------------------------
void audio_callback( Float32 * buffer, UInt32 numFrames, void * userData )
{
    // zero!!!
    memset( buffer, 0, sizeof(SAMPLE)*numFrames*2 );
    
    Audio::clock += numFrames;
    
//    if (Audio::clock % Audio::whole <= FRAMESIZE)
//    {
//       NSLog( @"WHOLE NOTE" );
//    }
//    else if (Audio::clock % Audio::half <= FRAMESIZE)
//    {
//        NSLog( @"HALF NOTE" );
//    }
//    else if (Audio::clock % Audio::quarter <= FRAMESIZE)
//    {
//        NSLog( @"QUARTER NOTE" );
//    }
    // NSLog( @"." );
}

bool Audio::init()
{
    // init the audio layer
    bool result = MoAudio::init( SRATE, FRAMESIZE, 2 );
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
    Audio::tempo = tempo;
    double beat = (SRATE * 60) / tempo;
    Audio::whole = beat * 4;
    Audio::half = beat * 2;
    Audio::quarter = beat;
    Audio::sixteenth = beat / 2;
    Audio::thirtysecond = beat / 4;
};
