//
//  Todoitem.m
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import "Todoitem.h"

@implementation Todoitem

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"itemname"];
    [coder encodeObject:_desc forKey:@"itemdesc"];
    [coder encodeObject:_date forKey:@"itemdate"];
//    [coder encodeObject:_priority forKey:@"itempriority"];
//    [coder encodeObject:_priority_index forKey:@"itempriorityindex"];
    [coder encodeObject:_priortyTask forKey:@"priorty"];
    [coder encodeObject:_state forKey:@"state"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
//    [self setFname:[coder decodeObjectForKey:@"fname"]] ;
    [self setName:[coder decodeObjectForKey:@"itemname"]];
    [self setDesc:[coder decodeObjectForKey:@"itemdesc"]];
    [self setDate:[coder decodeObjectForKey:@"itemdate"]];
//    [self setPriority:[coder decodeObjectForKey:@"itempriority"]];
//    [self setPriority_index:[coder decodeObjectForKey:@"itempriorityindex"]];
    [self setPriortyTask:[coder decodeObjectForKey:@"priorty"]];
    [self setState:[coder decodeObjectForKey:@"state"]];
    
    return self;
}

@end
