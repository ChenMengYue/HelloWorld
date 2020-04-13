//
//  PGBStyleTextFieldContainerView.h
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/8/1.
//  Copyright © 2019 cmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGBStyleTextFieldViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PGBStyleTextFieldContainerView : UIView



-(instancetype)initWithFrame:(CGRect)frame viewModel:(PGBStyleTextFieldViewModel *)viewModel;

@property(nonatomic,strong,readonly)UIView *containView;





@end

NS_ASSUME_NONNULL_END
