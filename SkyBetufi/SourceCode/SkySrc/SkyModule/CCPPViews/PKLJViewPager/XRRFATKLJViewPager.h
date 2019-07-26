//
//  BTPagesTableView.h
//  biketicket
//
//  Created by Marco on 12/27/14.
//  Copyright (c) 2014 bestapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKLJTabBar.h"

@class XRRFATKLJViewPager;

@protocol LJViewPagerDataSource <NSObject>

@required
/**
 * return the UIViewController which the view is add in
 */
- (UIViewController *)viewPagerInViewController;

- (NSInteger)numberOfPagesInViewPager;

- (UIViewController *)viewPager:(XRRFATKLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;

@end

@protocol LJViewPagerDelegate <NSObject>

@optional
//- (void)viewPager:(XRRFATKLJViewPager *)viewPager willScrollToPage:(NSInteger)page;
- (void)viewPager:(XRRFATKLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(XRRFATKLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;

@end

@interface XRRFATKLJViewPager : UIScrollView

@property (strong, nonatomic) XRRFATKLJTabBar *tabBar;

@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;

@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;

- (void)reloadData;
/**
 * scroll to page with animated
 */
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;

@end
