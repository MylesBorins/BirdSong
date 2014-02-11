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
                Globals::touches->addTouch(touch, x, y);
                break;
            }
            case UITouchPhaseStationary:
            {
                break;
            }
            case UITouchPhaseMoved:
            {
                Globals::touches->updateTouch(touch, x, y);
                break;
            }
                // ended or cancelled
            case UITouchPhaseEnded:
            case UITouchPhaseCancelled:
            {
                Globals::touches->removeTouch(touch);
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