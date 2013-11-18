//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Bob Voorneveld on 02-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "CardGameViewController.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "GameHistoryViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveDescription;
@end

@implementation CardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *ghvc = (GameHistoryViewController *)segue.destinationViewController;
            
            NSMutableArray *history = [NSMutableArray arrayWithCapacity:[self.game.historyOfMoves count]];
            
            for (NSDictionary *moveDictionary in self.game.historyOfMoves) {
                [history addObject:[self getMoveTextForDictionary:moveDictionary]];
            }
            ghvc.gameDescriptionHistory = history;
        }
    }
}

- (IBAction)redeal
{
    self.game = nil;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                          withNumberOfCards:self.numberOfCardsToMatch
                                                andGameType:self.gameType];
    }
    return _game;
}

- (Deck *)createDeck { return nil; }
- (NSAttributedString *)titleForCard:(Card *)card { return nil;}
- (NSAttributedString *)attributedTitleForCard:(Card *)card { return nil;}


- (IBAction)touchCardButton:(UIButton *)sender
{
    long choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastMoveDescription.attributedText = [self getMoveText];
}

- (NSAttributedString *)getMoveText
{
    NSDictionary *lastMove = [self.game lastMoveDescription];
    return [self getMoveTextForDictionary:lastMove];
}

- (NSAttributedString *)getMoveTextForDictionary:(NSDictionary *)lastMove
{
    if (!lastMove) return nil;
    
    if ([lastMove[@"action"] isEqualToString:@"firstCard"]) {
        return [[NSMutableAttributedString alloc] initWithString:@"Pick First Card!"];
    }
    
    if ([lastMove[@"action"] isEqualToString:@"picked"]) {
        NSMutableAttributedString *moveText = [[NSMutableAttributedString alloc] initWithString:@"Picked "];
        [moveText appendAttributedString:[self titleForCard:lastMove[@"card"]]];
        
        NSString *pointsString = [NSString stringWithFormat:@" for %@ points", lastMove[@"points"]];
        [moveText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:pointsString]];
        return moveText;
    }
    
    if ([lastMove[@"action"] isEqualToString:@"matched"]) {
        
        NSMutableAttributedString *moveText = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        [moveText appendAttributedString:[self attributedStringForCards:lastMove[@"cards"]]];
        
        NSString *pointsString = [NSString stringWithFormat:@" for %@ points", lastMove[@"points"]];
        [moveText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:pointsString]];
        return moveText;
    }

    if ([lastMove[@"action"] isEqualToString:@"notMatched"]) {
        
        NSMutableAttributedString *moveText = [[NSMutableAttributedString alloc] initWithString:@"No match for "];
        [moveText appendAttributedString:[self attributedStringForCards:lastMove[@"cards"]]];
        
        NSString *pointsString = [NSString stringWithFormat:@", %@ points penalty", lastMove[@"points"]];
        [moveText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:pointsString]];
        return moveText;
    }
    
    return nil;
}

- (NSAttributedString *)attributedStringForCards:(NSArray *)cards
{
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (int i = 0; i < [cards count] - 1; i++) {
        [resultString appendAttributedString:[self attributedTitleForCard:cards[i]]];
        [resultString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"&"]];
    }
    
    [resultString appendAttributedString:[self attributedTitleForCard:[cards lastObject]]];
    
    return resultString;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
