//
//  QJSselectBtnViews.h
//  selectBtnViews
//
//  Created by 史德伟 on 16/3/22.
//  Copyright (c) 2016年 QJS. All rights reserved.
//

#import <UIKit/UIKit.h>


#define QJSFinacesNavViewHeight 50

@class QJSselectBtnViews;
@protocol QJSselectBtnViewsDelegate <NSObject>

@optional
- (void)finacesNavButtonView:(QJSselectBtnViews *)navButtonView didSelectedButtonAtIndex:(NSInteger)buttonIndex;
@end


@interface QJSselectBtnViews : UIView
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,assign)NSInteger maxContent;
@property (nonatomic, assign) id<QJSselectBtnViewsDelegate> delegate;



+ (instancetype)finacesNavButtonViewWithTitleArray:(NSArray *)titleArray andSelectedIndex:(NSInteger)index;
+ (instancetype)finacesNavButtonViewWithTitleArray:(NSArray *)titleArray;
- (instancetype)initWithTitleArray:(NSArray *)titleArray andSelectedIndex:(NSInteger)index;
- (instancetype)initWithTitleArray:(NSArray *)titleArray;


@end
