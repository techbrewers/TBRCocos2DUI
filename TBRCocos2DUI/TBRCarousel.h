//
//  TBRCarousel.h
//  Inspire
//
//  Created by Luciano Marisi on 23/02/2014.
//  Copyright 2014 TechBrewers LTD. All rights reserved.
//

#import "cocos2d.h"

@class TBRCarousel;

@protocol TBRCarouselDataSource <NSObject>

/**
 *  Data source method to know the number of pages for the carousel
 *
 *  @return Number of pages for carousel
 */
- (NSInteger)numberOfPagesInCarousel;

/**
 *  Data source method to populate carousel
 *
 *  @param carousel The TBRCarousel instance
 *  @param index    The index of the node to populate
 *
 *  @return The node for the page
 */
- (CCNode *)carousel:(TBRCarousel *)carousel nodeForPageAtIndex:(NSInteger)index;

@end

@protocol TBRCarouselDelegate <NSObject>

@optional

/**
 *  Delegate method called when carousel has stopped decelerating
 *
 *  @param carousel The TBRCarousel instance
 *  @param index    The current page show for the carousel
 */
- (void)carousel:(TBRCarousel *)carousel currentPageIndex:(NSInteger)index;

@end


@interface TBRCarousel : CCScene

@property (nonatomic, weak) id<TBRCarouselDataSource> dataSource;
@property (nonatomic, weak) id<TBRCarouselDelegate> delegate;

/**
 *  Designated initializer for creating a TBRCarousel
 *
 *  @param dataSource The data source to be used for the carousel
 *
 *  @return An instantiated TBRCarousel instance
 */
- (instancetype)initWithDataSource:(id<TBRCarouselDataSource>)dataSource;


/**
 *  Reloads the pages
 */
- (void)reloadData;

@end