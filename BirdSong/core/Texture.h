//
//  Pinabll.h
//  BirdSong
//
//  Created by thealphanerd on 1/29/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__Texture__
#define __BirdSong__Texture__

#include <iostream>
#include "mo_gfx.h"
#include "y-entity.h"

class Texture : public YEntity
{
public:
    Texture(){};
    Texture(bool blend);
    
public:
    static bool m_blend;

public:
    void render( );
};

#endif /* defined(__BirdSong__Texture__) */
