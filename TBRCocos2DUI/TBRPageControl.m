//
//  TBRPageControl.m
//  Inspire
//
//  Created by Luciano Marisi on 24/02/2014.
//  Copyright 2014 TechBrewers LTD. All rights reserved.
//

#import "TBRPageControl.h"

static const CGFloat kPaddingBetweenDots = 9.0;
static const CGFloat kDotRadius = 4.0;

@implementation TBRPageControl

- (instancetype)initWithNumberOfPages:(NSInteger)numberOfPages
{
    self = [super init];
    
    if (self) {
        
        [self setupDefaultProperties];
        
        self.numberOfPages = numberOfPages;
        self.currentDisplayedIndex = 0;
    }
    
    return self;
}

- (void)setupDefaultProperties
{
    self.currentPageDotColor = [CCColor whiteColor];
    self.hiddenPageDotColor = [CCColor grayColor];
}

#pragma mark - Overriden setters

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self showDots];
}

- (void)setCurrentDisplayedIndex:(NSInteger)currentDisplayedIndex
{
    NSAssert(currentDisplayedIndex < self.children.count,
             @"CurrentDisplayedIndex %i is higher than number of pages %i",
             currentDisplayedIndex, self.children.count);

    _currentDisplayedIndex = currentDisplayedIndex;
    [self showDots];
}

- (void)showDots
{
    [self removeAllChildrenWithCleanup:YES];
    CGPoint startPosition = CGPointMake((-[self widthOfPageControl] + [self sizeOfDot].width) * 0.5, 0);
    
    for (int i = 0; i < _numberOfPages; i++) {
        CCDrawNode *dotNode = [self hiddenPageDot];
        
        if (i == self.currentDisplayedIndex) {
            dotNode = [self currentPageDot];
        }
        
        dotNode.position = ccp(startPosition.x, 0);
        [self addChild:dotNode];
        startPosition.x += kPaddingBetweenDots + [self sizeOfDot].width;
    }
    
}

#pragma mark - Helper methods

- (CGFloat)widthOfPageControl
{
    CGFloat combinedWidthOfDots = [self sizeOfDot].width * _numberOfPages;
    CGFloat combinedWidthSpaces = kPaddingBetweenDots * (_numberOfPages - 1);
    return combinedWidthOfDots + combinedWidthSpaces;
}

- (CCDrawNode *)dotNodeWithColor:(CCColor *)color
{
    NSParameterAssert(color);
    CCDrawNode *circleNode = [[CCDrawNode alloc] init];
    [circleNode drawDot:ccp(0, 0)
                 radius:kDotRadius
                  color:color];
    return circleNode;
}

- (CCDrawNode *)currentPageDot
{
    return [self dotNodeWithColor:self.currentPageDotColor];
}

- (CCDrawNode *)hiddenPageDot
{
    return [self dotNodeWithColor:self.hiddenPageDotColor];
}

- (CGSize)sizeOfDot
{
    return CGSizeMake(kDotRadius, kDotRadius);
}

@end