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
    
    // simple scheduler
    static UInt32 clock;
    static double tempo;
    static UInt32 thirtysecond;
    static UInt32 sixteenth;
    static UInt32 eigth;
    static UInt32 quarter;
    static UInt32 half;
    static UInt32 whole;
public:
    static void setTempo(double tempo);
};

#endif /* defined(__BirdSong__Audio__) */