//
//  PadButton.m
//  SoundLight
//
//  Created by Jeremy Quentin on 08/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import "PadButton.h"
#import "UIColor_HSVAdditions.h"
#import "Palette.h"

@implementation PadButton

//-(BOOL) collision

+(instancetype)initAtPosition:(CGPoint)position withColors:(NSArray *)colors andBackground:(UIColor *)bgColor andSize:(NSInteger)size andIndex:(int)index
{
    PadButton * button = [PadButton spriteNodeWithImageNamed:@"Square"];
    button.position = position;
    button.size = CGSizeMake(size, size);
    button.anchorPoint = CGPointMake(0, 0);
    button.colors = colors;
    button.lastColor = bgColor;
    UIColor * c = colors[arc4random()%colors.count];
    button.color = bgColor;
    button.nextColor = c;
    button.colorBlendFactor = 1;
    button.fireSprite = [SKSpriteNode spriteNodeWithImageNamed:@"fire"];
    button.fireSprite.anchorPoint = CGPointMake(0, 0);
    button.fireSprite.size = CGSizeMake(size, size);
    CGFloat h, s, b, a;
    [c getHue:&h saturation:&s brightness:&b alpha:&a];
    button.fireSprite.color = [UIColor colorWithHue:h saturation:s brightness:b+0.2 alpha:1];
    button.fireSprite.colorBlendFactor = 1;
    button.index = index;
    return button;
}

-(void)fireAtTime:(NSTimeInterval)timeFired withSound:(SKAction *)sound
{
    self.fired = true;
    self.timeFired = timeFired;
    self.unfireSound = sound;
    if (self.fireSprite.parent == nil)
        [self addChild:self.fireSprite];
}
-(void)unFire
{
    [self runAction:self.unfireSound];
    self.fired = false;
    [self.fireSprite removeFromParent];
}
-(void)updateColor:(NSTimeInterval)currentTime
{
    if(currentTime >= self.lastTimeColor)
    {
        UIColor * c = lerpc(self.lastColor, self.nextColor, self.lastTimeColor, self.nextTimeColor, currentTime);
        self.color = c;
        self.fireSprite.color = [PadButton fireColorFor:c];
        if (currentTime >= self.nextTimeColor)
        {
            self.lastTimeColor = currentTime + ((float)(arc4random()%20))/2+5;
            self.nextTimeColor = self.lastTimeColor + 8;
            self.lastColor = self.nextColor;
            self.nextColor = self.colors[arc4random()%self.colors.count];
        }
    }
}
+(UIColor *)fireColorFor:(UIColor *)color
{
    CGFloat h, s, b, a;
    [color getHue:&h saturation:&s brightness:&b alpha:&a];
//    return [UIColor colorWithHue:1 saturation:0 brightness:1 alpha:0.7];
    return [UIColor colorWithHue:h saturation:((b>=0.6) ? s-(b-0.6)*1.5 : s) brightness:b+0.4 alpha:1];
}

-(void)shake
{
    NSInteger times = 8;
    CGPoint initialPoint = self.position;
    NSInteger amplitudeX = 10;
    NSInteger amplitudeY = 2;
    NSMutableArray * randomActions = [NSMutableArray array];
    for (int i=0; i<times; i++) {
        NSInteger dx = arc4random() % amplitudeX;
        NSInteger dy = arc4random() % amplitudeY;
        NSInteger randX = self.position.x+dx - amplitudeX/2;
        NSInteger randY = self.position.y+dy - amplitudeY/2;
        SKAction *action = [SKAction moveTo:CGPointMake(randX, randY) duration:0.02*dx/amplitudeX];
        [randomActions addObject:action];
    }
    SKAction *action = [SKAction moveTo:initialPoint duration:0.03];
    [randomActions addObject:action];
    
    SKAction *rep = [SKAction sequence:randomActions];
    [self runAction:rep];
}
@end
