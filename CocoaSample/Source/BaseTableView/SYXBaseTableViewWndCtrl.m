//
//  SYXBaseTableViewWndCtrl.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-19.
//
//

#import "SYXBaseTableViewWndCtrl.h"
#import "SYXApplicationBundleInfo+View.h"

NSString *const SYXBaseTableViewColumnCheckBox = @"CheckBox";
NSString *const SYXBaseTableViewColumnAppName = @"AppName";
NSString *const SYXBaseTableViewColumnAppVersion = @"AppVersion";
NSString *const SYXBaseTableViewColumnBundleId = @"BundleId";
NSString *const SYXBaseTableViewColumnOperation = @"Operation";

@interface SYXBaseTableViewWndCtrl ()

@end

@implementation SYXBaseTableViewWndCtrl
@synthesize tableContents = _tableContents;
@synthesize tableView = _tableView;
@synthesize lblMsg = _lblMsg;

- (id)init{
    self = [super initWithWindowNibName:@"SYXBaseTableViewWnd"];
    if (self) {
        _tableContents = [[NSMutableArray alloc] init];
   
    }
    return self;
}

- (void)awakeFromNib
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.tableView setDoubleAction:@selector(tableViewDoubleClick:)];
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
    
    if ([identifier isEqualToString:SYXBaseTableViewColumnAppName])
    {
        // We pass us as the owner so we can setup target/actions into this main controller object
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        // Then setup properties on the cellView based on the column
        cellView.textField.stringValue = bundleInfo.displayName== nil ? @"nil": bundleInfo.displayName ;
        cellView.imageView.image = [[[NSWorkspace sharedWorkspace] iconForFile:bundleInfo.path] retain];
        return cellView;
        
    }
    else if ([identifier isEqualToString:SYXBaseTableViewColumnAppVersion])
    {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        textField.objectValue = bundleInfo.version == nil ? @"nil": bundleInfo.version ;
        return textField;
    }
    else if ([identifier isEqualToString:SYXBaseTableViewColumnBundleId])
    {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        textField.objectValue = bundleInfo.bundleId == nil ? @"nil": bundleInfo.bundleId ;
        return textField;
    }
    else if ([identifier isEqualToString:SYXBaseTableViewColumnOperation])
    {
        NSButton *button = [tableView makeViewWithIdentifier:identifier owner:self];
        button.title = @"run";
        return button;
    }
    else if ([identifier isEqualToString:SYXBaseTableViewColumnCheckBox])
    {
        NSButton *chkRow = [tableView makeViewWithIdentifier:identifier owner:self];
        chkRow.state = bundleInfo.isChecked;
        return chkRow;
    }
    else
    {
        NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
    }
    return nil;
}


//click or select
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSIndexSet *selectedRowIndexs = [self.tableView selectedRowIndexes];
	if(selectedRowIndexs == nil || selectedRowIndexs.count == 0 )
    {
		return;
	}
    else if(selectedRowIndexs.count == 1)
    {
        NSInteger row = selectedRowIndexs.firstIndex;
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you click row %ld",row];
    }
    else
    {
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you select multiple row"];
    }
}

#pragma mark - tableview action
//double click row
- (void)tableViewDoubleClick:(id)sender
{
    //NSInteger row = [self.tableView selectedRow];
    NSInteger row = self.tableView.clickedRow;
    if (row != -1)
    {
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you double click row %ld",row];
    }
    
}


#pragma mark - tablerowview control action
//in xib file, set tableview delegate and datasource, only after that, this action can take effect.
//set tableview delegat and datasource at this class at awakeFromNib function, this action can not take effect, it is wired.
- (IBAction)btnRunClicked:(id)sender
{
    NSInteger row = [self.tableView rowForView:sender];
    SYXApplicationBundleInfo *bundleInfo = [self _entityForRow:row];
     [[NSWorkspace sharedWorkspace] openFile:bundleInfo.path];
    //[[NSWorkspace sharedWorkspace] selectFile:bundleInfo.path inFileViewerRootedAtPath:nil];
}


- (IBAction)chkRowChecked:(id)sender
{
    NSInteger row = [self.tableView rowForView:sender];
    NSButton *chkRow = (NSButton *)sender;
    if (chkRow.state == NSOnState)
    {
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you check row %ld",row];
    }
    else
    {
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you uncheck row %ld",row];
    }
}

- (IBAction)chkAllChecked:(id)sender
{
    NSButton *chkAll = (NSButton *)sender;
    if (chkAll.state == NSOnState)
    {
        [self.tableContents enumerateObjectsUsingBlock:^(SYXApplicationBundleInfo *bundleInfo, NSUInteger idx, BOOL *stop)
        {
            bundleInfo.isChecked = YES;
        }];
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you check all"];
    }
    else
    {
        [self.tableContents enumerateObjectsUsingBlock:^(SYXApplicationBundleInfo *bundleInfo, NSUInteger idx, BOOL *stop)
        {
            bundleInfo.isChecked = NO;
        }];
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you uncheck all"];
    }
    [self.tableView reloadData];
}


@end
