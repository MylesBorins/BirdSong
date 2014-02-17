//
//  renderer.cpp
//  BirdSong
//
//  Created by Ge Wang on 1/21/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#import "renderer.h"

std::vector<YEntity *> g_entities;

// function prototypes
void renderEntities();
void BirdSongInitGraph();
YEntity * getFreeEntity();

// initialize the engine (audio, grx, interaction)
void BirdSongInit()
{
    NSLog( @"init..." );
    
    // generate texture name
    glGenTextures( 1, Globals::texture );
    // bind the texture
    glBindTexture( GL_TEXTURE_2D, *Globals::texture );
    // setting parameters
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    
    // Init simulation
    BirdSongInitGraph();
    
    // load the texture
    MoGfx::loadTexture( @"texture", @"png" );
}

// initialize the simulation()
void BirdSongInitGraph()
{
    // instantiate simulation
    Globals::graph = new SceneGraph();
    YEntity * root = &Globals::graph->root();
    Globals::touches = new TouchPool(10);
    root->addChild(Globals::touches);
    
    vector<Flock *> flockVector;
    
    for (int i = 0; i < 3; i++)
    {
        Flock * flock = new Flock;
        flock->init(10);
        root->addChild(flock);
    }
}

// set graphics dimensions
void BirdSongSetDims( GLfloat width, GLfloat height )
{
    NSLog( @"set dims: %f %f", width, height );
    Globals::gfxWidth = width;
    Globals::gfxHeight = height;
    
    Globals::waveformWidth = width / height * 1.9;
}

// draw next frame of graphics
void BirdSongRender()
{
    // refresh current time reading
    MoGfx::getCurrentTime( true );
    
    
    // projection
    glMatrixMode( GL_PROJECTION );
    // reset
    glLoadIdentity();
    // alternate
    GLfloat ratio = Globals::gfxWidth / Globals::gfxHeight;
    glOrthof( -ratio, ratio, -1, 1, -1, 1 );
    // orthographic
    // glOrthof( -g_gfxWidth/2, g_gfxWidth/2, -g_gfxHeight/2, g_gfxHeight/2, -1.0f, 1.0f );
    // modelview
    glMatrixMode( GL_MODELVIEW );
    // reset
    // glLoadIdentity();
    
    glClearColor( 0, 0, 0, 1 );
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    // push
    glPushMatrix();
    
    // cascade simulation
    Globals::graph->systemCascade();

    // pop
    glPopMatrix();
}
