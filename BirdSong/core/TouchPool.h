//
//  TouchPool.h
//  BirdSong
//
//  Created by thealphanerd on 2/11/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__TouchPool__
#define __BirdSong__TouchPool__

#include <iostream>
#include <vector>
#include "y-entity.h"
#include "TouchEntity.h"
#include "mo_touch.h"

class TouchPool : public YEntity
{
public:
    TouchPool(int count);
    ~TouchPool();
    
public:
    void addTouch(UITouch * touch, GLfloat x, GLfloat y);
    void updateTouch(UITouch * touch, GLfloat x, GLfloat y);
    void removeTouch(UITouch * touch);
};

#endif /* defined(__BirdSong__TouchPool__) */
