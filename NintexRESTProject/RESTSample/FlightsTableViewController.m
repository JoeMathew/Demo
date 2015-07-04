//
//  FlightsTableViewController.m
//  RESTSample
//
//  Created by Joe Mathew on 26/06/2015.
//  Copyright (c) 2015 Joe Mathew. All rights reserved.
//

#import "FlightsTableViewController.h"
#import "appData.h"
#import "flightDetailCell.h"

@interface FlightsTableViewController ()

@end

@implementation FlightsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    appData *sharedData = [appData sharedInstance];
    return [sharedData.flightsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Row = %ld", (long)indexPath.row);
    flightDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flightcell"];
    if (nil == cell) {
        cell = [[flightDetailCell alloc] init];
    }
    
    appData *sharedData = [appData sharedInstance];
    NSMutableDictionary *flightInfo = [sharedData.flightsList objectAtIndex:indexPath.row];
    
    //NSLog(@"%@", flightInfo);
    cell.logoImgView.image = [flightInfo objectForKey:@"LogoImage"];

    cell.airlineLabel.text = (NSString *)[flightInfo objectForKey:@"AirlineName"];
        
    if (nil != [flightInfo objectForKey:@"TotalAmount"]) {
        cell.rateLabel.text = [[flightInfo objectForKey:@"TotalAmount"] stringValue];
    }
    
    cell.outTimeLabel.text = (NSString *)[flightInfo objectForKey:@"OutboundFlightsDuration"];
    cell.retTimeLabel.text = (NSString *)[flightInfo objectForKey:@"InboundFlightsDuration"];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
