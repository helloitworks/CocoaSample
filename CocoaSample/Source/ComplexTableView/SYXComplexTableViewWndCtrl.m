//
//  SYXComplexTableViewWndCtrl.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "SYXComplexTableViewWndCtrl.h"
#import "SYXComplexTableCellView.h"
#import "SYXApplicationBundleInfo+ComplexTableView.h"

NSString *const SYXBaseTableViewColumnMain = @"Main";
float SYXDefaultTableViewRowHeight = 42.f;
float SYXExtensedTableViewRowHeight = 60.f;

@interface SYXComplexTableViewWndCtrl ()

@end

@implementation SYXComplexTableViewWndCtrl
@synthesize tableContents = _tableContents;
@synthesize tableView = _tableView;
@synthesize lblMsg = _lblMsg;
@synthesize selectedObjects = _selectedObjects;
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isNotEqualTo:@"selectedObjects"]) {
        keyPaths = [keyPaths setByAddingObject:@"selectedObjects"];
    }
    return keyPaths;
}

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

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    SYXApplicationBundleInfo *bundleInfo = [self _entityForRow:rowIndex];
    return bundleInfo;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    SYXApplicationBundleInfo *bundleInfo = [self _entityForRow:row];
    if (bundleInfo.isExtensed)
    {
        return SYXExtensedTableViewRowHeight;
    }
    //return tableView.rowHeight;
    return SYXDefaultTableViewRowHeight;
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
        cellView.imageView.image = [[[NSWorkspace sharedWorkspace] iconForFile:bundleInfo.path] retain];

        cellView.textField.stringValue = bundleInfo.displayName== nil ? @"nil": bundleInfo.displayName ;
        cellView.lblVersion.stringValue = bundleInfo.version == nil ? @"nil" : bundleInfo.version;
        cellView.lblPath.stringValue = bundleInfo.path == nil ? @"nil" : bundleInfo.path;
        if (bundleInfo.isExtensed)
        {
            [cellView.btnRemove setHidden:NO];
        }
        else
        {
            [cellView.btnRemove setHidden:YES];
        }
        return cellView;
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
    
    [self willChangeValueForKey:@"selectedObjects"];
    [self didChangeValueForKey:@"selectedObjects"];

    NSIndexSet *selectedRowIndexs = [self.tableView selectedRowIndexes];
	if(selectedRowIndexs == nil || selectedRowIndexs.count == 0 )
    {
		return;
	}
    else if(selectedRowIndexs.count == 1)
    {
        NSInteger row = selectedRowIndexs.firstIndex;
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you click row %ld",row];
        
        NSMutableIndexSet* rowIndexesNeedReload = [[[NSMutableIndexSet alloc] init] autorelease];
        [self.tableContents enumerateObjectsUsingBlock:^(SYXApplicationBundleInfo *bundleInfo, NSUInteger idx, BOOL *stop)
         {
             if (bundleInfo.isExtensed == YES)
             {
                 bundleInfo.isExtensed = NO;
                 [rowIndexesNeedReload addIndex:idx];
             }
         }];
        ((SYXApplicationBundleInfo *)[self.tableContents objectAtIndex:row]).isExtensed = YES;
        [rowIndexesNeedReload addIndex:row];
        [self.tableView reloadDataForRowIndexes: rowIndexesNeedReload columnIndexes: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, [self.tableView numberOfColumns])]];
        [self.tableView noteHeightOfRowsWithIndexesChanged:rowIndexesNeedReload];
    }
    else
    {
        self.lblMsg.stringValue = [NSString stringWithFormat:@"you select multiple row"];
        NSMutableIndexSet* rowIndexesNeedReload = [[[NSMutableIndexSet alloc] init] autorelease];
        [self.tableContents enumerateObjectsUsingBlock:^(SYXApplicationBundleInfo *bundleInfo, NSUInteger idx, BOOL *stop)
         {
             if (bundleInfo.isExtensed == YES)
             {
                 bundleInfo.isExtensed = NO;
                 [rowIndexesNeedReload addIndex:idx];
             }
         }];
        [self.tableView reloadDataForRowIndexes: rowIndexesNeedReload columnIndexes: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, [self.tableView numberOfColumns])]];
        [self.tableView noteHeightOfRowsWithIndexesChanged:rowIndexesNeedReload];
        
    }
}

#pragma mark - tableView control action
- (IBAction)btnRevealClicked:(id)sender
{
    NSInteger row = [self.tableView rowForView:sender];
    SYXApplicationBundleInfo *bundleInfo = [self _entityForRow:row];
    [[NSWorkspace sharedWorkspace] selectFile:bundleInfo.path inFileViewerRootedAtPath:nil];
}


// Select the same or next row (if possible)
- (void)_selectRowStartingAtRow:(NSInteger)row
{
    if ([self.tableView selectedRow] == -1)
    {
        if (row == -1)
        {
            row = 0;
        }
        
        while (row < [self.tableView numberOfRows])
        {
            [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
            return;
            row++;
        }
        
        row = [self.tableView numberOfRows] - 1;
        while (row >= 0)
        {
            [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
            return;
        }
        row--;
    }
}

- (IBAction)btnRemoveClicked:(id)sender
{
    NSInteger row = [self.tableView rowForView:sender];
    if (row != -1) {
        [self.tableContents removeObjectAtIndex:row];
        [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:row] withAnimation:NSTableViewAnimationEffectFade];
        [self _selectRowStartingAtRow:row];
    }
}

#pragma mark - right click menu

- (NSIndexSet *)_indexesToProcessForContextMenu {
    NSIndexSet *selectedIndexes = [self.tableView selectedRowIndexes];
    // If the clicked row was in the selectedIndexes, then we process all selectedIndexes. Otherwise, we process just the clickedRow
    if (self.tableView.clickedRow != -1 && ![selectedIndexes containsIndex:self.tableView.clickedRow]) {
        selectedIndexes = [NSIndexSet indexSetWithIndex:self.tableView.clickedRow];
    }
    return selectedIndexes;
}


- (IBAction)menuRevealClicked:(id)sender
{
    NSIndexSet *selectedIndexes = [self _indexesToProcessForContextMenu];
    [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger row, BOOL *stop) {
        SYXApplicationBundleInfo *bundleInfo = [self _entityForRow:row];
        [[NSWorkspace sharedWorkspace] selectFile:bundleInfo.path inFileViewerRootedAtPath:nil];
    }];
}


- (IBAction)menuRemoveRowClicked:(id)sender {
    NSIndexSet *indexes = [self _indexesToProcessForContextMenu];
    [self.tableView beginUpdates];
    [self.tableContents removeObjectsAtIndexes:indexes];
    [self.tableView removeRowsAtIndexes:indexes withAnimation:NSTableViewAnimationEffectFade];
    [self.tableView endUpdates];
}

- (BOOL)showRevealInFinderMenuItem
{
    NSIndexSet *indexes = [self _indexesToProcessForContextMenu];
    if (indexes.count == 1) {
        return YES;
    }
    else if (indexes.count > 1)
    {
        return NO;
    }
    else
    {
        return NO;
    }
}
@end
