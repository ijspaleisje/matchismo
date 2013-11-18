//
//  HighScoresViewController.m
//  Matchismo
//
//  Created by Bob Voorneveld on 17-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "HighScoresViewController.h"
#import "GameScore.h"

@interface HighScoresViewController ()

@property (weak, nonatomic) IBOutlet UITextView *highScoresTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortControl;

@end

@implementation HighScoresViewController

- (IBAction)changedSortControl:(UISegmentedControl *)sender
{
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateUI];
}

- (void)updateUI
{
    self.highScoresTextView.text = @"";
    
    NSArray *sortedScores;
    
    switch (self.sortControl.selectedSegmentIndex) {
        case 0:
            sortedScores = [GameScore allGameScores];
            break;
        case 1:
            sortedScores = [GameScore allGameScoresByDate];
            break;
        case 2:
            sortedScores = [GameScore allGameScoresByDuration];
        default:
            break;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.doesRelativeDateFormatting = YES;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.locale = [NSLocale currentLocale];
    
    for (GameScore *score in sortedScores) {
        
        NSString *scoreString = [NSString stringWithFormat:@"Score: %@ (%d sec) %@\n",
                                 score.score,
                                 [score.duration intValue],
                                 [dateFormatter stringFromDate:score.start]
                                 ];
        self.highScoresTextView.text = [self.highScoresTextView.text stringByAppendingString:scoreString];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
