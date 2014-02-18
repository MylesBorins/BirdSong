//
//  FlockPool.h
//  BirdSong
//
//  Created by thealphanerd on 2/17/14.
//  Copyright (c) 2014 Myles Borins. All rights reserved.
//

#ifndef __BirdSong__FlockPool__
#define __BirdSong__FlockPool__

#include <iostream>
#include <math.h>
#import "y-entity.h"
#import "FlockingEntity.h"

class FlockPool : public YEntity
{
public:
    // constructor
    FlockPool(int count);
    // destructor
//    ~FlockPool();
    
public:
    void touched(UITouch * touch, GLfloat x, GLfloat y);
    void addFlock(Flock * flock, UITouch * touch, GLfloat x, GLfloat y);
    void updateFlock(UITouch * touch, GLfloat x, GLfloat y);
    void lockFlock(UITouch * touch);
    void removeFlock(Flock * flock);
//    void removeFlock(UITouch * touch);
public:
    
    // update
    // void update( YTimeInterval dt);
    // void render();

};
#endif /* defined(__BirdSong__FlockPool__) */
