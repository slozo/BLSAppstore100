//
//  BLSTableViewController.m
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import "BLSTableViewController.h"
#import "BLSManager.h"
#import <TSMessage.h>

static NSString *CellIdentifier = @"TableViewCell";

@interface BLSTableViewController ()

@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UIImageView *blurredImageView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, retain) UILabel *headerLabel;

@end

@implementation BLSTableViewController

-(void)dealloc
{
    [_tableView release];
    [_blurredImageView release];
    [_backgroundImageView release];
    [_cellNib release];
    [_headerLabel release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BLSNotificationDataReceived object:nil];
    
    
    [super dealloc];
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFetched) name:BLSNotificationDataReceived object:nil];
    }
    return self;
}

-(void)dataFetched
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.headerLabel.text = @"Welcome";
        
        [self.tableView reloadData];
    });
    
    //NSLog(@"Fetched: %@",[BLSManager sharedManager].dataStorage);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [TSMessage setDefaultViewController:self];
    
    UIImage *background = [UIImage imageNamed:@"bg"];
    
    self.backgroundImageView = [[[UIImageView alloc] initWithImage:background] autorelease];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    self.blurredImageView = [[[UIImageView alloc] init] autorelease];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredImageView.alpha = 0;
    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];
    
    self.tableView = [[[UITableView alloc] init] autorelease];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = NO;
    self.cellNib = [UINib nibWithNibName:@"BLSTableViewCell" bundle:nil];
    [self.tableView registerNib:self.cellNib forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:self.tableView];
    
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    CGFloat inset = 20;
    CGFloat welcomeHeight = 310;
    CGFloat iconHeight = 30;

    CGRect welcomeFrame = CGRectMake(inset,
                                         headerFrame.size.height - (welcomeHeight),
                                         headerFrame.size.width - (2 * inset),
                                         welcomeHeight);
    
    CGRect iconFrame = CGRectMake(inset,
                                  welcomeFrame.origin.y - iconHeight,
                                  iconHeight,
                                  iconHeight);
    
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    [header release];
    
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeFrame];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = @"BLStream";
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60];
    [header addSubview:welcomeLabel];
    [welcomeLabel release];

    self.headerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)] autorelease];
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.headerLabel.textColor = [UIColor whiteColor];
    self.headerLabel.text = @"Loading...";
    self.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:self.headerLabel];
    
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconFrame];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.backgroundColor = [UIColor clearColor];
    [header addSubview:iconView];
    [iconView release];
    
    [BLSManager sharedManager];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    self.backgroundImageView.frame = bounds;
    self.blurredImageView.frame = bounds;
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }

    return [[BLSManager sharedManager].dataStorage.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"CellIdentifier";
    __block UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    cell.textLabel.text = [BLSManager sharedManager].dataStorage.dataArray[indexPath.row][@"im:name"][@"label"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
    
        if (cell.imageView.image)
        {
            return ;
        }
        
        NSData *data0 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[BLSManager sharedManager].dataStorage.dataArray[indexPath.row][@"im:image"][0][@"label"]]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
         
            cell.imageView.image = [UIImage imageWithData:data0];
            
            [self.tableView reloadData];
     });
    });
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        return self.screenHeight;
    }
       return 44;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat height = scrollView.bounds.size.height;
    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);

    CGFloat percent = MIN(position / height, 1.0);

    self.blurredImageView.alpha = percent;
}

@end
