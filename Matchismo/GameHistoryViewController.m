//
//  GameHistoryViewController.m
//  Matchismo
//
//  Created by Bob Voorneveld on 15-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation GameHistoryViewController

- (void)updateUI
{
    NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (NSMutableAttributedString *historyStep in self.gameDescriptionHistory) {
        [historyText appendAttributedString:historyStep];
        [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    self.historyTextView.attributedText = historyText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)setGameDescriptionHistory:(NSArray *)gameDescriptionHistory
{
    _gameDescriptionHistory = gameDescriptionHistory;
    [self updateUI];
}
@end
