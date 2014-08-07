//
//  CarouselScene.m
//  TBRCocos2DUIExample
//
//  Created by Luciano Marisi on 07/08/2014.
//  Copyright 2014 TechBrewers LTD. All rights reserved.
//

#import "CarouselScene.h"
#import "TBRCarousel.h"
#import "TBRPageControl.h"
#import "CCScrollView.h"

@interface CarouselScene () <TBRCarouselDataSource, TBRCarouselDelegate>

@property (nonatomic, strong) TBRCarousel *carousel;
@property (nonatomic, strong) NSArray *nodesArray;
@property (nonatomic, strong) TBRPageControl *pageControl;

@end

@implementation CarouselScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.carousel = [[TBRCarousel alloc] initWithDataSource:self];
        self.carousel.delegate = self;
        [self.carousel reloadData];
        [self addChild:self.carousel];

        
        self.pageControl = [[TBRPageControl alloc] initWithNumberOfPages:self.nodesArray.count];
        self.pageControl.positionType = CCPositionTypeNormalized;
        self.pageControl.position = ccp(0.5, 0.1);
        [self addChild:self.pageControl];

    }
    return self;
}

#pragma mark - Lazy instantiation

- (NSArray *)nodesArray
{
    if (!_nodesArray) {
        _nodesArray = @[[self circleNode],
                        [self nodeColorWithColor:[CCColor blueColor]],
                        [self nodeColorWithColor:[CCColor greenColor]],
                        [CCNodeColor nodeWithColor:[CCColor redColor] width:100 height:100]];
    }
    return _nodesArray;
}

#pragma mark - TBRCarouselDataSource

- (NSInteger)numberOfPagesInCarousel;
{
    return self.nodesArray.count;
}

- (CCNode *)carousel:(TBRCarousel *)carousel
  nodeForPageAtIndex:(NSInteger)index
{
    CCNode *node = self.nodesArray[index];
    NSAssert([node isKindOfClass:[CCNode class]], @"Node %@ is not of class CCNode", node);
    return node;
}

#pragma mark - TBRCarouselDelegate

- (void)carousel:(TBRCarousel *)carousel
currentPageIndex:(NSInteger)currentPageIndex
{
    self.pageControl.currentDisplayedIndex = currentPageIndex;
}


#pragma mark - Helper methods

- (CCNodeColor *)nodeColorWithColor:(CCColor *)color
{
    CCNodeColor *nodeColor = [CCNodeColor nodeWithColor:color width:100 height:100];
    [self centerNode:nodeColor];
    return nodeColor;
}


- (CCDrawNode *)circleNode
{
    CCDrawNode *circleNode = [[CCDrawNode alloc] init];
    [circleNode drawDot:ccp(0, 0) radius:50 color:[CCColor yellowColor]];
    [self centerNode:circleNode];
    return circleNode;
}

- (void)centerNode:(CCNode *)node
{
    node.positionType = CCPositionTypeNormalized;
    node.position = ccp(0.5, 0.5);
    node.anchorPoint = ccp(0.5, 0.5);
}

@end


