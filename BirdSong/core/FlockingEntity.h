//
//  FlockingEntity.h
//  BirdSong
//
//  Created by thealphanerd on 2/11/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__FlockingEntity__
#define __BirdSong__FlockingEntity__

#include <iostream>
#include "y-entity.h"
#include "Texture.h"
#include "Globals.h"
#include "mo_fun.h"

using namespace std;

//-----------------------------------------------------------------------------
// name: class boid
// desc: ...
//-----------------------------------------------------------------------------
class Boid : public YEntity
{
public:
    // constructor
    Boid();
    
public:
    // update
    void update( YTimeInterval dt);
    // void render();
    
public:
    // alpha ramp
    Texture * _texture;
    Vector3D ALPHA;
};

//-----------------------------------------------------------------------------
// name: class flock
// desc: ...
//-----------------------------------------------------------------------------
class Flock : public YEntity
{
public:
    // constructor
    Flock() {} ;
    
public:
    //set
    void init(int count);
    
public:
    Vector3D centerMass(Boid * boid);
    Vector3D collisionDetect(Boid * boid);
    Vector3D potentialVelocity(Boid * boid);
    Vector3D tendToPlace(Boid * boid);
    Vector3D boundPosition(Boid * boid);
    void boundVelocity(Boid * boid);
    // update
    // void update( YTimeInterval dt);
    // void render();
    
public:
    // alpha ramp
    UITouch* _touch;
    bool _locked;
};

#endif /* defined(__BirdSong__FlockingEntity__) */
