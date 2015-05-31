//
//  GameOverScene.h
//  SoundLight
//
//  Created by Jeremy Quentin on 10/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverScene : SKScene
@property SKLabelNode * scoreLabel;
@property SKLabelNode * bestScoreLabel;
@property int bestScoreLabelCurrentValue;
@property int score;
@property int targetScore;
@property SKAction * sound;
-(id)initWithSize:(CGSize)size background:(UIColor *)bgCol andText:(UIColor *)textCol andScore:(int)score andSound:(SKAction *)sound;
-(void)increaseScore;
@end
