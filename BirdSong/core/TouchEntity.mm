//
//  touchEntity.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/4/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "TouchEntity.h"

Texture * TouchEntity::texture = nullptr;

TouchEntity::TouchEntity()
{
    this->texture = new Texture(true);
    this->addChild(this->texture);
}

TouchEntity::~TouchEntity()
{
    delete this->texture;
}