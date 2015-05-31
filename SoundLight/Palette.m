//
//  Palette.m
//  SoundLight
//
//  Created by Jeremy Quentin on 10/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import "Palette.h"

@implementation Palette

-(id) initWithBackground:(UIColor *)bg andColors:(NSArray *)colors
{
    self = [super init];
    self.bg = bg;
    self.colors = colors;
    return self;
}

//+(instancetype)initWithBackground:(UIColor *)bg andColors:(NSArray *)colors
//{
//    Palette * res = [NSObject init];
//    res.bg = bg;
//    res.colors = colors;
//    return res;
//}

@end
