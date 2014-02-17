//
//  FlockingCollectionEntity.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/17/14.
//  Copyright (c) 2014 Myles Borins. All rights reserved.
//

#include "FlockingCollectionEntity.h"

FlockingCollectionEntity::FlockingCollectionEntity(int count)
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
        // set scale
        fe->sca.setAll( 0.3 );
        // assign Flocking
//        fe->_Flocking = nullptr;
        addChild(fe);
    }
};

//FlockingCollectionEntity::~FlockingCollectionEntity()
//{
//    for (std::vector<YEntity *>::iterator it = children.begin(); it != children.end(); it++)
//    {
//        FlockingEntity * fe = (FlockingEntity *)(*it);
//        delete te;
//    }
//};
//
void FlockingCollectionEntity::addFlock(UITouch * touch, GLfloat x, GLfloat y)
{
    std::vector<YEntity *>::iterator it = children.begin();
    Flock * fe = (Flock *)(*it);
    while (fe->active)
    {
        it++;
        fe = (Flock *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    fe->active = true;
    fe->_touch = touch;
    fe->_centerMass.set(x, y, 0);
};
//
//void FlockingCollectionEntity::updateFlocking(UITouch * Flocking, GLfloat x, GLfloat y)
//{
//    std::vector<YEntity *>::iterator it = children.begin();
//    FlockingEntity * fe = (FlockingEntity *)(*it);
//    while (fe->_Flocking != Flocking)
//    {
//        it++;
//        fe = (FlockingEntity *)(*it);
//        if (it == children.end()) {
//            return;
//        }
//    }
//    fe->loc.set(x, y, 0);
//};
//
//void FlockingCollectionEntity::removeFlocking(UITouch * Flocking)
//{
//    std::vector<YEntity *>::iterator it = children.begin();
//    FlockingEntity * fe = (FlockingEntity *)(*it);
//    while (fe->_Flocking != Flocking)
//    {
//        it++;
//        fe = (FlockingEntity *)(*it);
//        if (it == children.end()) {
//            return;
//        }
//    }
//    fe->loc.setAll(0);
//    fe->active = false;
//    fe->_Flocking = nullptr;
//};
