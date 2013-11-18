//
//  GameScore.h
//  Matchismo
//
//  Created by Bob Voorneveld on 16-11-13.
//  Copyright (c) 2013 Bob Voorneveld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameScore : NSObject

@property (nonatomic, readonly) NSNumber *score;
@property (nonatomic, readonly) NSNumber *duration;
@property (nonatomic, readonly) NSDate *start;

- (instancetype)initWithGameType:(NSString *)gameType;

- (void)updateScore:(NSNumber *)score;

+ (GameScore *)gameScoreWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)allGameScores;
+ (NSArray *)allGameScoresByDate;
+ (NSArray *)allGameScoresByDuration;

@end
