//
//  Globals.h
//  BirdSong
//
//  Created by thealphanerd on 1/29/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__Globals__
#define __BirdSong__Globals__

#include <iostream>
#import "mo_audio.h"
#import "mo_gfx.h"
#import "SceneGraph.h"
#import "TouchEntity.h"

using namespace std;

#define SRATE 24000
#define FRAMESIZE 512
#define NUM_CHANNELS 2
#define NUM_ENTITIES 200

// forward reference
class BirdSongSim;

class Globals
{
public:
    // global variables
    static GLfloat waveformWidth;
    static GLfloat gfxWidth;
    static GLfloat gfxHeight;
    
    // texture
    static GLuint * texture;
    
    // top level root simulation
    static SceneGraph * graph;
    
    // to keep track of touches
    static vector<TouchEntity *> touches;
    
    // colors
    static Vector3D ourWhite;
    static Vector3D ourRed;
    static Vector3D ourBlue;
    static Vector3D ourOrange;
    static Vector3D ourGreen;
    static Vector3D ourGray;
    static Vector3D ourYellow;
    static Vector3D ourSoftYellow;
    static Vector3D ourPurple;
    
};

#endif /* defined(__BirdSong__Globals__) */