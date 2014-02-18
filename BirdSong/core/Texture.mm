//
//  Texture.cpp
//  BirdSong
//
//  Created by thealphanerd on 1/29/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "Texture.h"
#include "Globals.h"

static const GLfloat squareVertices[] = {
    -0.5f,  -0.5f,
    0.5f,  -0.5f,
    -0.5f,   0.5f,
    0.5f,   0.5f,
};

static const GLfloat normals[] = {
    0, 0, 1,
    0, 0, 1,
    0, 0, 1,
    0, 0, 1
};

static const GLfloat texCoords[] = {
    0, 1,
    1, 1,
    0, 0,
    1, 0
};

Texture::Texture(bool blend)
{
    m_blend = blend;
}

bool Texture::m_blend = false;

// render
void Texture::render( )
{
    if ( Globals::texture != NULL)
    {
        glPushMatrix();
        
        // enable texture mapping
        glEnable( GL_TEXTURE_2D );
        // enable blending
        glEnable( GL_BLEND );

        glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
        
        // bind the texture
        glBindTexture( GL_TEXTURE_2D, *Globals::texture );
        
        // set color
        glColor4f( col.x, col.y, col.z, alpha );
        
        // vertex
        glVertexPointer( 2, GL_FLOAT, 0, squareVertices );
        glEnableClientState(GL_VERTEX_ARRAY );
        
        // texture coordinate
        glTexCoordPointer( 2, GL_FLOAT, 0, texCoords );
        glEnableClientState( GL_TEXTURE_COORD_ARRAY );
        
        // triangle strip
        glDrawArrays( GL_TRIANGLE_STRIP, 0, 4 );
        
        // disable blend
        glDisable( GL_BLEND );
        glDisable( GL_TEXTURE_2D );
        
        glPopMatrix();
    }
}
