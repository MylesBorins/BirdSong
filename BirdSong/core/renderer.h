//
//  renderer.h
//  BirdSong
//
//  Created by Ge Wang on 1/21/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#ifndef __BirdSong__renderer__
#define __BirdSong__renderer__

#import "mo_audio.h"
#import "mo_gfx.h"
#import "mo_touch.h"
#import "y-entity.h"
#import "Globals.h"
#import "SceneGraph.h"
#import "Texture.h"
#import <vector>

// initialize the engine (audio, grx, interaction)
void BirdSongInit();
// TODO: cleanup
// set graphics dimensions
void BirdSongSetDims( GLfloat width, GLfloat height );
// draw next frame of graphics
void BirdSongRender();



#endif /* defined(__BirdSong__renderer__) */
