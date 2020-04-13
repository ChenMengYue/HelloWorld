//
//  PopoverListCell.m
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/9.
//  Copyright © 2019 王亮. All rights reserved.
//

#import "PopoverListCell.h"
#import "Masonry.h"
#import "C_MacroOfConstants.h"

@interface PopoverListCell ()

@property(nonatomic,strong)UILabel *lalDetail;

@end

@implementation PopoverListCell


+(instancetype)cellAllocWithTableView:(UITableView *)tableView indexP:(NSIndexPath *)indexPath {
    NSString *identifier=@"PopoverListCell";
    PopoverListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor=[UIColor fontColorOfMainBlackStyle];
        self.textLabel.font=C_FONTSIZE_COMMON;
        
        _lalDetail=[[UILabel alloc]initWithFrame:CGRectZero];
        _lalDetail.textColor=[UIColor fontColorOfMainBlackStyle];
        _lalDetail.font=C_FONTSIZE_SMALL;
//        _lalDetail.textAlignment=NSTextAlignmentCenter;
        _lalDetail.textAlignment=NSTextAlignmentLeft;
        [self addSubview:_lalDetail];
        [_lalDetail mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
            make.centerX.equalTo(self);
            make.left.equalTo(self.mas_left).offset(widthAdapterBack(20));
            make.top.bottom.equalTo(self);
        }];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title=title;
    _lalDetail.text=title;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.accessoryType=selected?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;


    // Configure the view for the selected state
}

@end
