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
#import "FlockPool.h"

class Simulation : public YEntity
{

public:
    // get the root
    YEntity & root() { return _root; }
protected:
    YEntity _root;

public:
    // cascade timestep simulation through system (as connected to this)
    static void systemCascade(YTimeInterval dt);

};

#endif /* defined(__BirdSong__Simulation__) */
