//
//  FlockingEntity.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/11/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "FlockingEntity.h"

YTimeInterval dtCount = 0;

Boid::Boid()
{
    Texture * texEnt = new Texture;
    _texture = texEnt;
    texEnt->alpha = 1;
    texEnt->sca.setAll(MoFun::rand2f(0.05, 0.1));
    ugen = new stk::SineWave();
    ugen->setRate(SAMPRATE / 10);
    this->addChild(texEnt);
}

void Boid::update( YTimeInterval dt )
{
    dtCount += dt;
    if (dtCount > (1 / SAMPRATE) * 30)
    {
        Vector3D v1, v2, v3, v4, v5, v6;
        
        // slew
        v1 = ((Flock *)parent)->centerMass(this);
        v2 = ((Flock *)parent)->collisionDetect(this);
        v3 = ((Flock *)parent)->potentialVelocity(this);
        v4 = ((Flock *)parent)->tendToPlace(this);
        v5 = ((Flock *)parent)->boundPosition(this);
        ((Flock *)parent)->boundVelocity(this);
        // //
        
        this->vel = (this->vel + v1 + v2 + v3 + v4 + v5);
        dtCount = 0;
    }
    // extra scler here
    this->loc = this->loc + this->vel * dt * 0.5;
    return;
};


Vector3D Flock::centerMass(Boid * boid)
{
    Vector3D perceivedCenter;
    
    for( vector<YEntity *>::iterator ei = this->children.begin();
        ei!= this->children.end(); ei++ )
    {
        Boid * iteratedBoid = ((Boid *)*ei);
        if(iteratedBoid != boid)
        {
            perceivedCenter += iteratedBoid->loc;
        }
        
    }
    double scaler = (1 / ((double)this->children.size() - 1));
    perceivedCenter *= scaler;
    return (perceivedCenter - boid->loc) * 0.1;
};

Vector3D Flock::collisionDetect(Boid * boid)
{
    Vector3D collision;
    
    for( vector<YEntity *>::iterator ei = this->children.begin();
        ei!= this->children.end(); ei++ )
    {
        Boid * iteratedBoid = ((Boid *)*ei);
        if(iteratedBoid != boid)
        {
            Vector3D diff = (iteratedBoid->loc - boid->loc);
            double magnitude = diff.magnitude();
            if(magnitude < 0.2 || (_kill && magnitude < 0.5))
            {
                collision = collision -(iteratedBoid->loc - boid->loc);
            }
        }
        
    }
    return collision;
};

Vector3D Flock::potentialVelocity(Boid * boid)
{
    Vector3D perceivedVelocity;
    
    for( vector<YEntity *>::iterator ei = this->children.begin();
        ei!= this->children.end(); ei++ )
    {
        Boid * iteratedBoid = ((Boid *)*ei);
        if(iteratedBoid != boid)
        {
            perceivedVelocity += iteratedBoid->vel;
        }
        
    }
    double scaler = (1 / ((double)this->children.size() - 1));
    perceivedVelocity *= scaler;
    return (perceivedVelocity - boid->vel) * 0.125;
};

Vector3D Flock::tendToPlace(Boid * boid)
{
    return (_centerMass - boid->loc) * _tend; //(place - boid->loc) * 0.0001 * (Globals::scaler * -1 + 1);
}

Vector3D Flock::boundPosition(Boid * boid)
{
//    float xmin = -10, xmax = 10, ymin = -0.7, ymax = 0.7, zmin = -150, zmax = 10;
    float xmin = -1.3, xmax = 1.3, ymin = -1., ymax = 1., zmin = -.99, zmax = 1;
    Vector3D v;
    if(boid->loc.x < xmin)
    {
        v.x = 10 * Globals::scaler;
    }
    else if (boid->loc.x > xmax)
    {
        v.x = -10 * Globals::scaler;
    }
    if (boid->loc.y < ymin)
    {
        v.y = 10 * Globals::scaler;
    }
    else if (boid->loc.y > ymax)
    {
        v.y = -10 * Globals::scaler;
    }
    if (boid->loc.z < zmin)
    {
        v.z = 10 * Globals::scaler;
    }
    else if (boid->loc.z > zmax)
    {
        v.z = -10 * Globals::scaler;
    }
    return v;
};

void Flock::boundVelocity(Boid * boid)
{
    float limit = 1.5;
    Vector3D v;
    float mag = boid->vel.magnitude();
    
    if (mag > limit)
    {
        boid->vel = (boid->vel * (1/mag)) * limit;
    }
}

void Flock::init(int count)
{
    for (int i = 0; i < count; i++)
    {
        Boid * boid = new Boid;
        boid->loc.set(MoFun::rand2f(-1.0,1.0),MoFun::rand2f(-1.0,1.0), MoFun::rand2f(-1.0,1.0));
        // boid->loc.setXYFromPolar( 0.8 - i * 0.01, (360 * i / count) + i * 10);
        if (i == 0)
        {
            boid->active = true;
        }
        else {
            boid->active = false;
        }
        this->addChild(boid);
    }
    alpha = 1;
    _kill = false;
}

void Flock::update(YTimeInterval dt)
{
    if(_touch != nullptr)
    {
        UInt32 spawnRate = Globals::thirtysecond;
        if (_centerMass.y <= -0.66) {
            spawnRate = Globals::whole;
        }
        else if (_centerMass.y <= -0.33)
        {
            spawnRate = Globals::half;
        }
        else if (_centerMass.y <= 0.)
        {
            spawnRate = Globals::quarter;
        }
        else if (_centerMass.y <= 0.33)
        {
            spawnRate = Globals::eigth;
        }
        else if (_centerMass.y <= 0.66)
        {
            spawnRate = Globals::sixteenth;
        }

        if (Globals::clock % spawnRate <= FRAMESIZE)
        {
            std::vector<YEntity *>::iterator it = children.begin();
            Boid * be = (Boid *)(*it);
            while (be->active)
            {
                it++;
                be = (Boid *)(*it);
                if (it == children.end()) {
                    return;
                }
            }
            be->active = true;
        }
    }
    
    if(_kill)
    {
        alpha -= alpha * dt;
        for( vector<YEntity *>::iterator ei = this->children.begin();
            ei!= this->children.end(); ei++ )
        {
            Boid * boid = ((Boid *)*ei);
            boid->_texture->alpha -= boid->_texture->alpha * dt;
        }
        
        if (alpha < 0.02)
        {
            active = false;
            for( vector<YEntity *>::iterator ei = this->children.begin();
                ei!= this->children.end(); ei++ )
            {
                Boid * boid = ((Boid *)*ei);
                boid->active = false;
                boid->_texture->alpha = 1;
            }
        }
    }
};

void Flock::reset(GLfloat x, GLfloat y)
{
    updateCenter(x, y);
    _tend = 0.7;
    _kill = false;
    alpha = 1;
    bool first = true;
    for( vector<YEntity *>::iterator ei = this->children.begin();
        ei!= this->children.end(); ei++ )
    {
        Boid * boid = ((Boid *)*ei);
        if (first)
        {
            boid->active = true;
            first = !first;
        }
        else {
            boid->active = false;
        }
        boid->_texture->alpha = 1;
        boid->loc.set(MoFun::rand2f(-1.0,1.0),MoFun::rand2f(-1.0,1.0), MoFun::rand2f(-1.0,1.0));
    }
    
};

void Flock::updateCenter(GLfloat x, GLfloat y)
{
    _centerMass.set(x, y, 0);
    stk::StkFloat fundemental = MoFun::map(x, -1.3, 1.3, 50, 500);
    int count = 0;
    for( vector<YEntity *>::iterator ei = this->children.begin();
        ei!= this->children.end(); ei++ )
    {
        Boid * boid = ((Boid *)*ei);
        boid->ugen->setFrequency(fundemental + fundemental * count);
        count++;
    }
};

void Flock::synthesize(Float32 * buffer, UInt32 numFrames, void * userData)
{
    int count = 0;
    Float32 buffertoo[numFrames*2];
    // zero!!!
    memset( buffertoo, 0, sizeof(SAMPLE)*numFrames*2 );
    for( vector<YEntity *>::iterator ei = this->children.begin();
        ei!= this->children.end(); ei++ )
    {
        Boid * boid = ((Boid *)*ei);
        if (boid->active) {
            for (int i = 0; i < numFrames * 2; i += 2)
            {
                Float32 sample = boid->ugen->tick() * alpha;
                buffertoo[i] += sample;
                buffertoo[i +1] += sample;
            }
            count++;
        }
    }
    for (int i = 0; i < numFrames * 2; i ++)
    {
        buffer[i] += (buffertoo[i] / count);
    }
};