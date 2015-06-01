//
//  GameOverScene.h
//  SoundLight
//
//  Created by Jeremy Quentin on 10/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface SoundInfo : NSObject

@property NSMutableArray * sounds;
@property float timeBefore;

-(id)initWithSounds:(NSMutableArray *)sounds andTime:(float)time;

@end

@interface GameOverScene : SKScene
@property SKLabelNode * scoreLabel;
@property SKLabelNode * bestScoreLabel;
@property int bestScoreLabelCurrentValue;
@property int score;
@property int targetScore;
@property SKAction * sound;
@property NSMutableArray * indSounds;
-(id)initWithSize:(CGSize)size background:(UIColor *)bgCol andText:(UIColor *)textCol andScore:(int)score andSounds:(NSMutableArray *)sounds;
-(void)increaseScore;
@end
