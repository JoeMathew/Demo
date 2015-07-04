//
//  flightDetailCell.h
//  RESTSample
//
//  Created by Joe Mathew on 27/06/2015.
//  Copyright (c) 2015 Joe Mathew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface flightDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *airlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *outTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *retTimeLabel;

@end
