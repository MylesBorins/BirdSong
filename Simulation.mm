//
//  Simulation.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/4/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "Simulation.h"

FlockPool * Simulation::flocks = nullptr;

void Simulation::systemCascade(YTimeInterval dt)
{
    
};

void Simulation::init()
{
    YEntity * root = &Globals::graph->root();
    flocks = new FlockPool(12);
    root->addChild(flocks);
};