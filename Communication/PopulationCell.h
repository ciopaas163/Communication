//
//  PopulationCell.h
//  Communication
//
//  Created by CIO on 15/3/6.
//  Copyright (c) 2015年 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"
@interface PopulationCell : UITableViewCell

{
    UIImageView* _imgBiao;

    UILabel* _textLabel;
    UILabel* _tet;
}

@property(strong, nonatomic)CellModel* model;




@end
