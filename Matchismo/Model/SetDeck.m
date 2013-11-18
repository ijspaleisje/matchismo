//
//  SetDeck.m
//  Matchismo
//
//  Created by Bob Voorneveld on 15-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (int color = SetCardColorOne; color <= SetCardColorThree; color++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (int shade = SetCardShadeOne; shade <= SetCardShadeThree; shade++ ) {
                    for (NSUInteger numberOfSymbols = 1; numberOfSymbols <= [SetCard maxNumberOfSymbols]; numberOfSymbols++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shade;
                        card.numberOfSymbols = numberOfSymbols;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
