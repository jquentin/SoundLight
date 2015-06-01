//
//  GameOverScene.m
//  SoundLight
//
//  Created by Jeremy Quentin on 10/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import "GameOverScene.h"
#import "MyScene.h"

@implementation SoundInfo
-(id)initWithSounds:(SKAction *)sound andTime:(float)time
{
    if (self = [super init]) {
        self.sound = sound;
        self.time = time;
    }
    return self;
}
@end

@implementation GameOverScene

-(id)initWithSize:(CGSize)size background:(UIColor *)bgCol andText:(UIColor *)textCol andScore:(int)score andSounds:(NSMutableArray *)sounds
{
    if (self = [super initWithSize:size]) {
//        self.backgroundColor = [UIColor blackColor];
        self.backgroundColor = bgCol;
        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        label.text = @"Game Over";
//        label.fontColor = [UIColor whiteColor];
        label.fontColor = textCol;
        label.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:label];
        self.score = 0;
        self.targetScore = score;
        self.indSounds = sounds;
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        self.scoreLabel.text = @"0";
        self.scoreLabel.fontColor = textCol;
        self.scoreLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 30);
        
        int oldHighScore = [[[ NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] intValue ];
        if (oldHighScore > 0)
        {
            
            SKLabelNode * bestLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
            bestLabel.text = @"Best";
            //        label.fontColor = [UIColor whiteColor];
            bestLabel.fontColor = textCol;
            bestLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 60);
            [self addChild:bestLabel];
            self.bestScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
            self.bestScoreLabel.text = [NSString stringWithFormat:@"%d", oldHighScore];
            self.bestScoreLabel.fontColor = textCol;
//            self.bestScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
//            self.bestScoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
            self.bestScoreLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 90);
            [self addChild:self.bestScoreLabel];
            self.bestScoreLabelCurrentValue = oldHighScore;
        }
        if (score > oldHighScore)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:score] forKey:@"HighScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        SKAction * inc = [SKAction performSelector:@selector(increaseScore) onTarget:self];
        
        for (SoundInfo * si in self.indSounds) {
            SKAction * wait = [SKAction waitForDuration:0.2 * si.time + 0.2];
            SKAction * ac = [SKAction sequence:@[wait, si.sound, inc]];
            [self runAction:ac];
        }
    }
    return self;
}
-(void)increaseScore
{
    if (self.scoreLabel.parent == nil)
        [self addChild:self.scoreLabel];
    self.score++;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    if (self.bestScoreLabel != nil && self.score > self.bestScoreLabelCurrentValue)
    {
        self.bestScoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
        self.bestScoreLabelCurrentValue = self.score;
    }
}

-(void)setScoreDirectly:(int)score
{
    if (self.scoreLabel.parent == nil)
        [self addChild:self.scoreLabel];
    self.score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    if (self.bestScoreLabel != nil && self.score > self.bestScoreLabelCurrentValue)
    {
        self.bestScoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
        self.bestScoreLabelCurrentValue = self.score;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.score == self.targetScore)
    {
        SKTransition * reveal = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:1.0];
        MyScene * gameScene = [[MyScene alloc] initWithSize: self.size];
        [self.scene.view presentScene: gameScene transition: reveal];
    }
    else if (self.score > 2)
    {
        [self removeAllActions];
        [self setScoreDirectly:self.targetScore];
    }
}

@end
