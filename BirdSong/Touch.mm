//
//  Touch.cpp
//  BirdSong
//
//  Created by thealphanerd on 1/30/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#include "Touch.h"

//-----------------------------------------------------------------------------
// name: touch_callback()
// desc: the touch call back
//-----------------------------------------------------------------------------
void touch_callback( NSSet * touches, UIView * view,
                    std::vector<MoTouchTrack> & tracks,
                    void * data)
{
    // points
    CGPoint pt;
    CGPoint prev;
    
    // number of touches in set
//    NSUInteger n = [touches count];
    
    // iterate over all touch events
    for( UITouch * touch in touches )
    {
        // get the location (in window)
        pt = [touch locationInView:view];
        prev = [touch previousLocationInView:view];
        
        GLfloat ratio = Globals::gfxWidth / Globals::gfxHeight;
        GLfloat x = (pt.y / Globals::gfxWidth * 2 * ratio) - ratio;
        GLfloat y = (pt.x / Globals::gfxHeight * 2 ) - 1;
        
        // check the touch phase
        switch( touch.phase )
        {
                // begin
            case UITouchPhaseBegan:
            {
                if (Globals::touches.size() < 3)
                {
                    // make a new touch entity
                    TouchEntity * e = new TouchEntity();
                    // check
                    if( e != NULL )
                    {
                        // append
                        Globals::graph->root().addChild(e);
                        Globals::touches.push_back(e);
                        // active
                        e->active = true;
                        // reset transparency
                        e->alpha = 1.0;
                        // set location
                        e->loc.set( x, y, 0 );
                        // set color
                        e->col.set( 1, 1, 1 );
                        // set scale
                        e->sca.setAll( 0.6 );
                        // assign touch
                        e->m_touch = touch;
                    }
                }
                break;
            }
            case UITouchPhaseStationary:
            {
                break;
            }
            case UITouchPhaseMoved:
            {
                for( vector<TouchEntity *>::iterator ei = Globals::touches.begin();
                    ei!= Globals::touches.end(); ei++ )
                {
                    TouchEntity * touchEntity = (TouchEntity *)(*ei);
                    if (touchEntity->m_touch == touch)
                    {
                        touchEntity->loc.x = x;
                        touchEntity->loc.y = y;
                    }
                }
                break;
            }
                // ended or cancelled
            case UITouchPhaseEnded:
            {
                for (vector<TouchEntity*>::iterator it = Globals::touches.begin() ; it != Globals::touches.end(); ++it) {
                    TouchEntity * te = (TouchEntity *)(*it);
                    if ( te  && te->m_touch == touch ) {
                        te->active = false;
                        Globals::touches.erase(it);
                        break;
                    }
                }
                break;
            }
            case UITouchPhaseCancelled:
            {
                break;
            }
                // should not get here
            default:
                break;
        }
    }
}

void NoireTouchInit()
{
    MoTouch::addCallback( touch_callback, NULL );
}