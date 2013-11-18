//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Bob Voorneveld on 15-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (void)viewDidLoad
{
    self.numberOfCardsToMatch = 2;
    self.gameType = @"Playing Card";
    [self updateUI];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return card.isChosen ? [self attributedTitleForCard:card] : [[NSAttributedString alloc] initWithString:@""];
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    return [[NSAttributedString alloc] initWithString:card.contents];
}

@end
