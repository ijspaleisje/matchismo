 //
//  CardGameViewController.h
//  Matchismo
//
//  Created by Bob Voorneveld on 02-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (nonatomic, strong) NSString *gameType;
@property (nonatomic, strong) CardMatchingGame *game;

- (Deck *)createDeck; // abstract
- (NSAttributedString *)titleForCard:(Card *)card;
- (NSAttributedString *)attributedTitleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (void)updateUI;

@end
