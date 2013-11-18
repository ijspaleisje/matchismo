//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Bob Voorneveld on 17-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *costToPickLabel;
@property (weak, nonatomic) IBOutlet UIStepper *costToPickStepper;
@property (weak, nonatomic) IBOutlet UILabel *misMatchLabel;
@property (weak, nonatomic) IBOutlet UIStepper *misMatchStepper;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UIStepper *matchStepper;
@property (nonatomic) NSInteger misMatchPenalty;
@property (nonatomic) NSInteger matchBonus;
@property (nonatomic) NSInteger costToChoose;

@end

@implementation SettingsViewController

- (NSInteger)misMatchPenalty
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:MISMATCH_PENALTY_KEY];
}

- (void)setMisMatchPenalty:(NSInteger)misMatchPenalty
{
    [[NSUserDefaults standardUserDefaults] setObject:@(misMatchPenalty) forKey:MISMATCH_PENALTY_KEY];
    self.misMatchLabel.text = [NSString stringWithFormat:@"Mismatch penalty: %d", misMatchPenalty];
}

- (NSInteger)matchBonus
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:MATCHBONUS_KEY];
}

- (void)setMatchBonus:(NSInteger)matchBonus
{
    [[NSUserDefaults standardUserDefaults] setObject:@(matchBonus) forKey:COST_TO_CHOOSE_KEY];
    self.matchLabel.text = [NSString stringWithFormat:@"Match bonus: %d", matchBonus];
}

- (NSInteger)costToChoose
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:COST_TO_CHOOSE_KEY];
}

- (void)setCostToChoose:(NSInteger)costToChoose
{
    [[NSUserDefaults standardUserDefaults] setObject:@(costToChoose) forKey:COST_TO_CHOOSE_KEY];
    self.costToPickLabel.text = [NSString stringWithFormat:@"Cost to pick a card: %d", costToChoose];
}

- (IBAction)costToPickChanged:(UIStepper *)sender
{
    self.costToChoose = sender.value;
}

- (IBAction)misMatchChanged:(UIStepper *)sender
{
    self.misMatchPenalty = sender.value;
}

- (IBAction)matchBonusChanged:(UIStepper *)sender
{
    self.matchBonus = sender.value;
}

- (void)updateUI
{
    self.costToPickStepper.value = self.costToChoose;
    self.costToPickLabel.text = [NSString stringWithFormat:@"Cost to pick a card: %d", self.costToChoose];
    self.misMatchStepper.value = self.misMatchPenalty;
    self.misMatchLabel.text = [NSString stringWithFormat:@"Mismatch penalty: %d", self.misMatchPenalty];
    self.matchStepper.value = self.matchBonus;
    self.matchLabel.text = [NSString stringWithFormat:@"Match bonus: %d", self.matchBonus];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [super viewWillDisappear:animated];
}

@end
