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
    
    // NSLog( @"." );
}

bool Audio::init()
{
    // init the audio layer
    bool result = MoAudio::init( SRATE, 1024, 2 );
    if( !result )
    {
        // something went wrong
        NSLog( @"cannot initialize real-time audio!" );
        // bail out
        return false;
    }
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
