//
//  GameScore.m
//  Matchismo
//
//  Created by Bob Voorneveld on 16-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import "GameScore.h"

#define HIGHSCORES_KEY @"highscores"
#define HIGHSCORE_START_KEY @"starttime"
#define HIGHSCORE_END_KEY @"endtime"
#define HIGHSCORE_SCORE_KEY @"score"
#define HIGHSCORE_GAME_TYPE_KEY @"gametype"

@interface GameScore ()

@property (nonatomic, strong) NSString *gameType;
@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSDate *end;
@property (nonatomic, strong, readwrite) NSNumber *score;

@end

@implementation GameScore

- (instancetype)initWithGameType:(NSString *)gameType
{
    self = [super init];
    
    if (self) {
        self.gameType = gameType;
        self.start = [NSDate date];
        self.end = [NSDate date];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Scored: %@ at %@", self.score, self.start];
}

- (NSNumber *)duration
{
    NSTimeInterval duration = [self.end timeIntervalSinceDate:self.start];
    return [NSNumber numberWithDouble:duration];
}

- (void)setScore:(NSNumber *)score
{
    _score = score;
}

- (void)updateScore:(NSNumber *)score
{
    self.score = score;
    self.end = [NSDate date];
    [self saveScore];
}

- (void)saveScore
{
    NSArray *allScores = [GameScore allGameScores];
    
    if ([allScores count] < kMaxHighScores || [self compareByScoreWithGameScore:[allScores lastObject]] == NSOrderedAscending) {
        
        NSMutableDictionary *highscoresToSave = [NSMutableDictionary dictionary];
        
        for (GameScore *score in allScores) {
            highscoresToSave[[score.start description]] = [self dictionaryForGameScore:score];
        }
        
        highscoresToSave[[self.start description]] = [self dictionaryForGameScore:self];
        
        [[NSUserDefaults standardUserDefaults] setObject:highscoresToSave forKey:HIGHSCORES_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSDictionary *)dictionaryForGameScore:(GameScore *)gameScore
{
    return @{HIGHSCORE_GAME_TYPE_KEY : gameScore.gameType,
             HIGHSCORE_START_KEY : gameScore.start,
             HIGHSCORE_END_KEY : gameScore.end,
             HIGHSCORE_SCORE_KEY : gameScore.score };
}

+ (GameScore *)gameScoreWithDictionary:(NSDictionary *)dictionary
{
    GameScore *gameScore = [[GameScore alloc] init];
    
    gameScore.gameType = dictionary[HIGHSCORE_GAME_TYPE_KEY];
    gameScore.start = dictionary[HIGHSCORE_START_KEY];
    gameScore.end = dictionary[HIGHSCORE_END_KEY];
    gameScore.score = dictionary[HIGHSCORE_SCORE_KEY];
    
    return gameScore;
}

static const int kMaxHighScores = 20;

+ (NSArray *)allGameScores
{
    NSDictionary *highScores = [[NSUserDefaults standardUserDefaults] dictionaryForKey:HIGHSCORES_KEY];
    
    NSMutableArray *allGameScores = [NSMutableArray array];
    
    for (NSString *key in highScores) {
        [allGameScores addObject:[GameScore gameScoreWithDictionary:highScores[key]]];
    }
    
    [allGameScores sortUsingSelector:@selector(compareByScoreWithGameScore:)];
    
    if ([allGameScores count] > kMaxHighScores) {
        
        [allGameScores removeObjectsInRange:NSMakeRange(kMaxHighScores, [allGameScores count]-kMaxHighScores)];
    }
    
    return allGameScores;
}

+ (NSArray *)allGameScoresByDate
{
    NSMutableArray *resultArray = [[GameScore allGameScores] mutableCopy];
    [resultArray sortUsingSelector:@selector(compareByDateWithGameScore:)];
    return [resultArray copy];
}

+ (NSArray *)allGameScoresByDuration
{
    NSMutableArray *resultArray = [[GameScore allGameScores] mutableCopy];
    [resultArray sortUsingSelector:@selector(compareByDurationWithGameScore:)];
    return [resultArray copy];
}

- (NSComparisonResult)compareByScoreWithGameScore:(GameScore *)otherGameScore
{
    if ([self.score intValue] == [otherGameScore.score intValue]) {
        return NSOrderedSame;
    } else if ([self.score intValue] > [otherGameScore.score intValue]) {

        return NSOrderedAscending;
    }
    
    return NSOrderedDescending;
}

- (NSComparisonResult)compareByDateWithGameScore:(GameScore *)otherGameScore
{
    return [self.start compare:otherGameScore.start];
}

- (NSComparisonResult)compareByDurationWithGameScore:(GameScore *)otherGameScore
{
    if ([self.duration intValue] == [otherGameScore.duration intValue]) {
        return NSOrderedSame;
    } else if ([self.duration intValue] > [otherGameScore.duration intValue]) {
        
        return NSOrderedAscending;
    }
    
    return NSOrderedDescending;
}

@end
