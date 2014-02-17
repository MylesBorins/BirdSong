//
//  Simulation.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/4/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "Simulation.h"


//Vector3D boundingBox (PhysicsEntity * dot) {
//    Vector3D v;
//    float xmin = -1.45, xmax = 1.45, ymin = -0.7, ymax = 0.7;
//    if ((dot->loc.x < xmin && dot->vel.x < 0) || (dot->loc.x > xmax && dot->vel.x > 0))
//    {
//        dot->tubeBell.noteOn(dot->pitch, dot->vel.magnitude());
//        v.x = dot->vel.x * -2;
//    }
//    else if ((dot->loc.y < ymin && dot->vel.y < 0) || (dot->loc.y > ymax && dot->vel.y > 0))
//    {
//        dot->tubeBell.noteOn(dot->pitch, dot->vel.magnitude());
//        v.y = dot->vel.y * -2;
//    }
//    return v;
//}

void Simulation::systemCascade(YTimeInterval dt)
{
    
};