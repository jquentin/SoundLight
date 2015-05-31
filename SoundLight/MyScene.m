//
//  MyScene.m
//  SoundLight
//
//  Created by Jeremy Quentin on 08/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import "MyScene.h"
#import "PadButton.h"
#import "Palette.h"
#import "GameOverScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.indSounds = [[NSMutableArray alloc] init];
        self.firstTime = true;
        self.maskTriggered = false;
        self.gameOver = false;
        self.hasStartedPlaying = false;
        self.hasStartedFiring = false;
        self.score = 0;
        self.gameTime = 0.0;
        [self UpdateDifficulty];
        Palette * palette1 = [[Palette alloc] initWithBackground:[UIColor blackColor] andColors :
         [NSArray arrayWithObjects:
           UIColorFromRGB(0x1aa758),
           UIColorFromRGB(0x16834a),
           UIColorFromRGB(0x4f4955),
           UIColorFromRGB(0x3c2e48),
          nil ]];
        Palette * palette2 = [[Palette alloc] initWithBackground:UIColorFromRGB(0xFFEDBC) andColors :
                             [NSArray arrayWithObjects:
                              UIColorFromRGB(0x57385C),
                              UIColorFromRGB(0xA75265),
                              UIColorFromRGB(0xEC7263),
                              UIColorFromRGB(0xFEBE7E),
                              nil ]];
        Palette * palette3 = [[Palette alloc] initWithBackground:UIColorFromRGB(0x0B486B) andColors :
                              [NSArray arrayWithObjects:
                               UIColorFromRGB(0xCFF09E),
                               UIColorFromRGB(0xA8DBA8),
                               UIColorFromRGB(0x79BD9A),
                               UIColorFromRGB(0x3B8686),
                               nil ]];
        Palette * palette4 = [[Palette alloc] initWithBackground:UIColorFromRGB(0xBED4DF) andColors :
                              [NSArray arrayWithObjects:
                               UIColorFromRGB(0x78A3B9),
                               UIColorFromRGB(0x4C5D75),
                               UIColorFromRGB(0x323E4E),
                               UIColorFromRGB(0x2D3032),
                               nil ]];
        Palette * palette5 = [[Palette alloc] initWithBackground:UIColorFromRGB(0x9FA3A6) andColors :
                              [NSArray arrayWithObjects:
                               UIColorFromRGB(0xE4F087),
                               UIColorFromRGB(0xC6CF5D),
                               UIColorFromRGB(0xA8A844),
                               UIColorFromRGB(0x828700),
                               nil ]];
        NSArray * palettes = [NSArray arrayWithObjects:palette1, palette2, palette3, palette4, palette5, nil];
        Palette * palette = palettes[arc4random()%palettes.count];
        self.palette = palette;
        self.backgroundColor = palette.bg;
        self.buttonsNextFire = [NSMutableArray array];
        int sizePad = 92 * self.size.width / 320;
        self.pads = [NSArray arrayWithObjects:
                     [PadButton initAtPosition:[self positionForButton:0] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:0],
                     [PadButton initAtPosition:[self positionForButton:1] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:1],
                     [PadButton initAtPosition:[self positionForButton:2] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:2],
                     [PadButton initAtPosition:[self positionForButton:3] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:3],
                     [PadButton initAtPosition:[self positionForButton:4] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:4],
                     [PadButton initAtPosition:[self positionForButton:5] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:5],
                     [PadButton initAtPosition:[self positionForButton:6] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:6],
                     [PadButton initAtPosition:[self positionForButton:7] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:7],
                     [PadButton initAtPosition:[self positionForButton:8] withColors:palette.colors andBackground:palette.bg andSize:sizePad andIndex:8],
                     nil ];
        
        for (int i = 0 ; i < self.pads.count ; i++)
        {
            [self addChild:self.pads[i]];
        }
        NSArray * soundPalettes = [NSArray arrayWithObjects:
                                   [NSArray arrayWithObjects:
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/1-c3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/2-d3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/3-e3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/4-g3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/5-a3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/6-c4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/7-d4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/8-e4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/ThumbPiano/9-g4.wav" waitForCompletion:false],
                                    nil],
                                   [NSArray arrayWithObjects:
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/1-a2.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/2-c3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/3-d3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/4-e3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/5-g3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/6-a3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/7-c4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/8-d4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/LatelyBass/9-e4.wav" waitForCompletion:false],
                                    nil],
                                   [NSArray arrayWithObjects:
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/1-c3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/2-d3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/3-e3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/4-g3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/5-a3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/6-c4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/7-d4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/8-e4.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Marimba/9-g4.wav" waitForCompletion:false],
                                    nil],
                                   [NSArray arrayWithObjects:
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/1-g1.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/2-a1.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/3-c2.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/4-d2.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/5-e2.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/6-g2.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/7-a2.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/8-c3.wav" waitForCompletion:false],
                                    [SKAction playSoundFileNamed:@"sounds/Xylo/9-d3.wav" waitForCompletion:false],
                                    nil],
                                   nil];
        self.soundActions = (NSArray *)soundPalettes[arc4random() % soundPalettes.count];
//        self.soundError = [SKAction playSoundFileNamed:@"sounds/wrong_guitar.wav" waitForCompletion:false];
        float delay = 0.05;
        self.soundError = [SKAction sequence:@[self.soundActions[5], [SKAction waitForDuration:delay], self.soundActions[4], [SKAction waitForDuration:delay], self.soundActions[3], [SKAction waitForDuration:delay], self.soundActions[2], [SKAction waitForDuration:delay], self.soundActions[1], [SKAction waitForDuration:delay], self.soundActions[0], [SKAction waitForDuration:delay]]];
        
        self.mask = [SKSpriteNode spriteNodeWithImageNamed:@"Mask"];
//        self.mask.anchorPoint = CGPointMake(0, 0);
        CGPoint maskPos = [self positionForButton:1];
        self.mask.position = CGPointMake(maskPos.x + sizePad / 2, maskPos.y + sizePad / 2);
        self.mask.size = CGSizeMake(sizePad * 8, sizePad * 8);
        self.mask.alpha = 0.0;
        [self addChild:self.mask];
    }
    return self;
}

-(CGPoint)positionForButton:(int)index{
    int decal1 = 14 * self.size.width / 320;
    int decal2 = (14+92+8) * self.size.width / 320;
    int decal3 = (14+92+8+92+8) * self.size.width / 320;
    int decalDown = (self.size.height - self.size.width)/2;
    int resX;
    switch (index % 3){
        case 0:
            resX = decal1;
            break;
        case 1:
            resX = decal2;
            break;
        case 2:
            resX = decal3;
            break;
        default:
            resX = 0;
    }
    int resY;
    switch (index / 3){
        case 0:
            resY = decalDown + decal1;
            break;
        case 1:
            resY = decalDown + decal2;
            break;
        case 2:
            resY = decalDown + decal3;
            break;
        default:
            resY = 0;
    }
    
    return CGPointMake(resX, resY);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.gameOver)
        return;
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        NSArray * touched = [self nodesAtPoint:location];
        for(SKNode * node in touched)
        {
            if ([node isKindOfClass:[PadButton class]])
            {
                PadButton * b = (PadButton *)node;
                if (b.fired)
                {
                    [b unFire];
                    self.score++;
                    [self UpdateDifficulty];
                    bool hasStarted = self.hasStartedPlaying;
                    self.hasStartedPlaying = true;
                    if (!hasStarted)
                    {
                        [self waitAndFire];
                        self.maskTriggered = false;
                        [self clearMask];
                    }
                    
                }
                else
                {
                    if (self.hasStartedFiring)
                        [self endGameBecauseOfButton:b];
                }
            }
        }
    }
}

-(void) loadNextFire
{
    [self loadNextFire:true];
}

-(void) loadNextFire:(bool) canBeDouble
{
    int nbToFire = 1;
    int chance = arc4random_uniform(100);
    if (canBeDouble)
    {
        if (chance < self.chanceTriple)
            nbToFire = 3;
        else if (chance < self.chanceTriple + self.chanceDouble)
            nbToFire = 2;
    }
    [self.buttonsNextFire removeAllObjects];
    NSMutableArray * indexes = [NSMutableArray array];
    for (int i = 0; i < nbToFire; i++) {
        int nbButtonToFire = arc4random()%self.pads.count;
        while (((PadButton *)self.pads[nbButtonToFire]).fired || [indexes containsObject:@(nbButtonToFire)])
        {
            nbButtonToFire = arc4random()%self.pads.count;
        }
        [indexes addObject:@(nbButtonToFire)];
        [self.buttonsNextFire addObject:self.pads[nbButtonToFire]];
    }
}

-(void) fireNextButton
{
    for (PadButton * button in self.buttonsNextFire) {
        [button fireAtTime:self.gameTime withSound:self.soundActions[button.index]];
        [self.indSounds addObject:(self.soundActions[button.index])];
    }
    self.hasStartedFiring = true;
    [self loadNextFire];
    if (!self.hasStartedPlaying)
        return;
    [self waitAndFire];
}

-(void) waitAndFire
{
    NSUInteger nbToFire = self.buttonsNextFire.count;
    [self waitAndFire:(nbToFire == 1 && arc4random()%2 == 0) ? 1/self.gameSpeed : 2/self.gameSpeed];
}

-(void) waitAndFire:(float) delay
{
    SKAction * wait = [SKAction waitForDuration:delay];
    SKAction * fire = [SKAction performSelector:@selector(fireNextButton) onTarget:self];
    SKAction * sequence = [SKAction sequence:@[wait, fire]];
    [self runAction:sequence];
}

-(void) endGameBecauseOfButton:(PadButton *)button
{
    self.gameOver = true;
    self.buttonGameOver = button;
    [button shake];
    SKAction *wait = [SKAction waitForDuration:0.3];
    SKAction * end = [SKAction performSelector:@selector(endGame) onTarget:self];
    SKAction * waitAndEnd = [SKAction sequence:@[wait, end]];
    [self runAction:waitAndEnd];
    [self runAction:self.soundError];
}

-(void)UpdateDifficulty
{
    int score = self.score;
    if (score < 50)
    {
        self.gameSpeed = 1.4;
        self.chanceDouble = 20;
        self.chanceTriple = 0;
    }
    else if (score < 100)
    {
        self.gameSpeed = 1.5;
        self.chanceDouble = 20;
        self.chanceTriple = 0;
    }
    else if (score < 200)
    {
        self.gameSpeed = 1.5;
        self.chanceDouble = 30;
        self.chanceTriple = 0;
    }
    else if (score < 300)
    {
        self.gameSpeed = 1.5;
        self.chanceDouble = 30;
        self.chanceTriple = 10;
    }
    else if (score < 400)
    {
        self.gameSpeed = 1.6;
        self.chanceDouble = 30;
        self.chanceTriple = 10;
    }
    else if (score < 500)
    {
        self.gameSpeed = 1.6;
        self.chanceDouble = 40;
        self.chanceTriple = 10;
    }
    else if (score < 600)
    {
        self.gameSpeed = 1.6;
        self.chanceDouble = 40;
        self.chanceTriple = 15;
    }
    else if (score < 700)
    {
        self.gameSpeed = 1.7;
        self.chanceDouble = 40;
        self.chanceTriple = 15;
    }
    else if (score < 800)
    {
        self.gameSpeed = 1.7;
        self.chanceDouble = 40;
        self.chanceTriple = 20;
    }
    else if (score < 900)
    {
        self.gameSpeed = 1.8;
        self.chanceDouble = 40;
        self.chanceTriple = 20;
    }
    else if (score < 1000)
    {
        self.gameSpeed = 1.8;
        self.chanceDouble = 40;
        self.chanceTriple = 20;
    }
    else if (score < 1200)
    {
        self.gameSpeed = 2.2;
        self.chanceDouble = 40;
        self.chanceTriple = 20;
    }
    else if (score < 1500)
    {
        self.gameSpeed = 2.5;
        self.chanceDouble = 40;
        self.chanceTriple = 20;
    }
    else
    {
        self.gameSpeed = 2.5;
        self.chanceDouble = 50;
        self.chanceTriple = 30;
    }
    
}

-(void) endGame
{
    self.gameOver = true;
    SKTransition * reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    GameOverScene * goScene = [[GameOverScene alloc] initWithSize: self.size background:self.backgroundColor andText:self.buttonGameOver.color andScore:self.score andSounds:self.indSounds];
    [self.scene.view presentScene: goScene transition: reveal];
}

-(void) initiateMask:(PadButton *)button
{
    int sizePad = 92 * self.size.width / 320;
    CGPoint maskPos = [button position];
    self.mask.position = CGPointMake(maskPos.x + sizePad / 2, maskPos.y + sizePad / 2);
    self.maskTriggered = true;
}

-(void) clearMask
{
    [self.mask removeFromParent];
}

-(void)update:(CFTimeInterval)currentTime {
    if (self.gameOver)
        return;
    float introTime = 3.0;
    float deltaTime = currentTime - self.lastUpdateTime;
    if (deltaTime > 0.5)
        deltaTime = 1.0 / 60.0;
    self.lastUpdateTime = currentTime;
    self.gameTime += deltaTime;
    if (self.firstTime)
    {
        for(PadButton * b in self.pads)
        {
            b.lastTimeColor = self.gameTime+0.5;
            b.nextTimeColor = b.lastTimeColor + introTime;
        }
        
        [self loadNextFire:false];
        
        [self waitAndFire:introTime + 0.5];
        
        self.firstTime = false;
    }
    for(PadButton * b in self.pads)
    {
        [b updateColor:self.gameTime];
        if(b.fired && self.gameTime - b.timeFired > 1)
        {
            if (!self.hasStartedPlaying)
            {
                if (self.maskTriggered)
                    self.mask.alpha = MIN(self.mask.alpha + deltaTime * 0.15, 0.7);
                else
                    [self initiateMask:b];
            }
            else
                [self endGameBecauseOfButton:b];
        }
    }
}

@end
