//
//  MyScene.h
//  SoundLight
//

//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PadButton.h"
#import "Palette.h"

@interface MyScene : SKScene
@property NSArray * pads;
@property int sizePad;
@property CFTimeInterval timeNextFire;
@property NSMutableArray * buttonsNextFire;
@property CFTimeInterval gameTime;
@property CFTimeInterval lastUpdateTime;
@property BOOL firstTime;
@property BOOL maskTriggered;
@property BOOL hasStartedPlaying;
@property BOOL hasStartedFiring;
@property NSArray * soundActions;
@property SKAction * soundError;
@property BOOL gameOver;
@property BOOL accel;
@property Palette * palette;
@property PadButton * buttonGameOver;
@property float gameSpeed;
@property int chanceDouble;
@property int chanceTriple;
@property int score;
@property SKSpriteNode * mask;
@property NSMutableArray * indSounds;
-(void) endGameBecauseOfButton:(PadButton *)button;
-(CGPoint)positionForButton:(int)index;
-(void) fireNextButton;

@end
