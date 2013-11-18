//
//  Deck.h
//  Matchismo
//
//  Created by Bob Voorneveld on 02-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
