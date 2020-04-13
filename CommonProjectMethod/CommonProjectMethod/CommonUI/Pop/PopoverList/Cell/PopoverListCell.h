//
//  PopoverListCell.h
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/9.
//  Copyright © 2019 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopoverListCell : UITableViewCell

+(instancetype)cellAllocWithTableView:(UITableView *)tableView indexP:(NSIndexPath *)indexPath;
@property(nonatomic,copy)NSString *title;


@end

NS_ASSUME_NONNULL_END
