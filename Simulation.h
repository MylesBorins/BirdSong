//
//  Simulation.h
//  BirdSong
//
//  Created by thealphanerd on 2/4/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__Simulation__
#define __BirdSong__Simulation__

#include <iostream>
#include "Globals.h"
#import "mo_gfx.h"
#import "y-entity.h"

class Simulation
{
public:
    static void updateAll( YTimeInterval dt );
};

#endif /* defined(__BirdSong__Simulation__) */
