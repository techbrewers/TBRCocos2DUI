//
//  TBRCarousel.m
//  Inspire
//
//  Created by Luciano Marisi on 23/02/2014.
//  Copyright 2014 TechBrewers LTD. All rights reserved.
//

#import "TBRCarousel.h"
#import "CCScrollView.h"

@interface TBRCarousel () <CCScrollViewDelegate>

@property (nonatomic, strong) CCScrollView *scrollView;

@end

@implementation TBRCarousel

#pragma mark - Initialization

- (instancetype)initWithDataSource:(id<TBRCarouselDataSource>)dataSource
{
    self = [super init];
    if (self) {
        _dataSource = dataSource;

        _scrollView = [[CCScrollView alloc] init];
        _scrollView.contentNode.contentSize = [self contentNodeSize];
        _scrollView.verticalScrollEnabled = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addChild:_scrollView];
    }
    return self;
}


#pragma mark - Data management

- (void)reloadData
{
    [self.scrollView.contentNode removeAllChildrenWithCleanup:YES];
    
    for (NSInteger i = 0; i < [self numberOfPages]; i++) {
        CCNode *nodeForPage = [self.dataSource carousel:self
                                     nodeForPageAtIndex:i];
        
        CCNode *pageContainerNode = [self containerNodeForPage:i];
        [pageContainerNode addChild:nodeForPage];
        
        [self.scrollView.contentNode addChild:pageContainerNode];
    }
}

#pragma mark - Helper methods

- (CCNode *)containerNodeForPage:(NSInteger)index
{
    CCNode *pageContainerNode = [CCNode node];
    pageContainerNode.contentSize = [CCDirector sharedDirector].viewSize;
    pageContainerNode.position = ccp([CCDirector sharedDirector].viewSize.width * index, 0);
    return pageContainerNode;
}

- (NSInteger)numberOfPages
{
    return [self.dataSource numberOfPagesInCarousel];
}

- (CGSize)contentNodeSize
{
    return CGSizeMake([CCDirector sharedDirector].viewSize.width * [self numberOfPages],
                      [CCDirector sharedDirector].viewSize.height);
}

#pragma mark - CCScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(CCScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(carousel:currentPageIndex:)]) {
        [self.delegate carousel:self currentPageIndex:self.scrollView.horizontalPage];
    }
}

@end