//
//  TouchPool.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/11/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "TouchPool.h"

TouchPool::TouchPool(int count)
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
        te->sca.setAll( 0.3 );
        // assign touch
        te->_touch = nullptr;
        addChild(te);
    }
};

TouchPool::~TouchPool()
{
    for (std::vector<YEntity *>::iterator it = children.begin(); it != children.end(); it++)
    {
        TouchEntity * te = (TouchEntity *)(*it);
        delete te;
    }
};

void TouchPool::addTouch(UITouch * touch, GLfloat x, GLfloat y)
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

void TouchPool::updateTouch(UITouch * touch, GLfloat x, GLfloat y)
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

void TouchPool::removeTouch(UITouch * touch)
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
