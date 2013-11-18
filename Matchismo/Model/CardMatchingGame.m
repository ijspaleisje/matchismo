//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Bob Voorneveld on 02-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "CardMatchingGame.h"
#import "GameScore.h"
#import "CardGameAppDelegate.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, strong, readwrite) NSMutableArray *historyOfMoves;
@property (nonatomic, strong) GameScore *highScore;
@property (nonatomic) NSUInteger numberOfCardsGame;
@property (nonatomic, strong) NSString *gameType;

@end

@implementation CardMatchingGame

- (NSInteger)misMatchPenalty
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:MISMATCH_PENALTY_KEY];
}

- (NSInteger)matchBonus
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:MATCHBONUS_KEY];
}

- (NSInteger)costToChoose
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:COST_TO_CHOOSE_KEY];
}

- (void)setScore:(NSInteger)score
{
    _score = score;
    [self.highScore updateScore:@(self.score)];
}

- (GameScore *)highScore
{
    if (!_highScore) _highScore = [[GameScore alloc] initWithGameType:self.gameType];
    
    return _highScore;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [NSMutableArray array];
    return _cards;
}

- (NSString *)lastMoveDescription
{
    return [self.historyOfMoves lastObject];
}

- (NSMutableArray *)historyOfMoves
{
    if (!_historyOfMoves) _historyOfMoves = [NSMutableArray array];
    return _historyOfMoves;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck withNumberOfCards:(NSUInteger)nCards andGameType:(NSString *)gameType
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.numberOfCardsGame = nCards;
        self.gameType = gameType;
        [self.historyOfMoves addObject:@{@"action": @"firstCard"}];
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    // kaart nog actief?
    if (!card.isMatched) {
        // kaart terugdraaien?
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            
            int score = 0;
            
            // vind opengedraaide kaarten
            NSMutableArray *otherCards = [NSMutableArray array];

            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            NSDictionary *moveDescription =  @{ @"action": @"picked",
                                                @"card" : card,
                                                @"points" : @([self costToChoose])};
            
            // moeten we matchen?
            if (self.numberOfCardsGame == [otherCards count]+1) {
                
                int matchScore = [card match:otherCards];
                
                // is er gescoord?
                if (matchScore) {
                    // score optellen
                    score += matchScore * self.matchBonus;
                    
                    // kaarten vastleggen
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                    
                    moveDescription = @{ @"action": @"matched",
                         @"cards" : [otherCards arrayByAddingObject:card],
                         @"points" : @(matchScore * [self matchBonus])};
                    
                } else {

                    moveDescription = @{ @"action": @"notMatched",
                                         @"cards" : [otherCards arrayByAddingObject:card],
                                         @"points" : @([self misMatchPenalty])};

                    
                    // geen score, kost punten
                    score -= [self misMatchPenalty];
                    // oude kaarten omdraaien
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            [self.historyOfMoves addObject:moveDescription];
            // omdraaien kost wat
            score -= [self costToChoose];
            self.score += score;
            card.chosen = YES;
        }
    }
}

@end
