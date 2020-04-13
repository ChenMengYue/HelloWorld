//
//  CmyExpandLabel.m
//  kyapp
//
//  Created by 陈梦悦 on 2019/1/1.
//  Copyright © 2019 ypjy. All rights reserved.
//

#import "CmyExpandLabel.h"
#import <CoreText/CoreText.h>
#import "MyVerticalLable.h"
//#import "CommonProjectDefines.h"
#import "NSString+Attribution.h"
#import "Masonry.h"
#import "C_MacroOfConstants.h"
@interface CmyExpandLabel ()
//default no
@property(nonatomic,assign)BOOL isShowAll;

@property(nonatomic,strong)NSAttributedString *simpleAttrStr;
@property(nonatomic,strong)NSAttributedString *detailAttrStr;
@property(nonatomic,strong)NSAttributedString *wholeAttrStr;

@end

@implementation CmyExpandLabel


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _numOfshowExpand=3;
        _isShowExpandBtn=NO;
        _isShowAll=NO;
        
    }
    return self;
}


-(IBAction)onActionOfChangeExpandState:(UIButton *)sender{
    [self setIsShowAll:!sender.selected];
}


-(void)setLineSpace:(float)lineSpace{
    if (_lineSpace==lineSpace) {
        return;
    }
    _lineSpace=lineSpace;
    _detailAttrStr=nil;
    _wholeAttrStr=nil;
    _simpleAttrStr=nil;
}

-(void)setTextSpace:(float)textSpace{
    if (_textSpace==textSpace) {
        return;
    }
    _textSpace=textSpace;
    _detailAttrStr=nil;
    _wholeAttrStr=nil;
    _simpleAttrStr=nil;
    
}

-(void)setIsShowAll:(BOOL)isShowAll{
    if (_isShowAll==isShowAll) {
        return;
    }
    _btnExpand.selected=isShowAll;
    _isShowAll=isShowAll;
    
    if (_delegate && [_delegate respondsToSelector:@selector(onChangeExpandState:)]) {
        [_delegate onChangeExpandState:_isShowAll];
    }
    [self reloadContentFrame];
}

-(void)setNumOfshowExpand:(int)numOfshowExpand{
    if (_numOfshowExpand==numOfshowExpand) {
        return;
    }
    _numOfshowExpand=numOfshowExpand;
    if (!_isShowExpandBtn) {
        return;
    }
    _wholeAttrStr=nil;
    _simpleAttrStr=nil;
    
}

-(void)setIsShowExpandBtn:(BOOL)isShowExpandBtn{
    if (_isShowExpandBtn==isShowExpandBtn) {
        return;
    }
    _isShowExpandBtn=isShowExpandBtn;
    _detailAttrStr=nil;
    _simpleAttrStr=nil;
    _wholeAttrStr=nil;
}


#pragma mark --初始化 数据 begin



-(MyVerticalLable *)vertaicalLal{
    if (!_vertaicalLal) {
        _vertaicalLal=[[MyVerticalLable alloc]init];
        _vertaicalLal.verticalAlignment=VerticalAlignmentTop;
        _vertaicalLal.textColor=[UIColor fontColorOfMainGrayStyle];
        _vertaicalLal.font=C_FONTSIZE_SMALL;
        _vertaicalLal.numberOfLines=0;
        [self addSubview:_vertaicalLal];
        
    }
    return _vertaicalLal;
}

-(UIButton *)btnExpand{
    if (!_btnExpand) {
        _btnExpand =[[UIButton alloc]init];
//        [_btnExpand setImage:[UIImage imageNamed:@"箭头-下"] forState:UIControlStateNormal];
//        [_btnExpand setImage:[UIImage imageNamed:@"箭头-上"] forState:UIControlStateSelected];
        [_btnExpand setTitle:@"全文" forState:UIControlStateNormal];
        [_btnExpand setTitle:@"收起" forState:UIControlStateSelected];
        _btnExpand.titleLabel.font=C_FONTSIZE_SMALL;

        [_btnExpand setTitleColor:[UIColor fontColorOfMainBlueStyle] forState:UIControlStateNormal];
        [_btnExpand setTitleColor:[UIColor fontColorOfMainBlueStyle] forState:UIControlStateSelected];

        [_btnExpand addTarget:self action:@selector(onActionOfChangeExpandState:) forControlEvents:UIControlEventTouchUpInside];
        [_btnExpand setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:_btnExpand];
        [_btnExpand setHidden:YES];
        self.vertaicalLal.numberOfLines=0;
        
    }
    return _btnExpand;
}
-(NSAttributedString *)detailAttrStr{
    if (!_detailAttrStr) {
        if (!C_StringIsEffective(_content)) {
            return _detailAttrStr;
        }
        if ([self isNeesShowAttributeContent]) {
            _detailAttrStr=[self.content getAttributeStyleByTextFont:self.vertaicalLal.font color:self.vertaicalLal.textColor lineSpace:_lineSpace textSpace:_textSpace];
            
            
            
        }else{
            self.vertaicalLal.text=_content;
            _detailAttrStr=self.vertaicalLal.attributedText;
        }
    }
    return _detailAttrStr;
}

-(void)loadExpandDetails{
    if (!self.detailAttrStr ||!C_StringIsEffective(self.detailAttrStr.string)) {
        
        return;
    }
    NSArray *lineCount=[self getLinesArrayOfStringInLabel:self.content andlblWidth:self.frame.size.width?self.frame.size.width:_lalWidth andSetString:self.detailAttrStr];
    if (_numOfshowExpand>=lineCount.count) {
        _wholeAttrStr=_detailAttrStr;
        _simpleAttrStr=_detailAttrStr;
        return ;
    }
    
    
    _simpleAttrStr=[[self getStringForLast:lineCount numberofline:_numOfshowExpand] getAttributeStyleByTextFont:self.vertaicalLal.font color:self.vertaicalLal.textColor lineSpace:_lineSpace textSpace:_textSpace];

    _wholeAttrStr=[[self getStringForLast:lineCount numberofline:(int)[lineCount count]] getAttributeStyleByTextFont:self.vertaicalLal.font color:self.vertaicalLal.textColor lineSpace:_lineSpace textSpace:_textSpace];
    
    
}

-(NSAttributedString *)wholeAttrStr{
    if (!_wholeAttrStr) {
        [self loadExpandDetails];
    }
    return _wholeAttrStr;
}

-(NSAttributedString *)simpleAttrStr{
    if (!_simpleAttrStr) {
        [self loadExpandDetails];
    }
    return _simpleAttrStr;
}
#pragma mark --初始化 数据 end

-(void)reloadViewRect{
    [self.vertaicalLal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.btnExpand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.vertaicalLal);
        make.size.mas_equalTo(CGSizeMake(45, 20));
    }];
}

-(void)setContent:(NSString *)content{
    _content=content;
    [self reloadContentFrame];
    
}

-(void)reloadContentFrame{
    
    if (!C_StringIsEffective(self.content)) {
        self.vertaicalLal.text=@"";
        [self.btnExpand setHidden:YES];
        [self reloadViewRect];
        return;
    }
    
    if (!_isShowExpandBtn) {
        if(_btnExpand) {
            [self.btnExpand setHidden:YES];
        }
        if (![self isNeesShowAttributeContent]) {
            self.vertaicalLal.text=self.content;
        }else{
            self.vertaicalLal.attributedText=self.detailAttrStr;
        }
        [self reloadViewRect];
        
        return;
    }
    
    if (self.btnExpand.isHidden==YES) {
        [self.btnExpand setHidden:NO];
    }
    
    
    
    //numofexpand
    if (_isShowAll) {
        self.vertaicalLal.attributedText=self.wholeAttrStr;
        if (_wholeAttrStr==self.detailAttrStr) {
            [self.btnExpand setHidden:YES];
        }else{
        }
        [self reloadViewRect];
        return;
    }
    
    self.vertaicalLal.attributedText=self.simpleAttrStr;
    if (self.simpleAttrStr==self.detailAttrStr) {
        [self.btnExpand setHidden:YES];
    }
    [self reloadViewRect];
}


#pragma mark --确定的方法
-(BOOL)isNeesShowAttributeContent{
    if (_lineSpace!=0 || _textSpace!=0) {
        return YES;
    }
    return NO;
}



//计算文字有多少行
-(NSArray *)getLinesArrayOfStringInLabel:(NSString *)contentText andlblWidth:(CGFloat)lblwidth andSetString:(NSAttributedString *)attStr{
    NSAttributedString *setString;
    if ([attStr length]) {
        setString =attStr;
    }else{
        setString=[contentText getAttributeStyleByTextFont:self.vertaicalLal.font color:self.vertaicalLal.textColor lineSpace:_lineSpace textSpace:_textSpace];

    }
    CTFramesetterRef frameSetter=CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)setString);
    CGMutablePathRef path = CGPathCreateMutable ();
    CGPathAddRect(path, NULL, CGRectMake (8,8,lblwidth, 100000));
    //CTFramesetterCreateFrame
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines =(__bridge NSArray *) CTFrameGetLines (frame);
    
    NSMutableArray *linesArray =[[NSMutableArray alloc]init];
    
    for  (id line in lines)
    {
        CTLineRef lineRef=(__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange (lineRange.location, lineRange.length);
        NSString *lineString = [contentText substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return  (NSArray *) linesArray;
}

//进行文字的拼接
-(NSString *)getStringForLast:(NSArray *)lblArr numberofline:(int)number{
    NSMutableString *text= [[NSMutableString alloc] init];
    //获取第最后一行 label 的内容并让其显示其中一部分的内容
    if (![lblArr count]) {
        return text;
    }
    NSInteger maxCount=[lblArr[0] length];
    
    if  (lblArr.count >number){
        NSString *text1=lblArr[number-1];
        NSString *b;
        
        
        if  (text1.length>= maxCount-2) {
//            b=[text1 substringToIndex:text1.length-11];
            b=[text1 substringToIndex:text1.length-4];
        }
        else {
            b = text1;
        }
        //将三行字符重新拼接，如果字符串有截取，则加“... "
        
        for  (int i =0;i<number; i++)
        {
            if  (i!= number- 1 || text1.length  <maxCount-2) {
                
                text= (NSMutableString*) [text stringByAppendingString: lblArr [i]];
            }
            else {
                
                text= (NSMutableString*) [text stringByAppendingFormat: @"%@... ", b];
            }
        }
    }
    //如果内容长度不超过 MAXNUM 行，则不采取任何方法
    else {
        
        for  (int i= 0; i<lblArr.count; i++) {
            
            text =  (NSMutableString*) [text stringByAppendingString:lblArr [i]];
        }
    }
    return text;
}




@end
