//
//  FlockingCollectionEntity.h
//  BirdSong
//
//  Created by thealphanerd on 2/17/14.
//  Copyright (c) 2014 Myles Borins. All rights reserved.
//

#ifndef __BirdSong__FlockingCollectionEntity__
#define __BirdSong__FlockingCollectionEntity__

#include <iostream>
#import "y-entity.h"
#import "Globals.h"
#import "FlockingEntity.h"

class FlockingCollectionEntity : public YEntity
{
public:
    // constructor
    FlockingCollectionEntity(int count);
    // destructor
//    ~FlockingCollectionEntity();
    
public:
    void addFlock(UITouch * touch, GLfloat x, GLfloat y);
    void updateFlock(UITouch * touch, GLfloat x, GLfloat y);
//    void lockFlock(UITouch * touch, GLfloat x, GLfloat y);
//    void removeFlock(GLfloat x, GLfloat y);
    void removeFlock(UITouch * touch);
public:
    
    // update
    // void update( YTimeInterval dt);
    // void render();

};
#endif /* defined(__BirdSong__FlockingCollectionEntity__) */
