//
//  Audio.h
//  BirdSong
//
//  Created by thealphanerd on 1/29/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__Audio__
#define __BirdSong__Audio__

#include <iostream>
#include "Globals.h"
#import "mo_audio.h"

class Audio
{
public:
    // init audio
    static bool init( );
    // start audio
    static bool start();
public:
    // max delay possible
    static int m_maxAmountOfDelay;
    // amount of delay
    static int m_amountOfDelay;
};

#endif /* defined(__BirdSong__Audio__) */
