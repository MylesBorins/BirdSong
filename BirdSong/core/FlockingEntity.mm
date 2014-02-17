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

    texEnt->alpha = 0.2;
    texEnt->sca.setAll(MoFun::rand2f(0.05, 0.1));
    
    this->addChild(texEnt);
}

void Boid::update( YTimeInterval dt )
{
    dtCount += dt;
    if (dtCount > (1 / SRATE) * 30)
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
    this->loc = this->loc + this->vel * dt;
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
            if(magnitude < 0.4)
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
//
    if (Globals::scaler > .8)
    {
        return (_centerMass - boid->loc) * ((Globals::scaler * -1) + 1);
    }
    return (_centerMass - boid->loc) * 0.0001;//(place - boid->loc) * 0.0001 * (Globals::scaler * -1 + 1);
}

Vector3D Flock::boundPosition(Boid * boid)
{
//    float xmin = -10, xmax = 10, ymin = -0.7, ymax = 0.7, zmin = -150, zmax = 10;
    float xmin = -1.45, xmax = 1.45, ymin = -0.7, ymax = 0.7, zmin = -.99, zmax = 1;
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
    float limit = 3;
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
        
        this->addChild(boid);
    }
}