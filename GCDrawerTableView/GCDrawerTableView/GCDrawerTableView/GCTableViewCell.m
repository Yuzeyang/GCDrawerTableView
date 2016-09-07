//
//  GCTableViewCell.m
//  GCTableViewAnimationOne
//
//  Created by 宫城 on 16/9/6.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "GCTableViewCell.h"
#import "Masonry.h"
#import "GCDetailView.h"

#define GCDeviceHeight [UIScreen mainScreen].bounds.size.height

NSString *const GCTableViewCellIdentifier = @"GCTableViewCellIdentifier";

@interface GCTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *updateTimeLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIView *helperHideView;
@property (nonatomic, strong) GCDetailView *detailView;

@property (nonatomic, copy) GCCellDeselectBlock deselectBlock;

@property (nonatomic, strong) GCArticleModel *model;

@property (nonatomic, assign) CGRect originCellFrame;
@property (nonatomic, assign) CGRect originHelperViewFrame;
@property (nonatomic, assign) CGRect originDetailViewFrame;

@end

@implementation GCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.titleLabel = [[UILabel alloc] init];
    self.updateTimeLabel = [[UILabel alloc] init];
    self.infoLabel = [[UILabel alloc] init];
    self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.updateTimeLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.detailButton];
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(20));
        make.top.equalTo(@(20));
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    self.updateTimeLabel.font = [UIFont systemFontOfSize:10];
    self.updateTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@(-20));
        make.top.equalTo(@(20));
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    self.infoLabel.font = [UIFont systemFontOfSize:10];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 30));
    }];
    
    [self.detailButton setTitle:@"detail" forState:UIControlStateNormal];
    [self.detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.detailButton addTarget:self action:@selector(deselectCell) forControlEvents:UIControlEventTouchUpInside];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@(-20));
        make.top.equalTo(self.updateTimeLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

- (UIView *)helperHideView {
    if (!_helperHideView) {
        _helperHideView = [UIView new];
        _helperHideView.backgroundColor = [UIColor whiteColor];
        _helperHideView.alpha = 1.0;
    }
    return _helperHideView;
}

- (GCDetailView *)detailView {
    if (!_detailView) {
        _detailView = [GCDetailView new];
        _detailView.backgroundColor = [UIColor orangeColor];
    }
    return _detailView;
}

- (void)configCellWithArticleModel:(GCArticleModel *)articleModel {
    self.model = articleModel;
    self.titleLabel.text = articleModel.title;
    self.updateTimeLabel.text = articleModel.updateTime;
    self.infoLabel.text = [NSString stringWithFormat:@"Posted by %@ | %@ | %lu Comments",articleModel.author,articleModel.createTime,articleModel.commentsCount];
    [self.detailView configDetailViewWithArticleModel:articleModel];
}

- (void)deselectCell {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = self.originCellFrame;
        
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0.0;
        
        self.detailView.frame = self.originDetailViewFrame;
        self.helperHideView.frame = self.originHelperViewFrame;
    } completion:^(BOOL finished) {
        [self.helperHideView removeFromSuperview];
        [self.detailView removeFromSuperview];
        if (_deselectBlock) {
            _deselectBlock();
        }
    }];
    
}

- (void)selectToShowDetailWithContentOffsetY:(CGFloat)contentOffsetY {
    UIView *superview = self.superview;
    
    CGFloat height = CGRectGetMinY(self.frame) - contentOffsetY + 30;
    [self.helperHideView setFrame:CGRectMake(0, contentOffsetY, CGRectGetWidth(self.frame), height)];
    [superview insertSubview:self.helperHideView belowSubview:self];
    
    [self.detailView setFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - (GCDeviceHeight - 100 - 30*2),
                                         CGRectGetWidth(self.frame), GCDeviceHeight - 100 - 30*2)];
    [superview insertSubview:self.detailView belowSubview:self.helperHideView];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.frame;
        self.originCellFrame = rect;
        CGPoint origin = CGPointMake(0, contentOffsetY + 30);
        rect.origin = origin;
        self.frame = rect;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.2;
        
        CGRect rect2 = self.helperHideView.frame;
        self.originHelperViewFrame = rect2;
        CGPoint origin2 = CGPointMake(0, contentOffsetY + 30 - height);
        rect2.origin = origin2;
        self.helperHideView.frame = rect2;
        
        CGRect rect1 = self.detailView.frame;
        self.originDetailViewFrame = rect1;
        CGPoint origin1 = CGPointMake(0, 100 + 30 + contentOffsetY);
        rect1.origin = origin1;
        self.detailView.frame = rect1;
    }];
}

- (void)addDeselectBlock:(GCCellDeselectBlock)block {
    _deselectBlock = block;
}

@end
