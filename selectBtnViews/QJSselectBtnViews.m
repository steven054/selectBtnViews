//
//  QJSselectBtnViews.m
//  selectBtnViews
//
//  Created by 史德伟 on 16/3/22.
//  Copyright (c) 2016年 QJS. All rights reserved.
//

#define QJSNavButtonBaseTag 70


#import "QJSselectBtnViews.h"

@interface QJSselectBtnViews()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomSeprator;
@property (nonatomic, strong) UIView *topSeprator;

@property (nonatomic, strong) NSMutableArray *navBtnArray;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation QJSselectBtnViews

+ (instancetype)finacesNavButtonViewWithTitleArray:(NSArray *)titleArray
{
    return [self finacesNavButtonViewWithTitleArray:titleArray andSelectedIndex:0];
}
+ (instancetype)finacesNavButtonViewWithTitleArray:(NSArray *)titleArray andSelectedIndex:(NSInteger)index
{
    return [[self alloc] initWithTitleArray:titleArray andSelectedIndex:index];
}
- (instancetype)initWithTitleArray:(NSArray *)titleArray
{
    return [self initWithTitleArray:titleArray andSelectedIndex:0];
}
- (instancetype)initWithTitleArray:(NSArray *)titleArray andSelectedIndex:(NSInteger)index
{
    if (self = [super init]) {
        
        self.backgroundColor=[UIColor blueColor];
        self.selectedIndex = index;
        self.userInteractionEnabled=YES;
        
        [self ceateSubviewsWithTitleArray:titleArray];
    }
    return self;
}

- (void)ceateSubviewsWithTitleArray:(NSArray *)titleArray
{
    self.maxContent=titleArray.count;
    self.scrollview=[[UIScrollView alloc ]init];
    self.scrollview.frame=CGRectMake(0, 0, [self getDeviceWidth], QJSFinacesNavViewHeight);
    self.scrollview.userInteractionEnabled=YES;
    self.scrollview.scrollEnabled=YES;
    self.scrollview.bounces=NO;
    [self addSubview:self.scrollview];
    
    self.navBtnArray = [NSMutableArray array];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        navBtn.backgroundColor = [UIColor whiteColor];
        navBtn.tag = QJSNavButtonBaseTag + i;
        navBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [navBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [navBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [navBtn addTarget:self action:@selector(navButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btnW =self.maxContent>3?[self getDeviceWidth]/4:[self getDeviceWidth]/self.maxContent;
        CGFloat btnH = QJSFinacesNavViewHeight - 10;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 10;
        navBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        navBtn.userInteractionEnabled=YES;
        [self.scrollview addSubview:navBtn];
        [self.navBtnArray addObject:navBtn];
    }
    [self setSelectedButton];
    
    CGFloat lineW = self.maxContent>3?[self getDeviceWidth]/4:[self getDeviceWidth]/self.maxContent;;
    CGFloat lineH = 2;
    CGFloat lineX = 0;
    CGFloat lineY = QJSFinacesNavViewHeight - lineH;
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor redColor];
    _lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    [self.scrollview addSubview:_lineView];
    [self setSelectedLineView];
    
    _topSeprator = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [self getDeviceWidth], 0.5)];
    _topSeprator.backgroundColor = [UIColor grayColor];
    [self addSubview:_topSeprator];
    
    _bottomSeprator = [[UIView alloc] initWithFrame:CGRectMake(0, QJSFinacesNavViewHeight - 0.5, [self getDeviceWidth], 0.5)];
    _bottomSeprator.backgroundColor = [UIColor grayColor];
    [self addSubview:_bottomSeprator];
    self.scrollview.contentSize=CGSizeMake([self getDeviceWidth]/4*titleArray.count, QJSFinacesNavViewHeight);

}

- (void)navButtonTouch:(UIButton *)sender
{
    NSInteger buttonIndex = sender.tag - QJSNavButtonBaseTag;
    self.selectedIndex=buttonIndex;
    [self setSelectedButton];
    [self setSelectedLineView];
    if ([_delegate respondsToSelector:@selector(finacesNavButtonView:didSelectedButtonAtIndex:)]) {
        [_delegate finacesNavButtonView:self didSelectedButtonAtIndex:buttonIndex];
    }
    //屏幕的居中位置
    CGFloat centOffx=self.frame.size.width/2-self.frame.size.width/8;
    //当前button的x位置
    CGFloat buttonOffx=self.frame.size.width/4*buttonIndex;
 
    if (self.maxContent<=4) {
        return;
    }
    //如果偏移量大于当前位置移动
    if (buttonOffx>centOffx)
    {
        //self.maxContent-3最后两个button
        if (buttonIndex>self.maxContent-3)
        {
            if (buttonIndex==self.maxContent-1)
            {
                buttonIndex--;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollview.contentOffset=CGPointMake(buttonIndex*self.frame.size.width/4-centOffx+self.frame.size.width/8-self.frame.size.width/4,0);
            } completion:^(BOOL finished){
                
            }];
        }else
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollview.contentOffset=CGPointMake(buttonIndex*self.frame.size.width/4-centOffx,0);
            } completion:^(BOOL finished){
                
            }];
        }
      
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollview.contentOffset=CGPointMake(0,0);
        } completion:^(BOOL finished) {
            
        }];
    }

  
}

- (void)setSelectedButton
{
    
    if (self.navBtnArray.count==0) {
        return;
    }
    for (UIButton * btn in self.navBtnArray) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    UIButton *sender = self.navBtnArray[self.selectedIndex];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)setSelectedLineView
{
    
    if (self.navBtnArray.count==0) {
        return;
    }
    UIButton *btn = self.navBtnArray[self.selectedIndex];
    
    CGPoint lineCenter = _lineView.center;
    lineCenter.x = btn.center.x;
    
    _lineView.center = lineCenter;
}
- (CGFloat) getDeviceWidth
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect.size.width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
