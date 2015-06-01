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
-(id)initWithSounds:(NSMutableArray *)sounds andTime:(float)time
{
    if (self = [super init]) {
        self.sounds = sounds;
        self.timeBefore = time;
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
        SKAction * wait = [SKAction waitForDuration:1];
        SKAction * comb = [SKAction sequence:@[wait, inc]];
        
//        SKAction * ac = wait;
        
        NSMutableArray * actions = [[NSMutableArray alloc] init];
        
        [actions addObject:wait];
        for (SoundInfo * si in self.indSounds) {
            SKAction * wait = [SKAction waitForDuration:1*si.timeBefore];
            [actions addObject:wait];
            for (SKAction * a in si.sounds) {
                [actions addObject:a];
                [actions addObject:inc];
//                ac = [SKAction sequence:@[ac, a]];
//                ac = [SKAction sequence:@[ac, inc]];
            }
//            ac = [SKAction sequence:@[ac, wait]];
        }
        NSArray * actionsStatic = [actions copy];
        SKAction * ac = [SKAction sequence:actionsStatic];
        [self runAction:ac];
//        [self runAction:[SKAction repeatAction:comb count:score]];
    }
    return self;
}
-(void)increaseScore
{
    if (self.scoreLabel.parent == nil)
        [self addChild:self.scoreLabel];
//    [self runAction:self.indSounds[self.score]];
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
    [self runAction:self.sound];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.score == self.targetScore)
    {
        SKTransition * reveal = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:1.0];
        MyScene * gameScene = [[MyScene alloc] initWithSize: self.size];
        [self.scene.view presentScene: gameScene transition: reveal];
    }
    else
    {
        [self removeAllActions];
        [self setScoreDirectly:self.targetScore];
    }
}

@end
