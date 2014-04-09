//
//  BLSTableViewController.m
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import "BLSTableViewController.h"
#import "BLSTableViewCell.h"
#import "BLSManager.h"

static NSString *CellIdentifier = @"TableViewCell";

@interface BLSTableViewController ()

@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UIImageView *blurredImageView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation BLSTableViewController

-(void)dealloc
{
    [_tableView release];
    [_blurredImageView release];
    [_backgroundImageView release];
    [_cellNib release];
    
    [super dealloc];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
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
    self.tableView.pagingEnabled = YES;
    self.cellNib = [UINib nibWithNibName:@"BLSTableViewCell" bundle:nil];
    [self.tableView registerNib:self.cellNib forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:self.tableView];
    
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    CGFloat inset = 20;
    CGFloat welcomeHeight = 110;
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

    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.text = @"Loading...";
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headerLabel];
    [headerLabel release];
    
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    BLSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"BLSTableViewCell" owner:nil options:nil];
        cell = [arr objectAtIndex:0];
        cell.name.text = [NSString stringWithFormat:@"Appstore position: %d",indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return 44;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
