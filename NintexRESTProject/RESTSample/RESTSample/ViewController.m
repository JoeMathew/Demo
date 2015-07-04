//
//  ViewController.m
//  RESTSample
//
//  Created by Joe Mathew on 25/06/2015.
//  Copyright (c) 2015 Joe Mathew. All rights reserved.
//

#import "ViewController.h"
#import "appData.h"

@interface ViewController () {
    BOOL isSearchCancelled;
}
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextField *sourceTextField;
@property (weak, nonatomic) IBOutlet UITextField *destnTextField;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *retDatePicker;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_startDatePicker setMinimumDate:[NSDate date]];
    [_retDatePicker setMinimumDate:[NSDate date]];
    _sourceTextField.delegate = self;
    _destnTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
}

- (IBAction)didTapSearchButton:(id)sender {
    
    if ([[_searchButton titleForState:UIControlStateNormal] isEqualToString:@"Search"]) {
        [_searchButton setTitle:@"Cancel" forState:UIControlStateNormal];
    } else {
        [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
        isSearchCancelled = YES;
        if ([_spinner isAnimating]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_spinner stopAnimating];
            });
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssxx"];
    
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *startDate = [dateFormatter stringFromDate:_startDatePicker.date];
    NSString *retDate = [dateFormatter stringFromDate:_retDatePicker.date];
    
    //Show activity indicator while the search is going on in the background.
    if (nil == _spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    if (![_spinner isAnimating]) {
        [self.view addSubview:_spinner];
        CGPoint spinnerCtr = CGPointMake(self.view.center.x, self.view.center.y*3/2);
        _spinner.center = spinnerCtr;
        [_spinner startAnimating];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSString *urlString = @"http://nmflightservice.cloudapp.net/api/Flight";
        NSString        *const paramString    = [NSString stringWithFormat:@"/?DepartureAirportCode=%@&ArrivalAirportCode=%@&DepartureDate=%@&ReturnDate=%@",_sourceTextField.text, _destnTextField.text, startDate, retDate ];
        NSString *reqUrlWithParam = [urlString stringByAppendingString:paramString];
        NSLog(@"Request URL = %@", reqUrlWithParam);
        
        NSURL           *const searchURL    = [NSURL URLWithString:urlString];
        NSData          *const responseData = [NSData dataWithContentsOfURL:searchURL];
        NSArray         *flights            = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        int i = 0;
        
        for ( NSMutableDictionary *flightInfo in flights) {
            //Replace the image address string with the actual image data
            NSData  *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:flightInfo[@"AirlineLogoAddress"]]];
            if (nil != imageData) {
                [flightInfo setObject:[UIImage imageWithData:imageData] forKey:@"LogoImage"];
            }
            i++;
        }
        NSLog(@"Number of flights = %d", i);
        appData *sharedAppData = [appData sharedInstance];
        [sharedAppData setFlightsList:[flights mutableCopy]];
        
        if (!isSearchCancelled) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([_spinner isAnimating]) {
                    [_spinner stopAnimating];
                }
                [self performSegueWithIdentifier:@"showResultsSegue" sender:sender];
            });
        }
    });

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int MAX_LENGHT = 3;
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return FALSE;
    }
    else if(textField.text.length > MAX_LENGHT-1)
    {
        if([string isEqualToString:@""] && range.length == 1)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        return TRUE;
    }
}

- (IBAction)didSelectStartDate:(id)sender {
    
}

- (IBAction)didSelectReturnDate:(id)sender {
    
}


@end
