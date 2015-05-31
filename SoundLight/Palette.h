//
//  Palette.h
//  SoundLight
//
//  Created by Jeremy Quentin on 10/05/2014.
//  Copyright (c) 2014 Jeremy Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface Palette : NSObject
@property UIColor * bg;
@property NSArray * colors;
-(id) initWithBackground:(UIColor *)bg andColors:(NSArray *)colors;
//+(instancetype)initWithBackground:(UIColor *)bg andColors:(NSArray *)colors;
@end
