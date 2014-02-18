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
#include "SineWave.h"
#include "PRCRev.h"

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
    stk::SineWave * ugen;
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

    void updateCenter(GLfloat x, GLfloat y);
    
    void reset(GLfloat x, GLfloat y);
    
    void synthesize(Float32 * buffer, UInt32 numFrames, void * userData);
    // void render();
    
public:
    Vector3D _centerMass;
    Vector3D _perceivedCenter;
    UITouch* _touch;
    bool _locked;
    double _tend;
    bool _kill;
    stk::PRCRev * reverb;
};

#endif /* defined(__BirdSong__FlockingEntity__) */
