//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Bob Voorneveld on 15-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    self.numberOfCardsToMatch = 3;
    self.gameType = @"Playing Card";

    [self updateUI];
}

-(Deck *)createDeck
{
    return [[SetDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return [self attributedTitleForCard:card];
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    NSMutableAttributedString *title;
    NSMutableDictionary *attributesForTitle = [NSMutableDictionary dictionary];

    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        
        UIColor *strokeColor;
        
        switch (setCard.color) {
            case SetCardColorOne:
                strokeColor = [UIColor redColor];
                break;
            case SetCardColorTwo:
                strokeColor = [UIColor greenColor];
                break;
            case SetCardColorThree:
                strokeColor = [UIColor blueColor];
                break;
            default:
                break;
        }
        
        UIColor *bodyColor;
        switch (setCard.shading) {
            case SetCardShadeOne:
                bodyColor = [strokeColor colorWithAlphaComponent:1.0];
                break;
            case SetCardShadeTwo:
                bodyColor = [strokeColor colorWithAlphaComponent:0.3];
                break;
            case SetCardShadeThree:
                bodyColor = [strokeColor colorWithAlphaComponent:0.0];
            default:
                break;
        }
        
        attributesForTitle[NSForegroundColorAttributeName] = bodyColor;
        attributesForTitle[NSStrokeWidthAttributeName] = @-3;
        attributesForTitle[NSStrokeColorAttributeName] = strokeColor;
        
        NSString *titleString = [setCard.symbol stringByPaddingToLength:setCard.numberOfSymbols
                                                             withString:setCard.symbol
                                                        startingAtIndex:0];
                
        title = [[NSMutableAttributedString alloc] initWithString:titleString];
        [title addAttributes:attributesForTitle range:NSMakeRange(0, titleString.length)];
        
    }
    
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return card.isChosen ? [UIImage imageNamed:@"selectedcardback"] : [UIImage imageNamed:@"cardfront"];
}


@end
