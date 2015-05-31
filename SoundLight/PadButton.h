//
//  PadButton.h
//  SoundLight
//
//  Created by Jeremy Quentin on 08/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static inline float lerpf(float a, float b, NSTimeInterval start, NSTimeInterval end, NSTimeInterval t)
{
    return a + (b - a) * (t - start) / (end - start);
}

static inline UIColor * lerpc(UIColor * c1, UIColor * c2, NSTimeInterval start, NSTimeInterval end, NSTimeInterval t)
{
    CGFloat h1, s1, b1, a1, h2, s2, b2, a2;
    [c1 getHue:&h1 saturation:&s1 brightness:&b1 alpha:&a1];
    [c2 getHue:&h2 saturation:&s2 brightness:&b2 alpha:&a2];
    float h = lerpf(h1, h2, start, end, t);
    float s = lerpf(s1, s2, start, end, t);
    float b = lerpf(b1, b2, start, end, t);
    return [UIColor colorWithHue:h saturation:s brightness:b alpha:1];
}


@interface PadButton : SKSpriteNode
@property NSTimeInterval timeFired;
@property BOOL fired;
@property SKSpriteNode * fireSprite;
@property NSArray * colors;
@property NSTimeInterval lastTimeColor;
@property NSTimeInterval nextTimeColor;
@property UIColor * lastColor;
@property UIColor * nextColor;
@property SKAction * unfireSound;
@property int index;
-(void)fireAtTime:(NSTimeInterval)timeFired withSound:(SKAction *)sound;
-(void)unFire;
+(instancetype)initAtPosition:(CGPoint)position withColors:(NSArray *)colors andBackground:(UIColor *)bgColor andSize:(NSInteger)size andIndex:(int)index;
-(void)updateColor:(NSTimeInterval)currentTime;
+(UIColor *)fireColorFor:(UIColor *)color;
-(void)shake;
@end
