//
//  SetCard.m
//  Matchismo
//
//  Created by Bob Voorneveld on 15-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    SetCard *otherCardOne = otherCards[0];
    SetCard *otherCardTwo = otherCards[1];
    
    if ((self.color == otherCardOne.color && self.color == otherCardTwo.color) ||
        
        (self.color != otherCardOne.color &&
         self.color != otherCardTwo.color &&
         otherCardOne.color != otherCardTwo.color)) {
        
        if ((self.shading  == otherCardOne.shading && self.shading == otherCardTwo.shading) ||
            
            (self.shading != otherCardOne.shading &&
             self.shading != otherCardTwo.shading &&
             otherCardOne.shading != otherCardTwo.shading)) {
    
            if (([self.symbol isEqualToString:otherCardOne.symbol] && [self.symbol isEqualToString:otherCardTwo.symbol]) ||
                
                (![self.symbol isEqualToString:otherCardOne.symbol] &&
                 ![self.symbol isEqualToString:otherCardTwo.symbol] &&
                 ![otherCardOne.symbol isEqualToString:otherCardTwo.symbol])) {
                
                if ((self.numberOfSymbols == otherCardOne.numberOfSymbols && self.numberOfSymbols == otherCardTwo.numberOfSymbols) ||
                    
                    (self.numberOfSymbols != otherCardOne.numberOfSymbols &&
                     self.numberOfSymbols != otherCardTwo.numberOfSymbols &&
                     otherCardOne.numberOfSymbols != otherCardTwo.numberOfSymbols)) {
                    
                    score = 4;
                    
                }
                
            }
            
        }

    }
    
    return score;
}


+ (NSArray *)validSymbols
{
    return @[@"■", @"●",@"▲"];
}

+ (NSUInteger)maxNumberOfSymbols
{
    return 3;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%@:%u:%u:%d", self.symbol, self.color, self.shading, self.numberOfSymbols];
}

@end
