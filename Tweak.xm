#include <Preferences/PSSpecifier.h>
#include <Preferences/PSListController.h>
#import <RemoteLog.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface PSGGeneralController : PSListController
@end

@interface PSGResetPrefController : PSListController
@end

@interface PSUIGeneralController : PSListController
@end

@interface PSUIResetPrefController : PSListController
@end

%group iOS13
	%hook PSGGeneralController
	-(void)viewWillAppear:(BOOL)arg1 {
		%orig;
		[self removeSpecifierID:@"SOFTWARE_UPDATE_LINK" animated:NO];
	}

	/*- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		PSTableCell *cell = %orig;
		RLog(@"%@", cell.specifier.identifier);
		return cell;
	}*/
	%end

	%hook PSGResetPrefController
	-(void)viewWillAppear:(BOOL)arg1 {
		%orig;
		[self removeSpecifierID:@"fullErase" animated:NO];
	}

	/*- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		PSTableCell *cell = %orig;
		RLog(@"%@", cell.specifier.identifier);
		return cell;
	}*/
	%end
%end

%group iOS12
	%hook PSUIGeneralController
	-(void)viewDidAppear:(BOOL)arg1 {
		%orig;
		[self removeSpecifierID:@"SOFTWARE_UPDATE_LINK" animated:NO];
	}

	/*- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		PSTableCell *cell = %orig;
		RLog(@"%@", cell.specifier.identifier);
		return cell;
	}*/
	%end

	%hook PSUIResetPrefController
	-(void)viewDidAppear:(BOOL)arg1 {
		%orig;
		[self removeSpecifierID:@"fullErase" animated:NO];
	}

	/*- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		PSTableCell *cell = %orig;
		RLog(@"%@", cell.specifier.identifier);
		return cell;
	}*/
	%end
%end

%ctor {
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
		%init(iOS13);
	} else {
		%init(iOS12);
	}
}
