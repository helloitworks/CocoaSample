//
//  SYXComplexTableViewWndCtrl.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "SYXComplexTableViewWndCtrl.h"
#import "SYXComplexTableCellView.h"

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

- (SYXApplicationBundleInfo *)_entityForRow:(NSInteger)row {
    return (SYXApplicationBundleInfo *)[self.tableContents objectAtIndex:row];
}


#pragma mark - tableview datasource
// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.tableContents count];
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
	return 24.f;
}

// This method is optional if you use bindings to provide the data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    // Group our "model" object, which is a dictionary
    SYXApplicationBundleInfo *bundleInfo = [self _entityForRow:row];
    
    // In IB the tableColumn has the identifier set to the same string as the keys in our dictionary
    NSString *identifier = [tableColumn identifier];
    if ([identifier isEqualToString:SYXBaseTableViewColumnMain])
    {
        // We pass us as the owner so we can setup target/actions into this main controller object
        SYXComplexTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        // Then setup properties on the cellView based on the column
        cellView.textField.stringValue = bundleInfo.displayName== nil ? @"nil": bundleInfo.displayName ;
        cellView.imageView.image = [[[NSWorkspace sharedWorkspace] iconForFile:bundleInfo.path] retain];
        return cellView;
    }
    else
    {
        NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
    }
    return nil;
}



- (IBAction)btnRunClicked:(id)sender
{
    
}

- (IBAction)btnRevealClicked:(id)sender
{
    
}
@end
