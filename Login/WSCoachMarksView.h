/*
 
 
 ***************************************************************************
 ************************* 这个页面是一个指引View *****************************
 ***************************************************************************
 
 
 ***************************************************************************
 *************************  用法如下 ****************************************
 ***************************************************************************
 
 

 ***************************************************************************

 NSArray *coachMarks = @[
     @{
     @"rect":[NSValue valueWithCGRect:(CGRect){{0,0},{45,45}}],
     @"caption":@"Helpful navigation menu",
     @"shape": @"circle"
     },
     @{
     @"rect": [NSValue valueWithCGRect:(CGRect){{10.0f,56.0f},{300.0f,56.0f}}],
     @"caption": @"Document your wedding by taking photos",
     @"shape": @"square"
     },
     @{
     @"rect": [NSValue valueWithCGRect:(CGRect){{10.0f,119.0f},{300.0f,56.0f}}],
     @"caption": @"Your wedding photo album"
     },
     @{
     @"rect": [NSValue valueWithCGRect:(CGRect){{10.0f,182.0f},{300.0f,56.0f}}],
     @"caption": @"View and manage your friends & family"
     },
     @{
     @"rect": [NSValue valueWithCGRect:(CGRect){{10.0f,245.0f},{300.0f,56.0f}}],
     @"caption": @"Invite friends to get more photos"
     },
     @{
     @"rect": [NSValue valueWithCGRect:(CGRect){{0.0f,410.0f},{320.0f,50.0f}}],
     @"caption": @"Keep your guests informed with your wedding details"
     }
     ];
     WSCoachMarksView *coachMarksView = [[WSCoachMarksView alloc] initWithFrame:self.view.bounds coachMarks:coachMarks];
     [self.view addSubview:coachMarksView];
     [coachMarksView start];

 ***************************************************************************

 */



#import <UIKit/UIKit.h>

#ifndef WS_WEAK
  #if __has_feature(objc_arc_weak)
    #define WS_WEAK weak
  #elif __has_feature(objc_arc)
    #define WS_WEAK unsafe_unretained
  #else
    #define WS_WEAK assign
  #endif
#endif

@protocol WSCoachMarksViewDelegate;

@interface WSCoachMarksView : UIView

@property (nonatomic, WS_WEAK) id<WSCoachMarksViewDelegate> delegate;
@property (nonatomic, retain) NSArray *coachMarks;
@property (nonatomic, retain) UILabel *lblCaption;
@property (nonatomic, retain) UIColor *maskColor;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat cutoutRadius;
@property (nonatomic) CGFloat maxLblWidth;
@property (nonatomic) CGFloat lblSpacing;
@property (nonatomic) BOOL enableContinueLabel;
@property (nonatomic) BOOL enableSkipButton;

- (id)initWithFrame:(CGRect)frame coachMarks:(NSArray *)marks;
- (void)start;

@end

@protocol WSCoachMarksViewDelegate <NSObject>

@optional
- (void)coachMarksView:(WSCoachMarksView*)coachMarksView willNavigateToIndex:(NSUInteger)index;
- (void)coachMarksView:(WSCoachMarksView*)coachMarksView didNavigateToIndex:(NSUInteger)index;
- (void)coachMarksViewWillCleanup:(WSCoachMarksView*)coachMarksView;
- (void)coachMarksViewDidCleanup:(WSCoachMarksView*)coachMarksView;

@end