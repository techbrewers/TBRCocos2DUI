//
//  TBRPageControl.h
//  Inspire
//
//  Created by Luciano Marisi on 24/02/2014.
//  Copyright 2014 TechBrewers LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TBRPageControl : CCNode

@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentDisplayedIndex;

@property (nonatomic, strong) CCColor *currentPageDotColor;
@property (nonatomic, strong) CCColor *hiddenPageDotColor;

/**
 *  Designated initializer for creating a TBRPageControl
 *
 *  @param numberOfPages Number of pages for the page control
 *
 *  @return An instantiated TBRPageControl instance
 */
- (instancetype)initWithNumberOfPages:(NSInteger)numberOfPages;

@end