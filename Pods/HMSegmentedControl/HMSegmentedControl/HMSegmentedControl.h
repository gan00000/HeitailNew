#import <UIKit/UIKit.h>
@class HMSegmentedControl;
typedef void (^IndexChangeBlock)(NSInteger index);
typedef NSAttributedString *(^HMTitleFormatterBlock)(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected);
typedef NS_ENUM(NSInteger, HMSegmentedControlSelectionStyle) {
    HMSegmentedControlSelectionStyleTextWidthStripe, 
    HMSegmentedControlSelectionStyleFullWidthStripe, 
    HMSegmentedControlSelectionStyleBox, 
    HMSegmentedControlSelectionStyleArrow 
};
typedef NS_ENUM(NSInteger, HMSegmentedControlSelectionIndicatorLocation) {
    HMSegmentedControlSelectionIndicatorLocationUp,
    HMSegmentedControlSelectionIndicatorLocationDown,
	HMSegmentedControlSelectionIndicatorLocationNone 
};
typedef NS_ENUM(NSInteger, HMSegmentedControlSegmentWidthStyle) {
    HMSegmentedControlSegmentWidthStyleFixed, 
    HMSegmentedControlSegmentWidthStyleDynamic, 
};
typedef NS_OPTIONS(NSInteger, HMSegmentedControlBorderType) {
    HMSegmentedControlBorderTypeNone = 0,
    HMSegmentedControlBorderTypeTop = (1 << 0),
    HMSegmentedControlBorderTypeLeft = (1 << 1),
    HMSegmentedControlBorderTypeBottom = (1 << 2),
    HMSegmentedControlBorderTypeRight = (1 << 3)
};
enum {
    HMSegmentedControlNoSegment = -1   
};
typedef NS_ENUM(NSInteger, HMSegmentedControlType) {
    HMSegmentedControlTypeText,
    HMSegmentedControlTypeImages,
	HMSegmentedControlTypeTextImages
};
typedef NS_ENUM(NSInteger, HMSegmentedControlImagePosition) {
    HMSegmentedControlImagePositionBehindText,
    HMSegmentedControlImagePositionLeftOfText,
    HMSegmentedControlImagePositionRightOfText,
    HMSegmentedControlImagePositionAboveText,
    HMSegmentedControlImagePositionBelowText
};
@interface HMSegmentedControl : UIControl
@property (nonatomic, strong) NSArray<NSString *> *sectionTitles;
@property (nonatomic, strong) NSArray<UIImage *> *sectionImages;
@property (nonatomic, strong) NSArray<UIImage *> *sectionSelectedImages;
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;
@property (nonatomic, copy) HMTitleFormatterBlock titleFormatter;
@property (nonatomic, strong) NSDictionary *titleTextAttributes UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSDictionary *selectedTitleTextAttributes UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *selectionIndicatorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *selectionIndicatorBoxColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *verticalDividerColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat selectionIndicatorBoxOpacity;
@property (nonatomic, assign) CGFloat verticalDividerWidth;
@property (nonatomic, assign) HMSegmentedControlType type;
@property (nonatomic, assign) HMSegmentedControlSelectionStyle selectionStyle;
@property (nonatomic, assign) HMSegmentedControlSegmentWidthStyle segmentWidthStyle;
@property (nonatomic, assign) HMSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;
@property (nonatomic, assign) HMSegmentedControlBorderType borderType;
@property (nonatomic) HMSegmentedControlImagePosition imagePosition;
@property (nonatomic) CGFloat textImageSpacing;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;
@property(nonatomic, getter = isVerticalDividerEnabled) BOOL verticalDividerEnabled;
@property (nonatomic, getter=shouldStretchSegmentsToScreenSize) BOOL stretchSegmentsToScreenSize;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;
@property (nonatomic, readwrite) UIEdgeInsets selectionIndicatorEdgeInsets;
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;
@property (nonatomic, readwrite) UIEdgeInsets enlargeEdgeInset;
@property (nonatomic) BOOL shouldAnimateUserSelection;
- (id)initWithSectionTitles:(NSArray<NSString *> *)sectiontitles;
- (id)initWithSectionImages:(NSArray<UIImage *> *)sectionImages sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages;
- (instancetype)initWithSectionImages:(NSArray<UIImage *> *)sectionImages sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages titlesForSections:(NSArray<NSString *> *)sectiontitles;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;
- (void)setTitleFormatter:(HMTitleFormatterBlock)titleFormatter;
@end
