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
#include "Audio.h"

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
    // Simulation Functions
    Vector3D centerMass(Boid * boid);
    Vector3D collisionDetect(Boid * boid);
    Vector3D potentialVelocity(Boid * boid);
    Vector3D tendToPlace(Boid * boid);
    Vector3D boundPosition(Boid * boid);
    void boundVelocity(Boid * boid);

    void update( YTimeInterval dt );
    
    void reset(GLfloat x, GLfloat y);
    // void render();
    
public:
    Vector3D _centerMass;
    UITouch* _touch;
    bool _locked;
    double _tend;
    bool _kill;
};

#endif /* defined(__BirdSong__FlockingEntity__) */
