//
//  SMMyFriendsViewController.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/26/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMMyFriendsViewController.h"
#import "SMConstants.h"
@interface SMMyFriendsViewController ()
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) NSArray *strangerArray;
@end

@implementation SMMyFriendsViewController
@synthesize friendsArray;
@synthesize strangerArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //SettingsButton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cog_deselected.png"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(presentSettingsView:)];
    
    // The className to query on
    self.parseClassName = kSMUserClassKey;
    
    // Whether the built-in pull-to-refresh is enabled
    self.pullToRefreshEnabled = YES;
    
    // Whether the built-in pagination is enabled
    self.paginationEnabled = NO;
    
    // The number of objects to show per page
    self.objectsPerPage = 20;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // My Profile, My Friends, Strangers
    return [self.objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - PFQueryTableViewController

- (PFQuery *)queryForTable {
    if (![PFUser currentUser]) {
        PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
        [query setLimit:0];
        return query;
    }
    
    PFQuery *relationUserQuery = [PFQuery queryWithClassName:kSMRelationUserClassKey];
    [relationUserQuery whereKey:kSMRelationUserFromUserKey equalTo:[PFUser currentUser]];
    relationUserQuery.cachePolicy = kPFCachePolicyNetworkOnly;
    relationUserQuery.limit = 200;
    
    PFQuery *friendsFromRelations = [PFQuery queryWithClassName:self.parseClassName];
    [friendsFromRelations whereKey:kSMRelation matchesKey:kDCTActivityToUserKey inQuery:followingActivitiesQuery];
    
    PFQuery *photosFromCurrentUserQuery = [PFQuery queryWithClassName:self.parseClassName];
    [photosFromCurrentUserQuery whereKey:kDCTPublishUserKey equalTo:[PFUser currentUser]];
    [photosFromCurrentUserQuery whereKey:kDCTPublishSavedKey equalTo:[NSNumber numberWithBool:TRUE]];
    
    PFQuery *allUserQuery = [PFQuery queryWithClassName:self.parseClassName];
    [allUserQuery whereKey:kDCTPublishSavedKey equalTo:[NSNumber numberWithBool:TRUE]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:allUserQuery, nil]];
    [query includeKey:kDCTPublishUserKey];
    [query orderByDescending:@"createdAt"];
    
    // A pull-to-refresh should always trigger a network request.
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    //
    // If there is no network connection, we will hit the cache first.
    if (self.objects.count == 0 || ![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    
    return cell;
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//Settings Views
- (void)presentSettingsView:(id)sender{
    //SMProfileViewController *profileViewController = [[SMProfileViewController alloc] init];
    //[self.navigationController pushViewController:profileViewController animated:YES];
}


@end
