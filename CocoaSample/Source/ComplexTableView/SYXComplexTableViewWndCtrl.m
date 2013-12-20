//
//  SYXComplexTableViewWndCtrl.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "SYXComplexTableViewWndCtrl.h"

NSString *const SYXBaseTableViewColumnMain = @"Main";

@interface SYXComplexTableViewWndCtrl ()

@end

@implementation SYXComplexTableViewWndCtrl
@synthesize tableContents = _tableContents;
@synthesize tableView = _tableView;
@synthesize lblMsg = _lblMsg;

- (id)init{
    self = [super initWithWindowNibName:@"SYXComplexTableViewWnd"];
    if (self) {
        _tableContents = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self loadApp];
}

- (void)loadApp
{
    NSString *appDirectory = [SYXSystemManager defaultApplicationPath:NSSystemDomainMask];
    self.tableContents = [NSMutableArray arrayWithArray:[[SYXSystemManager bundleInfosInDirectory:appDirectory searchLevel:1] allValues]];
    [self.tableView reloadData];
}


- (IBAction)btnRunClicked:(id)sender
{
    
}

- (IBAction)btnRevealClicked:(id)sender
{
    
}
@end
