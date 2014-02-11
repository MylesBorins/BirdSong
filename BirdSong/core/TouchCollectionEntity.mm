//
//  TouchCollectionEntity.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/11/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "TouchCollectionEntity.h"

TouchCollectionEntity::TouchCollectionEntity(int count)
{
    for (int i = 0; i < count; i++)
    {
        TouchEntity * te = new TouchEntity();
        te->active = false;
        // reset transparency
        te->alpha = 1.0;
        // set location
        te->loc.setAll(0);
        // set color
        te->col.setAll(1);
        // set scale
        te->sca.setAll( 0.6 );
        // assign touch
        te->_touch = nullptr;
        addChild(te);
    }
};

TouchCollectionEntity::~TouchCollectionEntity()
{
    
};

void TouchCollectionEntity::addTouch(UITouch * touch, GLfloat x, GLfloat y)
{
    std::vector<YEntity *>::iterator it = children.begin();
    TouchEntity * te = (TouchEntity *)(*it);
    while (te->active)
    {
        it++;
        te = (TouchEntity *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    te->active = true;
    te->_touch = touch;
    te->loc.set(x, y, 0);
};

void TouchCollectionEntity::updateTouch(UITouch * touch, GLfloat x, GLfloat y)
{
    std::vector<YEntity *>::iterator it = children.begin();
    TouchEntity * te = (TouchEntity *)(*it);
    while (te->_touch != touch)
    {
        it++;
        te = (TouchEntity *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    te->loc.set(x, y, 0);
};

void TouchCollectionEntity::removeTouch(UITouch * touch)
{
    std::vector<YEntity *>::iterator it = children.begin();
    TouchEntity * te = (TouchEntity *)(*it);
    while (te->_touch != touch)
    {
        it++;
        te = (TouchEntity *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    te->loc.setAll(0);
    te->active = false;
    te->_touch = nullptr;
};
