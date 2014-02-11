//
//  touchEntity.h
//  BirdSong
//
//  Created by thealphanerd on 2/4/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__touchEntity__
#define __BirdSong__touchEntity__

#include <iostream>
#include <vector>
#import "y-entity.h"
#import "Texture.h"

class TouchEntity : public YEntity
{
public:
    TouchEntity();
    ~TouchEntity();
    
public:
    UITouch* m_touch;
    static Texture * texture;
};


#endif /* defined(__BirdSong__touchEntity__) */
