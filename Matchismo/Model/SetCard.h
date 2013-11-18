//
//  SetCard.h
//  Matchismo
//
//  Created by Bob Voorneveld on 15-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "Card.h"

typedef enum {
    SetCardColorOne = 1,
    SetCardColorTwo,
    SetCardColorThree
    }SetCardColors;

typedef enum {
    SetCardShadeOne = 1,
    SetCardShadeTwo,
    SetCardShadeThree
}SetCardShading;

@interface SetCard : Card

@property (nonatomic) SetCardColors color;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) SetCardShading shading;
@property (nonatomic) NSUInteger numberOfSymbols;

+ (NSArray *)validSymbols;
+ (NSUInteger)maxNumberOfSymbols;

@end
