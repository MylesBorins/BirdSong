//
//  FlockPool.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/17/14.
//  Copyright (c) 2014 Myles Borins. All rights reserved.
//

#include "FlockPool.h"

FlockPool::FlockPool(int count)
{
    for (int i = 0; i < count; i++)
    {
        Flock * fe = new Flock();
        fe->init(10);
        fe->active = false;
        // reset transparency
        fe->alpha = 1.0;
        // set location
        fe->loc.setAll(0);
        // set color
        fe->col.setAll(1);
        // assign touch
        fe->_touch = nullptr;
        addChild(fe);
    }
};

//FlockPool::~FlockPool()
//{
//    for (std::vector<YEntity *>::iterator it = children.begin(); it != children.end(); it++)
//    {
//        FlockEntity * fe = (FlockEntity *)(*it);
//        delete te;
//    }
//};
//

void FlockPool::touched(UITouch * touch, GLfloat x, GLfloat y)
{
    Flock * nonActiveFlock = nullptr;
    for (std::vector<YEntity *>::iterator it = children.begin(); it != children.end(); it++)
    {
        Flock * fe = (Flock *)(*it);
        if (fe->active && fabs(fe->_centerMass.x - x) < 0.25 && fabs(fe->_centerMass.y - y) < 0.25)
        {
            removeFlock(fe);
            return;
        }
        else if (!fe->active && nonActiveFlock == nullptr)
        {
            nonActiveFlock = fe;
        }
    }
    if (nonActiveFlock != nullptr)
    {
        addFlock(nonActiveFlock, touch, x, y);
    }
};
void FlockPool::addFlock(Flock * flock, UITouch * touch, GLfloat x, GLfloat y)
{
    flock->reset(x, y);
    flock->active = true;
    flock->_touch = touch;
};

void FlockPool::updateFlock(UITouch * touch, GLfloat x, GLfloat y)
{
    std::vector<YEntity *>::iterator it = children.begin();
    Flock * fe = (Flock *)(*it);
    while (fe->_touch != touch)
    {
        it++;
        fe = (Flock *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    fe->updateCenter(x, y);
};

void FlockPool::lockFlock(UITouch * touch)
{
    std::vector<YEntity *>::iterator it = children.begin();
    Flock * fe = (Flock *)(*it);
    while (fe->_touch != touch)
    {
        it++;
        fe = (Flock *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    fe->_locked = true;
    fe->_touch = nullptr;
//    fe->active = false;
};

void FlockPool::removeFlock(Flock * flock)
{
    flock->_centerMass.setAll(0);
    flock->_tend = 0;
    flock->_locked = false;
    flock->_kill = true;
//    flock->active = false;
};

void FlockPool::synthesize(Float32 * buffer, UInt32 numFrames, void * userData)
{
    int count = 0;
    if (this != nullptr)
    {
        for (std::vector<YEntity *>::iterator it = children.begin(); it < children.end(); it++)
        {
            Flock * fe = (Flock *)(*it);
            if(fe->active)
            {
                fe->synthesize(buffer, numFrames, NULL);
                count++;
            }
        }
        for (int i = 0; i < numFrames * 2; i++)
        {
            buffer[i] /= count;
        }
    }
    
};