//
//  Card.m
//  Matchismo
//
//  Created by Bob Voorneveld on 02-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *otherCard in otherCards) {
        if ([otherCard.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSString *)description
{
    return self.contents;
}

@end
