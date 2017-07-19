//
//  Wallet.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 15.12.16.
//  Copyright © 2016 PixelPlex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spendable.h"

@class HistoryDataStorage;
@class Wallet;

extern NSInteger const brandKeyWordsCount;

@interface Wallet : NSObject <Spendable>

- (instancetype)initWithName:(NSString *)name pin:(NSString *)pin;
- (instancetype)initWithName:(NSString *)name pin:(NSString *)pin seedWords:(NSArray *)seedWords;

@property (copy, nonatomic) NSString* name;
@property (assign, nonatomic) CGFloat balance;
@property (assign, nonatomic) CGFloat unconfirmedBalance;
@property (copy, nonatomic)NSArray <HistoryElementProtocol>*historyArray;
@property (copy, nonatomic)NSString* mainAddress;
@property (copy, nonatomic)NSString* symbol;
@property (copy, nonatomic, readonly)NSArray* seedWords; //deprecated
@property (weak, nonatomic)id <Managerable> manager;
@property (nonatomic, readonly) NSInteger countOfUsedKeys;
@property (strong, nonatomic) HistoryDataStorage* historyStorage;

- (BOOL)configAddressesWithPin:(NSString*) pin;
- (BTCKey *)lastRandomKeyOrRandomKey;
- (BTCKey *)randomKey;
- (BTCKey *)keyAtIndex:(NSUInteger)index;
- (NSArray *)allKeys;
- (NSArray <NSString*>*)allKeysAdreeses;
- (NSString *)brandKeyWithPin:(NSString*) pin;


@end
