//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Bob Voorneveld on 02-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "GameScore.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck withNumberOfCards:(NSUInteger)nCards andGameType:(NSString *)gameType;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSDictionary *)lastMoveDescription;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, strong, readonly) NSMutableArray *historyOfMoves;

@end
