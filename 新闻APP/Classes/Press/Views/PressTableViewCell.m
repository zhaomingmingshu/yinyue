//
//  HotspotTableViewCell.m
//  新闻APP
//
//  Created by qingyun on 16/7/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PressTableViewCell.h"
#import "ParseJsonModel.h"
#import "UIImageView+WebCache.h"
@interface PressTableViewCell (){
     __weak  UIImageView *_imageView;
      __weak UILabel *_label;
      __weak UILabel *_leftLabel;
      __weak UILabel *_rightLabel;
}
@end
@implementation PressTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *strHotspot = @"strHotspot";
    PressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell == nil){
        cell = [[PressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strHotspot];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self loadDefaultSetting];
    }
    return self;
}

- (void)setParseJsonModel:(ParseJsonModel *)parseJsonModel{
    _parseJsonModel = parseJsonModel;
    
   
    
//  dispatch_group_async(dispatch_group_create(),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//     NSURL *url = [NSURL URLWithString:_parseJsonModel.imgsrc];
//      NSData *data = [NSData dataWithContentsOfURL:url];
//      _imageView.image = [UIImage imageWithData:data];
    if(parseJsonModel.imgextra == nil || parseJsonModel.imgextra.count == 0 || parseJsonModel.imgextra == NULL  || _parseJsonModel.url ){
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_parseJsonModel.imgsrc]];
    }
//  });
    _label.text = _parseJsonModel.title;
    _leftLabel.text = _parseJsonModel.ptime;
    _rightLabel.text = [NSString stringWithFormat:@"%ld 评论",_parseJsonModel.votecount];

    
  }
- (void)loadDefaultSetting{
    UIImageView *imageView = [UIImageView new];
       [self addSubview:imageView];
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
   _imageView= imageView;
    
    UILabel *label = [UILabel new];
    [self addSubview:label];
    label.numberOfLines = 0;
    _label = label;
    
    UILabel *leftLabel = [UILabel new];
    [self addSubview:leftLabel];
    leftLabel.numberOfLines = 0;
    leftLabel.font = [UIFont systemFontOfSize:12];
    [leftLabel setTextColor:[UIColor grayColor]];
    _leftLabel = leftLabel;
    
    UILabel *rightLabel = [UILabel new];
    [self addSubview:rightLabel];
    rightLabel.numberOfLines = 0;
    rightLabel.font = [UIFont systemFontOfSize:12];
    rightLabel.textColor = [UIColor grayColor];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel = rightLabel;

  }

- (void)layoutSubviews{
    [super layoutSubviews];
   
    if(self.parseJsonModel.url == nil || [self.parseJsonModel.url isEqualToString:@"null"] || [self.parseJsonModel.url isEqualToString:@""] || self.parseJsonModel.url == NULL){
        _imageView.frame = CGRectMake(0, 0, 0, 0);
        
        _label.frame = CGRectMake(0, 0, 0, 0);
        _leftLabel.frame = CGRectMake(0, 0, 0, 0);
        
        _rightLabel.frame = CGRectMake(0,0, 0, 0);
       
            
    
          
    }

        
   
    
   _imageView.frame = CGRectMake(5, 5, 110, 90);
    
    _label.frame = CGRectMake(120, 5, self.frame.size.width-125, 55);
   _leftLabel.frame = CGRectMake(120, 75, 140, 20);
    
    _rightLabel.frame = CGRectMake(self.frame.size.width - 105,75, 100, 20);
}


@end
