//
//  InprogressVC.m
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import "InprogressVC.h"
#import "Todoitem.h"
#import "ItemdetailsVC.h"
@interface InprogressVC ()

@end

@implementation InprogressVC
{
    Todoitem *item;
    int is_deleted ;
}
static NSMutableArray *inprogress_items;
static NSMutableArray *inprogress_items_filter;
static NSMutableArray* low_todos;
static NSMutableArray* mid_todos;
static NSMutableArray* hig_todos;

+ (void)initialize
{
    inprogress_items = [NSMutableArray new];
//    inprogress_items_filter = [NSMutableArray new];
    low_todos = [NSMutableArray new];
    mid_todos = [NSMutableArray new];
    hig_todos = [NSMutableArray new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    printf("did Load inprogress \n");
    _inprogress_TV.delegate=self;
    _inprogress_TV.dataSource=self;
//    if(is_deleted==0)
//    {
//        inprogress_items = [self retrievArrayOfObjFromUserDefaults:@"inprogress"];
//        [_inprogress_TV reloadData];
//    }else{
//        printf("item deleted\n");
//    }
            
            inprogress_items = [self retrievArrayOfObjFromUserDefaults:@"inprogress"];
            inprogress_items_filter = [inprogress_items mutableCopy];
//    for(int i =0 ; i< [inprogress_items count] ; i++)
//    {
//        if([[[inprogress_items objectAtIndex:i] priortyTask]intValue] == 0)
//        {
//            [low_todos addObject:[inprogress_items objectAtIndex:i]];
//            [self saveArrayOfObjectToUserDefaults:@"lowtodosinprogress" :low_todos];
//        }else if ([[[inprogress_items objectAtIndex:i] priortyTask]intValue] == 1)
//        {
//            [mid_todos addObject:[inprogress_items objectAtIndex:i]];
//            [self saveArrayOfObjectToUserDefaults:@"midtodosinprogress" :mid_todos];
//        }else if ([[[inprogress_items objectAtIndex:i] priortyTask]intValue] == 2)
//        {
//            [hig_todos addObject:[inprogress_items objectAtIndex:i]];
//            [self saveArrayOfObjectToUserDefaults:@"higtodosinprogress" :hig_todos];
//        }
//    }
//    low_todos = [self retrievArrayOfObjFromUserDefaults:@"lowtodosinprogress"];
//    mid_todos = [self retrievArrayOfObjFromUserDefaults:@"midtodosinprogress"];
//    hig_todos = [self retrievArrayOfObjFromUserDefaults:@"higtodosinprogress"];
   
//            [_inprogress_TV reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
        inprogress_items = [self retrievArrayOfObjFromUserDefaults:@"inprogress"];
        inprogress_items_filter = [inprogress_items mutableCopy];
//    low_todos = [self retrievArrayOfObjFromUserDefaults:@"lowtodosinprogress"];
//    mid_todos = [self retrievArrayOfObjFromUserDefaults:@"midtodosinprogress"];
//    hig_todos = [self retrievArrayOfObjFromUserDefaults:@"higtodosinprogress"];
    [self saveArrayOfObjectToUserDefaults:@"inprogress" :inprogress_items];
//    [self saveArrayOfObjectToUserDefaults:@"lowtodosinprogress" :low_todos];
//    [self saveArrayOfObjectToUserDefaults:@"midtodosinprogress" :mid_todos];
//    [self saveArrayOfObjectToUserDefaults:@"higtodosinprogress" :hig_todos];
    [_inprogress_TV reloadData];
}
- (IBAction)segAction:(id)sender {
    NSPredicate *low = [NSPredicate predicateWithFormat:@"priortyTask == 0"];
    NSPredicate *mid = [NSPredicate predicateWithFormat:@"priortyTask == 1"];
    NSPredicate *hig = [NSPredicate predicateWithFormat:@"priortyTask == 2"];
    switch(_inprogress_filter.selectedSegmentIndex){
        case 0:
            inprogress_items_filter =[[inprogress_items filteredArrayUsingPredicate:low] mutableCopy];
            break;
        case 1:
            inprogress_items_filter =[[inprogress_items filteredArrayUsingPredicate:mid] mutableCopy];
            break;
        case 2:
            inprogress_items_filter =[[inprogress_items filteredArrayUsingPredicate:hig] mutableCopy];
            break;
    }
    [_inprogress_TV reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [self saveArrayOfObjectToUserDefaults:@"inprogress" :inprogress_items];
//    [self saveArrayOfObjectToUserDefaults:@"lowtodosinprogress" :low_todos];
//    [self saveArrayOfObjectToUserDefaults:@"midtodosinprogress" :mid_todos];
//    [self saveArrayOfObjectToUserDefaults:@"higtodosinprogress" :hig_todos];
//    inprogress_items = [self retrievArrayOfObjFromUserDefaults:@"inprogress"];
//    [_inprogress_TV reloadData];
//    is_deleted =0;
}
- (void)saveArrayOfObjectToUserDefaults:(NSString *)key :(NSMutableArray *)arr
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr]; //call encoding
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaults:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    inprogress_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return inprogress_items;
}

- (void)delCell:(Todoitem*)item :(NSInteger)index
{
//    if(item.priortyTask.intValue ==0)
//    {
//        [low_todos removeObjectAtIndex:index];
//    }else if (item.priortyTask.intValue ==1)
//    {
//        [mid_todos removeObjectAtIndex:index];
//    }else if (item.priortyTask.intValue ==2)
//    {
//        [hig_todos removeObjectAtIndex:index];
//    }
    [inprogress_items_filter removeObjectAtIndex:index];
    [inprogress_items removeObjectAtIndex:index];
    [self saveArrayOfObjectToUserDefaults:@"inprogress" :inprogress_items_filter];
    [self->_inprogress_TV reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [inprogress_items_filter count];
//    NSInteger number_of_rows =0;
//    switch(_inprogress_filter.selectedSegmentIndex)
//    {
//        case 0:
//            number_of_rows = [low_todos count];
//            break;
//        case 1:
//            number_of_rows = [mid_todos count];
//            break;
//        case 2:
//            number_of_rows = [hig_todos count];
//            break;
//    }
//    return number_of_rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    item = [inprogress_items_filter objectAtIndex:indexPath.row];



    if([item.priortyTask intValue]== 0)
    {
        cell.imageView.image =[UIImage imageNamed:@"L"];
    }else if ([item.priortyTask intValue]== 1)
//        [item.priority isEqual:@"M"]
    {
        cell.imageView.image = [UIImage imageNamed:@"M"];
    }else if ([item.priortyTask intValue]== 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"H"];
    }

    cell.textLabel.text = item.name;
//    switch(_inprogress_filter.selectedSegmentIndex)
//    {
//        case 0:
//            item =[low_todos objectAtIndex:indexPath.row];
//            cell.textLabel.text = item.name;
//            cell.imageView.image =[UIImage imageNamed:@"L"];
//            break;
//        case 1:
//
//            break;
//        case 2:
//
//            break;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //make alert
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"delete" message:@"do you want delete it" preferredStyle:UIAlertControllerStyleActionSheet];

    //create Button
    UIAlertAction *yes =
    [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        printf("Yes\n");
        [inprogress_items_filter removeObjectAtIndex:indexPath.row];
        [inprogress_items removeObjectAtIndex:indexPath.row];
//        self->is_deleted =1;
        [self saveArrayOfObjectToUserDefaults:@"inprogress" :inprogress_items_filter];
        [self->_inprogress_TV reloadData];
    }];

    UIAlertAction *no =
    [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        printf("NO\n");
    }];

    UIAlertAction *cancel =
    [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
     {
        printf("cancel\n");
    }];
    //add Button to alert
    [alert addAction:yes];
    [alert addAction:no];
    [alert addAction:cancel];
    //show alert
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done\n");
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemdetailsVC *itemdetailvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemdetailsVC"];
    item = [inprogress_items_filter objectAtIndex:indexPath.row];
    itemdetailvc.todoitem=item;
    itemdetailvc.index =  indexPath.row;
    [self.navigationController pushViewController:itemdetailvc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
