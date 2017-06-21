////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMTestCase.h"

@interface PrimitiveArrayPropertyTests : RLMTestCase
@end

@implementation PrimitiveArrayPropertyTests {
    AllPrimitiveArrays *unmanaged;
    AllPrimitiveArrays *managed;
    AllOptionalPrimitiveArrays *optUnmanaged;
    AllOptionalPrimitiveArrays *optManaged;
    RLMRealm *realm;
}

- (void)setUp {
    unmanaged = [[AllPrimitiveArrays alloc] init];
    optUnmanaged = [[AllOptionalPrimitiveArrays alloc] init];
    realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    managed = [AllPrimitiveArrays createInRealm:realm withValue:@[]];
    optManaged = [AllOptionalPrimitiveArrays createInRealm:realm withValue:@[]];
}

- (void)tearDown {
    [realm cancelWriteTransaction];
}

- (void)testUnmanagedCount {
    XCTAssertEqual(unmanaged.intObj.count, 0U);
    [unmanaged.intObj addObject:@1];
    XCTAssertEqual(unmanaged.intObj.count, 1U);
}

- (void)testUnmanagedType {
    XCTAssertEqual(unmanaged.boolObj.type, RLMPropertyTypeBool);
    XCTAssertEqual(unmanaged.intObj.type, RLMPropertyTypeInt);
    XCTAssertEqual(unmanaged.floatObj.type, RLMPropertyTypeFloat);
    XCTAssertEqual(unmanaged.doubleObj.type, RLMPropertyTypeDouble);
    XCTAssertEqual(unmanaged.stringObj.type, RLMPropertyTypeString);
    XCTAssertEqual(unmanaged.dataObj.type, RLMPropertyTypeData);
    XCTAssertEqual(unmanaged.dateObj.type, RLMPropertyTypeDate);
    XCTAssertEqual(optUnmanaged.boolObj.type, RLMPropertyTypeBool);
    XCTAssertEqual(optUnmanaged.intObj.type, RLMPropertyTypeInt);
    XCTAssertEqual(optUnmanaged.floatObj.type, RLMPropertyTypeFloat);
    XCTAssertEqual(optUnmanaged.doubleObj.type, RLMPropertyTypeDouble);
    XCTAssertEqual(optUnmanaged.stringObj.type, RLMPropertyTypeString);
    XCTAssertEqual(optUnmanaged.dataObj.type, RLMPropertyTypeData);
    XCTAssertEqual(optUnmanaged.dateObj.type, RLMPropertyTypeDate);
}

- (void)testUnmanagedOptional {
    XCTAssertFalse(unmanaged.boolObj.optional);
    XCTAssertFalse(unmanaged.intObj.optional);
    XCTAssertFalse(unmanaged.floatObj.optional);
    XCTAssertFalse(unmanaged.doubleObj.optional);
    XCTAssertFalse(unmanaged.stringObj.optional);
    XCTAssertFalse(unmanaged.dataObj.optional);
    XCTAssertFalse(unmanaged.dateObj.optional);
    XCTAssertTrue(optUnmanaged.boolObj.optional);
    XCTAssertTrue(optUnmanaged.intObj.optional);
    XCTAssertTrue(optUnmanaged.floatObj.optional);
    XCTAssertTrue(optUnmanaged.doubleObj.optional);
    XCTAssertTrue(optUnmanaged.stringObj.optional);
    XCTAssertTrue(optUnmanaged.dataObj.optional);
    XCTAssertTrue(optUnmanaged.dateObj.optional);
}

- (void)testUnmanagedObjectClassName {
    XCTAssertNil(unmanaged.boolObj.objectClassName);
    XCTAssertNil(unmanaged.intObj.objectClassName);
    XCTAssertNil(unmanaged.floatObj.objectClassName);
    XCTAssertNil(unmanaged.doubleObj.objectClassName);
    XCTAssertNil(unmanaged.stringObj.objectClassName);
    XCTAssertNil(unmanaged.dataObj.objectClassName);
    XCTAssertNil(unmanaged.dateObj.objectClassName);
    XCTAssertNil(optUnmanaged.boolObj.objectClassName);
    XCTAssertNil(optUnmanaged.intObj.objectClassName);
    XCTAssertNil(optUnmanaged.floatObj.objectClassName);
    XCTAssertNil(optUnmanaged.doubleObj.objectClassName);
    XCTAssertNil(optUnmanaged.stringObj.objectClassName);
    XCTAssertNil(optUnmanaged.dataObj.objectClassName);
    XCTAssertNil(optUnmanaged.dateObj.objectClassName);
}

- (void)testUnmanagedRealm {
    XCTAssertNil(unmanaged.boolObj.realm);
    XCTAssertNil(unmanaged.intObj.realm);
    XCTAssertNil(unmanaged.floatObj.realm);
    XCTAssertNil(unmanaged.doubleObj.realm);
    XCTAssertNil(unmanaged.stringObj.realm);
    XCTAssertNil(unmanaged.dataObj.realm);
    XCTAssertNil(unmanaged.dateObj.realm);
    XCTAssertNil(optUnmanaged.boolObj.realm);
    XCTAssertNil(optUnmanaged.intObj.realm);
    XCTAssertNil(optUnmanaged.floatObj.realm);
    XCTAssertNil(optUnmanaged.doubleObj.realm);
    XCTAssertNil(optUnmanaged.stringObj.realm);
    XCTAssertNil(optUnmanaged.dataObj.realm);
    XCTAssertNil(optUnmanaged.dateObj.realm);
}

- (void)testUnmanagedInvalidated {
    RLMArray *array;
    @autoreleasepool {
        AllPrimitiveArrays *obj = [[AllPrimitiveArrays alloc] init];
        array = obj.intObj;
        XCTAssertFalse(array.invalidated);
    }
    XCTAssertFalse(array.invalidated);
}


// unmanaged.boolObj @YES @NO
// unmanaged.intObj @2 @3
// unmanaged.floatObj @2.2f @3.3f
// unmanaged.doubleObj @2.2 @3.3
// unmanaged.stringObj @"a" @"b"
// unmanaged.dataObj data(1) data(2)
// unmanaged.dateObj date(1) date(2)
// optUnmanaged.boolObj @YES @NO NSNull.null
// optUnmanaged.intObj @2 @3 NSNull.null
// optUnmanaged.floatObj @2.2f @3.3f NSNull.null
// optUnmanaged.doubleObj @2.2 @3.3 NSNull.null
// optUnmanaged.stringObj @"a" @"b" NSNull.null
// optUnmanaged.dataObj data(1) data(2) NSNull.null
// optUnmanaged.dateObj date(1) date(2) NSNull.null

static NSDate *date(int i) {
    return [NSDate dateWithTimeIntervalSince1970:i];
}
static NSData *data(int i) {
    return [NSData dataWithBytesNoCopy:calloc(i, 1) length:i freeWhenDone:YES];
}

- (void)testUnmanagedObjectAtIndex {
    RLMAssertThrowsWithReason([unmanaged.intObj objectAtIndex:0],
                              @"Index 0 is out of bounds (must be less than 0).");

    [unmanaged.intObj addObject:@1];
    XCTAssertEqualObjects([unmanaged.intObj objectAtIndex:0], @1);
}

- (void)testUnmanagedFirstObject {
    XCTAssertNil(unmanaged.boolObj.firstObject);
    XCTAssertNil(unmanaged.intObj.firstObject);
    XCTAssertNil(unmanaged.floatObj.firstObject);
    XCTAssertNil(unmanaged.doubleObj.firstObject);
    XCTAssertNil(unmanaged.stringObj.firstObject);
    XCTAssertNil(unmanaged.dataObj.firstObject);
    XCTAssertNil(unmanaged.dateObj.firstObject);
    XCTAssertNil(optUnmanaged.boolObj.firstObject);
    XCTAssertNil(optUnmanaged.intObj.firstObject);
    XCTAssertNil(optUnmanaged.floatObj.firstObject);
    XCTAssertNil(optUnmanaged.doubleObj.firstObject);
    XCTAssertNil(optUnmanaged.stringObj.firstObject);
    XCTAssertNil(optUnmanaged.dataObj.firstObject);
    XCTAssertNil(optUnmanaged.dateObj.firstObject);

    [unmanaged.boolObj addObjects:@[@YES, @NO]];
    [unmanaged.intObj addObjects:@[@2, @3]];
    [unmanaged.floatObj addObjects:@[@2.2f, @3.3f]];
    [unmanaged.doubleObj addObjects:@[@2.2, @3.3]];
    [unmanaged.stringObj addObjects:@[@"a", @"b"]];
    [unmanaged.dataObj addObjects:@[data(1), data(2)]];
    [unmanaged.dateObj addObjects:@[date(1), date(2)]];
    XCTAssertEqualObjects(unmanaged.boolObj.firstObject, @YES);
    XCTAssertEqualObjects(unmanaged.intObj.firstObject, @2);
    XCTAssertEqualObjects(unmanaged.floatObj.firstObject, @2.2f);
    XCTAssertEqualObjects(unmanaged.doubleObj.firstObject, @2.2);
    XCTAssertEqualObjects(unmanaged.stringObj.firstObject, @"a");
    XCTAssertEqualObjects(unmanaged.dataObj.firstObject, data(1));
    XCTAssertEqualObjects(unmanaged.dateObj.firstObject, date(1));

    [optUnmanaged.boolObj addObject:NSNull.null];
    [optUnmanaged.intObj addObject:NSNull.null];
    [optUnmanaged.floatObj addObject:NSNull.null];
    [optUnmanaged.doubleObj addObject:NSNull.null];
    [optUnmanaged.stringObj addObject:NSNull.null];
    [optUnmanaged.dataObj addObject:NSNull.null];
    [optUnmanaged.dateObj addObject:NSNull.null];

    XCTAssertEqualObjects(optUnmanaged.boolObj.firstObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.intObj.firstObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.floatObj.firstObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.doubleObj.firstObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.stringObj.firstObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.dataObj.firstObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.dateObj.firstObject, NSNull.null);

    [optUnmanaged.boolObj removeAllObjects];
    [optUnmanaged.intObj removeAllObjects];
    [optUnmanaged.floatObj removeAllObjects];
    [optUnmanaged.doubleObj removeAllObjects];
    [optUnmanaged.stringObj removeAllObjects];
    [optUnmanaged.dataObj removeAllObjects];
    [optUnmanaged.dateObj removeAllObjects];

    [optUnmanaged.boolObj addObjects:@[@YES, @NO]];
    [optUnmanaged.intObj addObjects:@[@2, @3]];
    [optUnmanaged.floatObj addObjects:@[@2.2f, @3.3f]];
    [optUnmanaged.doubleObj addObjects:@[@2.2, @3.3]];
    [optUnmanaged.stringObj addObjects:@[@"a", @"b"]];
    [optUnmanaged.dataObj addObjects:@[data(1), data(2)]];
    [optUnmanaged.dateObj addObjects:@[date(1), date(2)]];

    XCTAssertEqualObjects(optUnmanaged.boolObj.firstObject, @YES);
    XCTAssertEqualObjects(optUnmanaged.intObj.firstObject, @2);
    XCTAssertEqualObjects(optUnmanaged.floatObj.firstObject, @2.2f);
    XCTAssertEqualObjects(optUnmanaged.doubleObj.firstObject, @2.2);
    XCTAssertEqualObjects(optUnmanaged.stringObj.firstObject, @"a");
    XCTAssertEqualObjects(optUnmanaged.dataObj.firstObject, data(1));
    XCTAssertEqualObjects(optUnmanaged.dateObj.firstObject, date(1));
}

- (void)testUnmanagedLastObject {
    XCTAssertNil(unmanaged.boolObj.lastObject);
    XCTAssertNil(unmanaged.intObj.lastObject);
    XCTAssertNil(unmanaged.floatObj.lastObject);
    XCTAssertNil(unmanaged.doubleObj.lastObject);
    XCTAssertNil(unmanaged.stringObj.lastObject);
    XCTAssertNil(unmanaged.dataObj.lastObject);
    XCTAssertNil(unmanaged.dateObj.lastObject);
    XCTAssertNil(optUnmanaged.boolObj.lastObject);
    XCTAssertNil(optUnmanaged.intObj.lastObject);
    XCTAssertNil(optUnmanaged.floatObj.lastObject);
    XCTAssertNil(optUnmanaged.doubleObj.lastObject);
    XCTAssertNil(optUnmanaged.stringObj.lastObject);
    XCTAssertNil(optUnmanaged.dataObj.lastObject);
    XCTAssertNil(optUnmanaged.dateObj.lastObject);

    [unmanaged.boolObj addObjects:@[@YES, @NO]];
    [unmanaged.intObj addObjects:@[@2, @3]];
    [unmanaged.floatObj addObjects:@[@2.2f, @3.3f]];
    [unmanaged.doubleObj addObjects:@[@2.2, @3.3]];
    [unmanaged.stringObj addObjects:@[@"a", @"b"]];
    [unmanaged.dataObj addObjects:@[data(1), data(2)]];
    [unmanaged.dateObj addObjects:@[date(1), date(2)]];
    XCTAssertEqualObjects(unmanaged.boolObj.lastObject, @NO);
    XCTAssertEqualObjects(unmanaged.intObj.lastObject, @3);
    XCTAssertEqualObjects(unmanaged.floatObj.lastObject, @3.3f);
    XCTAssertEqualObjects(unmanaged.doubleObj.lastObject, @3.3);
    XCTAssertEqualObjects(unmanaged.stringObj.lastObject, @"b");
    XCTAssertEqualObjects(unmanaged.dataObj.lastObject, data(2));
    XCTAssertEqualObjects(unmanaged.dateObj.lastObject, date(2));

    [optUnmanaged.boolObj addObject:NSNull.null];
    [optUnmanaged.intObj addObject:NSNull.null];
    [optUnmanaged.floatObj addObject:NSNull.null];
    [optUnmanaged.doubleObj addObject:NSNull.null];
    [optUnmanaged.stringObj addObject:NSNull.null];
    [optUnmanaged.dataObj addObject:NSNull.null];
    [optUnmanaged.dateObj addObject:NSNull.null];

    XCTAssertEqualObjects(optUnmanaged.boolObj.lastObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.intObj.lastObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.floatObj.lastObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.doubleObj.lastObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.stringObj.lastObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.dataObj.lastObject, NSNull.null);
    XCTAssertEqualObjects(optUnmanaged.dateObj.lastObject, NSNull.null);

    [optUnmanaged.boolObj addObjects:@[@YES, @NO]];
    [optUnmanaged.intObj addObjects:@[@2, @3]];
    [optUnmanaged.floatObj addObjects:@[@2.2f, @3.3f]];
    [optUnmanaged.doubleObj addObjects:@[@2.2, @3.3]];
    [optUnmanaged.stringObj addObjects:@[@"a", @"b"]];
    [optUnmanaged.dataObj addObjects:@[data(1), data(2)]];
    [optUnmanaged.dateObj addObjects:@[date(1), date(2)]];

    XCTAssertEqualObjects(optUnmanaged.boolObj.lastObject, @NO);
    XCTAssertEqualObjects(optUnmanaged.intObj.lastObject, @3);
    XCTAssertEqualObjects(optUnmanaged.floatObj.lastObject, @3.3f);
    XCTAssertEqualObjects(optUnmanaged.doubleObj.lastObject, @3.3);
    XCTAssertEqualObjects(optUnmanaged.stringObj.lastObject, @"b");
    XCTAssertEqualObjects(optUnmanaged.dataObj.lastObject, data(2));
    XCTAssertEqualObjects(optUnmanaged.dateObj.lastObject, date(2));
}

- (void)testUnmanagedAddObject {
    RLMAssertThrowsWithReason([unmanaged.intObj addObject:@"a"],
                              @"Invalid value 'a' of type '__NSCFConstantString' for array of 'int'");
    RLMAssertThrowsWithReason([unmanaged.intObj addObject:NSNull.null],
                              @"Invalid value '<null>' of type 'NSNull' for array of 'int'");
}

- (void)testUnmanagedAddObjects {

}

- (void)testUnmanagedInsertObject {

}

- (void)testUnmanagedRemoveObject {
    AllPrimitiveArrays *obj = [[AllPrimitiveArrays alloc] init];
    RLMAssertThrowsWithReason([obj.intObj removeObjectAtIndex:0],
                              @"Index 0 is out of bounds (must be less than 0).");

}

- (void)testUnmanagedRemoveLastObject {

}

- (void)testUnmanagedReplace {

}

- (void)testUnmanagedMove {

}

- (void)testUnmanagedExchange {

}

- (void)testUnmanagedIndexOfObject {

}

- (void)testUnmanagedIndexOfObjectWhere {

}

- (void)testUnmanagedIndexOfObjectWithPredicate {

}

- (void)testUnmanagedSort {

}

- (void)testUnmanagedNotifications {

}

- (void)testUnmanagedMin {

}

- (void)testUnmanagedMax {

}

- (void)testUnmanagedSum {

}

- (void)testUnmanagedAverage {

}

- (void)testUnmanagedFastEnumeration {

}

- (void)testUnmanagedFastEnumerationWithMutation {

}

- (void)testUnmanagedValueForKey {

}

- (void)testUnmanagedSetValueForKey {

}

- (void)testUnmanagedAssignment {

}

- (void)testUnmanagedDescription {

}

#if 0
- (void)testUnmanagedArrayCanOutliveParentObject {
    RLMArray *array;
    @autoreleasepool {
        ArrayPropertyObject *arObj = [[ArrayPropertyObject alloc] initWithValue:@[@"arrayObject", @[@[@"a"]], @[]]];
        array = arObj.array;
        XCTAssertFalse(array.isInvalidated, @"stringArray should be valid after creation.");
        arObj = nil;
    }
    XCTAssertFalse(array.isInvalidated, @"stringArray should still be valid after parent deletion.");
}

- (void)testDeleteObjectWithArrayProperty {
    RLMRealm *realm = [self realmWithTestPath];

    [realm beginWriteTransaction];
    ArrayPropertyObject *arObj = [ArrayPropertyObject createInRealm:realm withValue:@[@"arrayObject", @[@[@"a"]], @[]]];
    RLMArray *stringArray = arObj.array;
    XCTAssertFalse(stringArray.isInvalidated, @"stringArray should be valid after creation.");
    [realm deleteObject:arObj];
    XCTAssertTrue(stringArray.isInvalidated, @"stringArray should be invalid after parent deletion.");
    [realm commitWriteTransaction];
}

- (void)testDeleteObjectInArrayProperty {
    RLMRealm *realm = [self realmWithTestPath];

    [realm beginWriteTransaction];
    ArrayPropertyObject *arObj = [ArrayPropertyObject createInRealm:realm withValue:@[@"arrayObject", @[@[@"a"]], @[]]];
    RLMArray *stringArray = arObj.array;
    StringObject *firstObject = stringArray.firstObject;
    [realm deleteObjects:[StringObject allObjectsInRealm:realm]];
    XCTAssertFalse(stringArray.isInvalidated, @"stringArray should be valid after member object deletion.");
    XCTAssertTrue(firstObject.isInvalidated, @"firstObject should be invalid after deletion.");
    XCTAssertEqual(stringArray.count, 0U, @"stringArray.count should be zero after deleting its only member.");
    [realm commitWriteTransaction];
}

-(void)testInsertMultiple {
    RLMRealm *realm = [self realmWithTestPath];

    [realm beginWriteTransaction];
    ArrayPropertyObject *obj = [ArrayPropertyObject createInRealm:realm withValue:@[@"arrayObject", @[], @[]]];
    StringObject *child1 = [StringObject createInRealm:realm withValue:@[@"a"]];
    StringObject *child2 = [[StringObject alloc] init];
    child2.stringCol = @"b";
    [obj.array addObjects:@[child2, child1]];
    [realm commitWriteTransaction];

    RLMResults *children = [StringObject allObjectsInRealm:realm];
    XCTAssertEqualObjects([children[0] stringCol], @"a", @"First child should be 'a'");
    XCTAssertEqualObjects([children[1] stringCol], @"b", @"Second child should be 'b'");
}

-(void)testInsertAtIndex {
    RLMRealm *realm = [self realmWithTestPath];

    [realm beginWriteTransaction];
    ArrayPropertyObject *obj = [ArrayPropertyObject createInRealm:realm withValue:@[@"arrayObject", @[], @[]]];
    StringObject *child1 = [StringObject createInRealm:realm withValue:@[@"a"]];
    StringObject *child2 = [[StringObject alloc] init];
    child2.stringCol = @"b";
    [obj.array addObject:child2];
    RLMAssertThrowsWithReasonMatching([obj.array insertObject:child1 atIndex:2], @"must be less than 2");
    [realm commitWriteTransaction];

    RLMArray *children = obj.array;
    XCTAssertEqual(children.count, 1U);
    XCTAssertEqualObjects([children[0] stringCol], @"b", @"Only child should be 'b'");
}

- (void)testMove {
    RLMRealm *realm = [self realmWithTestPath];

    ArrayPropertyObject *obj = [[ArrayPropertyObject alloc] initWithValue:@[@"arrayObject", @[@[@"a"], @[@"b"]], @[]]];
    RLM_GENERIC_ARRAY(StringObject) *children = obj.array;

    [children moveObjectAtIndex:1 toIndex:0];

    XCTAssertEqualObjects([children[0] stringCol], @"b");
    XCTAssertEqualObjects([children[1] stringCol], @"a");

    [children moveObjectAtIndex:0 toIndex:1];

    XCTAssertEqualObjects([children[0] stringCol], @"a");
    XCTAssertEqualObjects([children[1] stringCol], @"b");

    [children moveObjectAtIndex:0 toIndex:0];

    XCTAssertEqualObjects([children[0] stringCol], @"a");
    XCTAssertEqualObjects([children[1] stringCol], @"b");

    RLMAssertThrowsWithReasonMatching([children moveObjectAtIndex:0 toIndex:2], @"must be less than 2");
    RLMAssertThrowsWithReasonMatching([children moveObjectAtIndex:2 toIndex:0], @"must be less than 2");

    [realm beginWriteTransaction];

    [realm addObject:obj];
    children = obj.array;

    [children moveObjectAtIndex:1 toIndex:0];

    XCTAssertEqualObjects([children[0] stringCol], @"b");
    XCTAssertEqualObjects([children[1] stringCol], @"a");

    [children moveObjectAtIndex:0 toIndex:1];

    XCTAssertEqualObjects([children[0] stringCol], @"a");
    XCTAssertEqualObjects([children[1] stringCol], @"b");

    [children moveObjectAtIndex:0 toIndex:0];

    XCTAssertEqualObjects([children[0] stringCol], @"a");
    XCTAssertEqualObjects([children[1] stringCol], @"b");

    RLMAssertThrowsWithReasonMatching([children moveObjectAtIndex:0 toIndex:2], @"must be less than 2");
    RLMAssertThrowsWithReasonMatching([children moveObjectAtIndex:2 toIndex:0], @"must be less than 2");

    [realm commitWriteTransaction];

    RLMAssertThrowsWithReasonMatching([children moveObjectAtIndex:1 toIndex:0], @"write transaction");
}

- (void)testAddInvalidated {
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    CompanyObject *company = [CompanyObject createInDefaultRealmWithValue:@[@"company", @[]]];

    EmployeeObject *person = [[EmployeeObject alloc] init];
    person.name = @"Mary";
    [realm addObject:person];
    [realm deleteObjects:[EmployeeObject allObjects]];

    RLMAssertThrowsWithReasonMatching([company.employees addObject:person], @"invalidated");
    RLMAssertThrowsWithReasonMatching([company.employees insertObject:person atIndex:0], @"invalidated");

    [realm cancelWriteTransaction];
}

- (void)testAddNil {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    CompanyObject *company = [CompanyObject createInDefaultRealmWithValue:@[@"company", @[]]];

    RLMAssertThrowsWithReasonMatching([company.employees addObject:self.nonLiteralNil], @"nil");
    [realm cancelWriteTransaction];
}

- (void)testUnmanaged {
    AllPrimitiveArrays *obj = [[AllPrimitiveArrays alloc] init];
    XCTAssertTrue([obj.intObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.floatObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.doubleObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.boolObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.stringObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.dataObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.dateObj isKindOfClass:[RLMArray class]]);

    [obj.intObj addObject:@1];
    XCTAssertEqualObjects(obj.intObj[0], @1);
    XCTAssertThrows([obj.intObj addObject:@""]);

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    obj = [AllPrimitiveArrays createInRealm:realm withValue:@[@[],@[],@[],@[],@[],@[],@[]]];

    XCTAssertTrue([obj.intObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.floatObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.doubleObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.boolObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.stringObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.dataObj isKindOfClass:[RLMArray class]]);
    XCTAssertTrue([obj.dateObj isKindOfClass:[RLMArray class]]);

    [obj.intObj addObject:@5];
    XCTAssertEqualObjects(obj.intObj.firstObject, @5);
}

- (void)testReplaceObjectAtIndexInUnmanagedArray {
    ArrayPropertyObject *array = [[ArrayPropertyObject alloc] init];
    array.name = @"name";

    StringObject *stringObj1 = [[StringObject alloc] init];
    stringObj1.stringCol = @"a";
    StringObject *stringObj2 = [[StringObject alloc] init];
    stringObj2.stringCol = @"b";
    StringObject *stringObj3 = [[StringObject alloc] init];
    stringObj3.stringCol = @"c";
    [array.array addObject:stringObj1];
    [array.array addObject:stringObj2];
    [array.array addObject:stringObj3];

    IntObject *intObj1 = [[IntObject alloc] init];
    intObj1.intCol = 0;
    IntObject *intObj2 = [[IntObject alloc] init];
    intObj2.intCol = 1;
    IntObject *intObj3 = [[IntObject alloc] init];
    intObj3.intCol = 2;
    [array.intArray addObject:intObj1];
    [array.intArray addObject:intObj2];
    [array.intArray addObject:intObj3];

    XCTAssertEqualObjects(array.array[0], stringObj1, @"Objects should be equal");
    XCTAssertEqualObjects(array.array[1], stringObj2, @"Objects should be equal");
    XCTAssertEqualObjects(array.array[2], stringObj3, @"Objects should be equal");
    XCTAssertEqual(array.array.count, 3U, @"Should have 3 elements in string array");

    XCTAssertEqualObjects(array.intArray[0], intObj1, @"Objects should be equal");
    XCTAssertEqualObjects(array.intArray[1], intObj2, @"Objects should be equal");
    XCTAssertEqualObjects(array.intArray[2], intObj3, @"Objects should be equal");
    XCTAssertEqual(array.intArray.count, 3U, @"Should have 3 elements in int array");

    StringObject *stringObj4 = [[StringObject alloc] init];
    stringObj4.stringCol = @"d";

    [array.array replaceObjectAtIndex:0 withObject:stringObj4];
    XCTAssertTrue([[array.array objectAtIndex:0] isEqualToObject:stringObj4], @"Objects should be replaced");
    XCTAssertEqual(array.array.count, 3U, @"Should have 3 elements in int array");

    IntObject *intObj4 = [[IntObject alloc] init];
    intObj4.intCol = 3;

    [array.intArray replaceObjectAtIndex:1 withObject:intObj4];
    XCTAssertTrue([[array.intArray objectAtIndex:1] isEqualToObject:intObj4], @"Objects should be replaced");
    XCTAssertEqual(array.intArray.count, 3U, @"Should have 3 elements in int array");

    RLMAssertThrowsWithReasonMatching([array.array replaceObjectAtIndex:0 withObject:(id)intObj4],
                                      @"IntObject.*StringObject");
    RLMAssertThrowsWithReasonMatching([array.intArray replaceObjectAtIndex:1 withObject:(id)stringObj4],
                                      @"StringObject.*IntObject");
}

- (void)testDeleteObjectInUnmanagedArray {
    ArrayPropertyObject *array = [[ArrayPropertyObject alloc] init];
    array.name = @"name";

    StringObject *stringObj1 = [[StringObject alloc] init];
    stringObj1.stringCol = @"a";
    StringObject *stringObj2 = [[StringObject alloc] init];
    stringObj2.stringCol = @"b";
    StringObject *stringObj3 = [[StringObject alloc] init];
    stringObj3.stringCol = @"c";
    [array.array addObject:stringObj1];
    [array.array addObject:stringObj2];
    [array.array addObject:stringObj3];

    IntObject *intObj1 = [[IntObject alloc] init];
    intObj1.intCol = 0;
    IntObject *intObj2 = [[IntObject alloc] init];
    intObj2.intCol = 1;
    IntObject *intObj3 = [[IntObject alloc] init];
    intObj3.intCol = 2;
    [array.intArray addObject:intObj1];
    [array.intArray addObject:intObj2];
    [array.intArray addObject:intObj3];

    XCTAssertEqualObjects(array.array[0], stringObj1, @"Objects should be equal");
    XCTAssertEqualObjects(array.array[1], stringObj2, @"Objects should be equal");
    XCTAssertEqualObjects(array.array[2], stringObj3, @"Objects should be equal");
    XCTAssertEqual(array.array.count, 3U, @"Should have 3 elements in string array");

    XCTAssertEqualObjects(array.intArray[0], intObj1, @"Objects should be equal");
    XCTAssertEqualObjects(array.intArray[1], intObj2, @"Objects should be equal");
    XCTAssertEqualObjects(array.intArray[2], intObj3, @"Objects should be equal");
    XCTAssertEqual(array.intArray.count, 3U, @"Should have 3 elements in int array");

    [array.array removeLastObject];

    XCTAssertEqualObjects(array.array[0], stringObj1, @"Objects should be equal");
    XCTAssertEqualObjects(array.array[1], stringObj2, @"Objects should be equal");
    XCTAssertEqual(array.array.count, 2U, @"Should have 2 elements in string array");

    [array.array removeLastObject];

    XCTAssertEqualObjects(array.array[0], stringObj1, @"Objects should be equal");
    XCTAssertEqual(array.array.count, 1U, @"Should have 1 elements in string array");

    [array.array removeLastObject];

    XCTAssertEqual(array.array.count, 0U, @"Should have 0 elements in string array");

    [array.intArray removeAllObjects];
    XCTAssertEqual(array.intArray.count, 0U, @"Should have 0 elements in int array");
}

- (void)testExchangeObjectAtIndexWithObjectAtIndex {

    void (^test)(RLMArray *) = ^(RLMArray *array) {
        [array exchangeObjectAtIndex:0 withObjectAtIndex:1];
        XCTAssertEqual(2U, array.count);
        XCTAssertEqualObjects(@"b", [array[0] stringCol]);
        XCTAssertEqualObjects(@"a", [array[1] stringCol]);

        [array exchangeObjectAtIndex:1 withObjectAtIndex:1];
        XCTAssertEqual(2U, array.count);
        XCTAssertEqualObjects(@"b", [array[0] stringCol]);
        XCTAssertEqualObjects(@"a", [array[1] stringCol]);

        [array exchangeObjectAtIndex:1 withObjectAtIndex:0];
        XCTAssertEqual(2U, array.count);
        XCTAssertEqualObjects(@"a", [array[0] stringCol]);
        XCTAssertEqualObjects(@"b", [array[1] stringCol]);

        RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:1 withObjectAtIndex:20], @"less than 2");
    };

    ArrayPropertyObject *array = [[ArrayPropertyObject alloc] initWithValue:@[@"foo", @[@[@"a"], @[@"b"]], @[]]];
    test(array.array);

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:array];
    test(array.array);
    [realm commitWriteTransaction];
}

- (void)testIndexOfObject
{
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    EmployeeObject *po1 = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @40, @"hired": @YES}];
    EmployeeObject *po2 = [EmployeeObject createInRealm:realm withValue:@{@"name": @"John", @"age": @30, @"hired": @NO}];
    EmployeeObject *po3 = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Jill", @"age": @25, @"hired": @YES}];
    EmployeeObject *deleted = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Jill", @"age": @25, @"hired": @YES}];
    EmployeeObject *indirectlyDeleted = [EmployeeObject allObjectsInRealm:realm].lastObject;
    [realm deleteObject:deleted];

    // create company
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [company.employees addObjects:[EmployeeObject allObjects]];
    [company.employees removeObjectAtIndex:1];

    // test unmanaged
    XCTAssertEqual(0U, [company.employees indexOfObject:po1]);
    XCTAssertEqual(1U, [company.employees indexOfObject:po3]);
    XCTAssertEqual((NSUInteger)NSNotFound, [company.employees indexOfObject:po2]);

    // add to realm
    [realm addObject:company];
    [realm commitWriteTransaction];

    // test LinkView RLMArray
    XCTAssertEqual(0U, [company.employees indexOfObject:po1]);
    XCTAssertEqual(1U, [company.employees indexOfObject:po3]);
    XCTAssertEqual((NSUInteger)NSNotFound, [company.employees indexOfObject:po2]);

    // non realm employee
    EmployeeObject *notInRealm = [[EmployeeObject alloc] initWithValue:@[@"NoName", @1, @NO]];
    XCTAssertEqual((NSUInteger)NSNotFound, [company.employees indexOfObject:notInRealm]);

    // invalid object
    XCTAssertThrows([company.employees indexOfObject:(EmployeeObject *)company]);
    RLMAssertThrowsWithReasonMatching([company.employees indexOfObject:deleted], @"invalidated");
    RLMAssertThrowsWithReasonMatching([company.employees indexOfObject:indirectlyDeleted], @"invalidated");

    RLMResults *employees = [company.employees objectsWhere:@"age = %@", @40];
    XCTAssertEqual(0U, [employees indexOfObject:po1]);
    XCTAssertEqual((NSUInteger)NSNotFound, [employees indexOfObject:po3]);
}

- (void)testIndexOfObjectWhere
{
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    EmployeeObject *po1 = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @40, @"hired": @YES}];
    [EmployeeObject createInRealm:realm withValue:@{@"name": @"John", @"age": @30, @"hired": @NO}];
    EmployeeObject *po3 = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Jill", @"age": @25, @"hired": @YES}];
    EmployeeObject *po4 = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Bill", @"age": @55, @"hired": @YES}];

    // create company
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [company.employees addObjects:@[po3, po1, po4]];

    // test unmanaged
    XCTAssertEqual(0U, [company.employees indexOfObjectWhere:@"name = 'Jill'"]);
    XCTAssertEqual(1U, [company.employees indexOfObjectWhere:@"name = 'Joe'"]);
    XCTAssertEqual((NSUInteger)NSNotFound, [company.employees indexOfObjectWhere:@"name = 'John'"]);

    // add to realm
    [realm addObject:company];
    [realm commitWriteTransaction];

    // test LinkView RLMArray
    XCTAssertEqual(0U, [company.employees indexOfObjectWhere:@"name = 'Jill'"]);
    XCTAssertEqual(1U, [company.employees indexOfObjectWhere:@"name = 'Joe'"]);
    XCTAssertEqual((NSUInteger)NSNotFound, [company.employees indexOfObjectWhere:@"name = 'John'"]);

    RLMResults *results = [company.employees objectsWhere:@"age > 30"];
    XCTAssertEqual(0U, [results indexOfObjectWhere:@"name = 'Joe'"]);
    XCTAssertEqual(1U, [results indexOfObjectWhere:@"name = 'Bill'"]);
    XCTAssertEqual((NSUInteger)NSNotFound, [results indexOfObjectWhere:@"name = 'John'"]);
    XCTAssertEqual((NSUInteger)NSNotFound, [results indexOfObjectWhere:@"name = 'Jill'"]);
}

- (void)testFastEnumeration
{
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [realm addObject:company];
    [realm commitWriteTransaction];

    // enumerate empty array
    for (__unused id obj in company.employees) {
        XCTFail(@"Should be empty");
    }

    [realm beginWriteTransaction];
    for (int i = 0; i < 30; ++i) {
        EmployeeObject *eo = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @40, @"hired": @YES}];
        [company.employees addObject:eo];
    }
    [realm commitWriteTransaction];

    XCTAssertEqual(company.employees.count, 30U);

    __weak id objects[30];
    NSInteger count = 0;
    for (EmployeeObject *e in company.employees) {
        XCTAssertNotNil(e, @"Object is not nil and accessible");
        if (count > 16) {
            // 16 is the size of blocks fast enumeration happens to ask for at
            // the moment, but of course that's just an implementation detail
            // that may change
            XCTAssertNil(objects[count - 16]);
        }
        objects[count++] = e;
    }

    XCTAssertEqual(count, 30, @"should have enumerated 30 objects");

    for (int i = 0; i < count; i++) {
        XCTAssertNil(objects[i], @"Object should have been released");
    }

    @autoreleasepool {
        for (EmployeeObject *e in company.employees) {
            objects[0] = e;
            break;
        }
    }
    XCTAssertNil(objects[0], @"Object should have been released");
}

- (void)testModifyDuringEnumeration {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [realm addObject:company];

    const size_t totalCount = 40;
    for (size_t i = 0; i < totalCount; ++i) {
        [company.employees addObject:[EmployeeObject createInRealm:realm withValue:@[@"name", @(i), @NO]]];
    }

    size_t count = 0;
    for (EmployeeObject *eo in company.employees) {
        ++count;
        [company.employees addObject:eo];
    }
    XCTAssertEqual(totalCount, count);
    XCTAssertEqual(totalCount * 2, company.employees.count);

    [realm cancelWriteTransaction];

    // Unmanaged array
    company = [[CompanyObject alloc] init];
    for (size_t i = 0; i < totalCount; ++i) {
        [company.employees addObject:[[EmployeeObject alloc] initWithValue:@[@"name", @(i), @NO]]];
    }

    count = 0;
    for (EmployeeObject *eo in company.employees) {
        ++count;
        [company.employees addObject:eo];
    }
    XCTAssertEqual(totalCount, count);
    XCTAssertEqual(totalCount * 2, company.employees.count);
}

- (void)testDeleteDuringEnumeration {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [realm addObject:company];

    const size_t totalCount = 40;
    for (size_t i = 0; i < totalCount; ++i) {
        [company.employees addObject:[EmployeeObject createInRealm:realm withValue:@[@"name", @(i), @NO]]];
    }

    [realm commitWriteTransaction];

    [realm beginWriteTransaction];
    for (__unused EmployeeObject *eo in company.employees) {
        [realm deleteObjects:company.employees];
    }
    [realm commitWriteTransaction];
}

- (void)testValueForKey {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    XCTAssertEqualObjects([company.employees valueForKey:@"name"], @[]);
    [realm addObject:company];
    [realm commitWriteTransaction];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], @[]);

    // managed
    NSMutableArray *ages = [NSMutableArray array];
    [realm beginWriteTransaction];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(i)];
        EmployeeObject *eo = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }
    [realm commitWriteTransaction];

    RLM_GENERIC_ARRAY(EmployeeObject) *employeeObjects = [company valueForKey:@"employees"];
    NSMutableArray *kvcAgeProperties = [NSMutableArray array];
    for (EmployeeObject *employee in employeeObjects) {
        [kvcAgeProperties addObject:@(employee.age)];
    }
    XCTAssertEqualObjects(kvcAgeProperties, ages);

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] firstObject] isEqualToObject:company.employees.firstObject]);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] lastObject] isEqualToObject:company.employees.lastObject]);

    XCTAssertEqual([[company.employees valueForKeyPath:@"@count"] integerValue], 30);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@min.age"] integerValue], 0);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@max.age"] integerValue], 29);
    XCTAssertEqualWithAccuracy([[company.employees valueForKeyPath:@"@avg.age"] doubleValue], 14.5, 0.1f);

    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@unionOfObjects.age"],
                          (@[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29]));
    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@distinctUnionOfObjects.name"], (@[@"Joe"]));

    RLMAssertThrowsWithReasonMatching([company.employees valueForKeyPath:@"@sum.dogs.@sum.age"], @"Nested key paths.*not supported");

    // unmanaged object
    company = [[CompanyObject alloc] init];
    ages = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(i)];
        EmployeeObject *eo = [[EmployeeObject alloc] initWithValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] firstObject] isEqualToObject:company.employees.firstObject]);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] lastObject] isEqualToObject:company.employees.lastObject]);

    XCTAssertEqual([[company.employees valueForKeyPath:@"@count"] integerValue], 30);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@min.age"] integerValue], 0);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@max.age"] integerValue], 29);
    XCTAssertEqualWithAccuracy([[company.employees valueForKeyPath:@"@avg.age"] doubleValue], 14.5, 0.1f);

    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@unionOfObjects.age"],
                          (@[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29]));
    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@distinctUnionOfObjects.name"], (@[@"Joe"]));

    RLMAssertThrowsWithReasonMatching([company.employees valueForKeyPath:@"@sum.dogs.@sum.age"], @"Nested key paths.*not supported");
}

- (void)testSetValueForKey {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";

    [company.employees setValue:@"name" forKey:@"name"];
    XCTAssertEqualObjects([company.employees valueForKey:@"name"], @[]);

    [realm addObject:company];
    [realm commitWriteTransaction];

    XCTAssertThrows([company.employees setValue:@10 forKey:@"age"]);
    XCTAssertEqualObjects([company.employees valueForKey:@"age"], @[]);

    // managed
    NSMutableArray *ages = [NSMutableArray array];
    [realm beginWriteTransaction];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(20)];
        EmployeeObject *eo = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    [company.employees setValue:@20 forKey:@"age"];
    [realm commitWriteTransaction];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);

    // unmanaged object
    company = [[CompanyObject alloc] init];
    ages = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(20)];
        EmployeeObject *eo = [[EmployeeObject alloc] initWithValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    [company.employees setValue:@20 forKey:@"age"];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
}

- (void)testObjectAggregate {
    RLMRealm *realm = [RLMRealm defaultRealm];

    AggregateArrayObject *obj = [AggregateArrayObject new];
    XCTAssertEqual(0, [obj.array sumOfProperty:@"intCol"].intValue);
    XCTAssertNil([obj.array averageOfProperty:@"intCol"]);
    XCTAssertNil([obj.array minOfProperty:@"intCol"]);
    XCTAssertNil([obj.array maxOfProperty:@"intCol"]);

    NSDate *dateMinInput = [NSDate date];
    NSDate *dateMaxInput = [dateMinInput dateByAddingTimeInterval:1000];

    [realm transactionWithBlock:^{
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];

        [obj.array addObjects:[AggregateObject allObjectsInRealm:realm]];
    }];

    void (^test)(void) = ^{
        RLMArray *array = obj.array;

        // SUM
        XCTAssertEqual([array sumOfProperty:@"intCol"].integerValue, 4);
        XCTAssertEqualWithAccuracy([array sumOfProperty:@"floatCol"].floatValue, 7.2f, 0.1f);
        XCTAssertEqualWithAccuracy([array sumOfProperty:@"doubleCol"].doubleValue, 10.0, 0.1f);
        RLMAssertThrowsWithReasonMatching([array sumOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array sumOfProperty:@"boolCol"], @"sum.*bool");
        RLMAssertThrowsWithReasonMatching([array sumOfProperty:@"dateCol"], @"sum.*date");

        // Average
        XCTAssertEqualWithAccuracy([array averageOfProperty:@"intCol"].doubleValue, 0.4, 0.1f);
        XCTAssertEqualWithAccuracy([array averageOfProperty:@"floatCol"].doubleValue, 0.72, 0.1f);
        XCTAssertEqualWithAccuracy([array averageOfProperty:@"doubleCol"].doubleValue, 1.0, 0.1f);
        RLMAssertThrowsWithReasonMatching([array averageOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array averageOfProperty:@"boolCol"], @"average.*bool");
        RLMAssertThrowsWithReasonMatching([array averageOfProperty:@"dateCol"], @"average.*date");

        // MIN
        XCTAssertEqual(0, [[array minOfProperty:@"intCol"] intValue]);
        XCTAssertEqual(0.0f, [[array minOfProperty:@"floatCol"] floatValue]);
        XCTAssertEqual(0.0, [[array minOfProperty:@"doubleCol"] doubleValue]);
        XCTAssertEqualObjects(dateMinInput, [array minOfProperty:@"dateCol"]);
        RLMAssertThrowsWithReasonMatching([array minOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array minOfProperty:@"boolCol"], @"min.*bool");

        // MAX
        XCTAssertEqual(1, [[array maxOfProperty:@"intCol"] intValue]);
        XCTAssertEqual(1.2f, [[array maxOfProperty:@"floatCol"] floatValue]);
        XCTAssertEqual(2.5, [[array maxOfProperty:@"doubleCol"] doubleValue]);
        XCTAssertEqualObjects(dateMaxInput, [array maxOfProperty:@"dateCol"]);
        RLMAssertThrowsWithReasonMatching([array maxOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array maxOfProperty:@"boolCol"], @"max.*bool");
    };

    test();
    [realm transactionWithBlock:^{ [realm addObject:obj]; }];
    test();
}

- (void)testValueForCollectionOperationKeyPath
{
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    EmployeeObject *e1 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"A", @"age": @20, @"hired": @YES}];
    EmployeeObject *e2 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"B", @"age": @30, @"hired": @NO}];
    EmployeeObject *e3 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"C", @"age": @40, @"hired": @YES}];
    EmployeeObject *e4 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"D", @"age": @50, @"hired": @YES}];
    PrimaryCompanyObject *c1 = [PrimaryCompanyObject createInRealm:realm withValue:@{@"name": @"ABC AG", @"employees": @[e1, e2, e3, e2]}];
    PrimaryCompanyObject *c2 = [PrimaryCompanyObject createInRealm:realm withValue:@{@"name": @"ABC AG 2", @"employees": @[e1, e4]}];

    ArrayOfPrimaryCompanies *companies = [ArrayOfPrimaryCompanies createInRealm:realm withValue:@[@[c1, c2]]];
    [realm commitWriteTransaction];

    // count operator
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@count"] integerValue], 4);

    // numeric operators
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@min.age"] intValue], 20);
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@max.age"] intValue], 40);
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@sum.age"] integerValue], 120);
    XCTAssertEqualWithAccuracy([[c1.employees valueForKeyPath:@"@avg.age"] doubleValue], 30, 0.1f);

    // collection
    XCTAssertEqualObjects([c1.employees valueForKeyPath:@"@unionOfObjects.name"],
                          (@[@"A", @"B", @"C", @"B"]));
    XCTAssertEqualObjects([[c1.employees valueForKeyPath:@"@distinctUnionOfObjects.name"] sortedArrayUsingSelector:@selector(compare:)],
                          (@[@"A", @"B", @"C"]));
    XCTAssertEqualObjects([companies.companies valueForKeyPath:@"@unionOfArrays.employees"],
                          (@[e1, e2, e3, e2, e1, e4]));
    NSComparator cmp = ^NSComparisonResult(id obj1, id obj2) { return [[obj1 name] compare:[obj2 name]]; };
    XCTAssertEqualObjects([[companies.companies valueForKeyPath:@"@distinctUnionOfArrays.employees"] sortedArrayUsingComparator:cmp],
                          (@[e1, e2, e3, e4]));

    // invalid key paths
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@invalid.name"],
                                      @"Unsupported KVC collection operator found in key path '@invalid.name'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum"],
                                      @"Missing key path for KVC collection operator sum in key path '@sum'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum."],
                                      @"Missing key path for KVC collection operator sum in key path '@sum.'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum.employees.@sum.age"],
                                      @"Nested key paths.*not supported");
}

- (void)testCrossThreadAccess
{
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";

    EmployeeObject *eo = [[EmployeeObject alloc] init];
    eo.name = @"Joe";
    eo.age = 40;
    eo.hired = YES;
    [company.employees addObject:eo];
    RLMArray *employees = company.employees;

    // Unmanaged object can be accessed from other threads
    [self dispatchAsyncAndWait:^{
        XCTAssertNoThrow(company.employees);
        XCTAssertNoThrow([employees lastObject]);
    }];

    [RLMRealm.defaultRealm beginWriteTransaction];
    [RLMRealm.defaultRealm addObject:company];
    [RLMRealm.defaultRealm commitWriteTransaction];

    employees = company.employees;
    XCTAssertNoThrow(company.employees);
    XCTAssertNoThrow([employees lastObject]);
    [self dispatchAsyncAndWait:^{
        XCTAssertThrows(company.employees);
        XCTAssertThrows([employees lastObject]);
    }];
}

- (void)testSortByNoColumns {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    DogObject *a2 = [DogObject createInDefaultRealmWithValue:@[@"a", @2]];
    DogObject *b1 = [DogObject createInDefaultRealmWithValue:@[@"b", @1]];
    DogObject *a1 = [DogObject createInDefaultRealmWithValue:@[@"a", @1]];
    DogObject *b2 = [DogObject createInDefaultRealmWithValue:@[@"b", @2]];

    RLMArray<DogObject *> *array = [DogArrayObject createInDefaultRealmWithValue:@[@[a2, b1, a1, b2]]].dogs;
    [realm commitWriteTransaction];

    RLMResults *notActuallySorted = [array sortedResultsUsingDescriptors:@[]];
    XCTAssertTrue([array[0] isEqualToObject:notActuallySorted[0]]);
    XCTAssertTrue([array[1] isEqualToObject:notActuallySorted[1]]);
    XCTAssertTrue([array[2] isEqualToObject:notActuallySorted[2]]);
    XCTAssertTrue([array[3] isEqualToObject:notActuallySorted[3]]);
}

- (void)testSortByMultipleColumns {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    DogObject *a1 = [DogObject createInDefaultRealmWithValue:@[@"a", @1]];
    DogObject *a2 = [DogObject createInDefaultRealmWithValue:@[@"a", @2]];
    DogObject *b1 = [DogObject createInDefaultRealmWithValue:@[@"b", @1]];
    DogObject *b2 = [DogObject createInDefaultRealmWithValue:@[@"b", @2]];

    DogArrayObject *array = [DogArrayObject createInDefaultRealmWithValue:@[@[a1, a2, b1, b2]]];
    [realm commitWriteTransaction];

    bool (^checkOrder)(NSArray *, NSArray *, NSArray *) = ^bool(NSArray *properties, NSArray *ascending, NSArray *dogs) {
        NSArray *sort = @[[RLMSortDescriptor sortDescriptorWithKeyPath:properties[0] ascending:[ascending[0] boolValue]],
                          [RLMSortDescriptor sortDescriptorWithKeyPath:properties[1] ascending:[ascending[1] boolValue]]];
        RLMResults *actual = [array.dogs sortedResultsUsingDescriptors:sort];

        return [actual[0] isEqualToObject:dogs[0]]
            && [actual[1] isEqualToObject:dogs[1]]
            && [actual[2] isEqualToObject:dogs[2]]
            && [actual[3] isEqualToObject:dogs[3]];
    };

    // Check each valid sort
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@YES, @YES], @[a1, a2, b1, b2]));
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@YES, @NO], @[a2, a1, b2, b1]));
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@NO, @YES], @[b1, b2, a1, a2]));
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@NO, @NO], @[b2, b1, a2, a1]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@YES, @YES], @[a1, b1, a2, b2]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@YES, @NO], @[b1, a1, b2, a2]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@NO, @YES], @[a2, b2, a1, b1]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@NO, @NO], @[b2, a2, b1, a1]));
}

- (void)testDeleteLinksAndObjectsInArray
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    EmployeeObject *po1 = [EmployeeObject createInRealm:realm withValue:@[@"Joe", @40, @YES]];
    EmployeeObject *po2 = [EmployeeObject createInRealm:realm withValue:@[@"John", @30, @NO]];
    EmployeeObject *po3 = [EmployeeObject createInRealm:realm withValue:@[@"Jill", @25, @YES]];

    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [company.employees addObjects:[EmployeeObject allObjects]];
    [realm addObject:company];

    [realm commitWriteTransaction];

    RLMArray *peopleInCompany = company.employees;

    // Delete link to employee
    XCTAssertThrowsSpecificNamed([peopleInCompany removeObjectAtIndex:1], NSException, @"RLMException", @"Not allowed in read transaction");
    XCTAssertEqual(peopleInCompany.count, 3U, @"No links should have been deleted");

    [realm beginWriteTransaction];
    XCTAssertThrowsSpecificNamed([peopleInCompany removeObjectAtIndex:3], NSException, @"RLMException", @"Out of bounds");
    XCTAssertNoThrow([peopleInCompany removeObjectAtIndex:1], @"Should delete link to employee");
    [realm commitWriteTransaction];

    XCTAssertEqual(peopleInCompany.count, 2U, @"link deleted when accessing via links");
    EmployeeObject *test = peopleInCompany[0];
    XCTAssertEqual(test.age, po1.age, @"Should be equal");
    XCTAssertEqualObjects(test.name, po1.name, @"Should be equal");
    XCTAssertEqual(test.hired, po1.hired, @"Should be equal");
    XCTAssertTrue([test isEqualToObject:po1], @"Should be equal");

    test = peopleInCompany[1];
    XCTAssertEqual(test.age, po3.age, @"Should be equal");
    XCTAssertEqualObjects(test.name, po3.name, @"Should be equal");
    XCTAssertEqual(test.hired, po3.hired, @"Should be equal");
    XCTAssertTrue([test isEqualToObject:po3], @"Should be equal");

    XCTAssertThrowsSpecificNamed([peopleInCompany removeLastObject], NSException, @"RLMException", @"Not allowed in read transaction");
    XCTAssertThrowsSpecificNamed([peopleInCompany removeAllObjects], NSException, @"RLMException", @"Not allowed in read transaction");
    XCTAssertThrowsSpecificNamed([peopleInCompany replaceObjectAtIndex:0 withObject:po2], NSException, @"RLMException", @"Not allowed in read transaction");
    XCTAssertThrowsSpecificNamed([peopleInCompany insertObject:po2 atIndex:0], NSException, @"RLMException", @"Not allowed in read transaction");

    [realm beginWriteTransaction];
    XCTAssertNoThrow([peopleInCompany removeLastObject], @"Should delete last link");
    XCTAssertEqual(peopleInCompany.count, 1U, @"1 remaining link");
    [peopleInCompany replaceObjectAtIndex:0 withObject:po2];
    XCTAssertEqual(peopleInCompany.count, 1U, @"1 link replaced");
    [peopleInCompany insertObject:po1 atIndex:0];
    XCTAssertEqual(peopleInCompany.count, 2U, @"2 links");
    XCTAssertNoThrow([peopleInCompany removeAllObjects], @"Should delete all links");
    XCTAssertEqual(peopleInCompany.count, 0U, @"0 remaining links");
    [realm commitWriteTransaction];

    RLMResults *allPeople = [EmployeeObject allObjects];
    XCTAssertEqual(allPeople.count, 3U, @"Only links should have been deleted, not the employees");
}

- (void)testArrayDescription {
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    RLMArray<EmployeeObject *> *employees = [CompanyObject createInDefaultRealmWithValue:@[@"company"]].employees;
    RLMArray<NSNumber *> *ints = [AllPrimitiveArrays createInDefaultRealmWithValue:@[]].intObj;
    for (NSInteger i = 0; i < 1012; ++i) {
        EmployeeObject *person = [[EmployeeObject alloc] init];
        person.name = @"Mary";
        person.age = 24;
        person.hired = YES;
        [employees addObject:person];
        [ints addObject:@(i + 100)];
    }
    [realm commitWriteTransaction];

    RLMAssertMatches(employees.description,
                     @"(?s)RLMArray\\<EmployeeObject\\> \\<0x[a-z0-9]+\\> \\(\n"
                     @"\t\\[0\\] EmployeeObject \\{\n"
                     @"\t\tname = Mary;\n"
                     @"\t\tage = 24;\n"
                     @"\t\thired = 1;\n"
                     @"\t\\},\n"
                     @".*\n"
                     @"\t... 912 objects skipped.\n"
                     @"\\)");
    RLMAssertMatches(ints.description,
                     @"(?s)RLMArray\\<int\\> \\<0x[a-z0-9]+\\> \\(\n"
                     @"\t\\[0\\] 100,\n"
                     @"\t\\[1\\] 101,\n"
                     @"\t\\[2\\] 102,\n"
                     @".*\n"
                     @"\t... 912 objects skipped.\n"
                     @"\\)");
}

- (void)testUnmanagedAssignment {
    IntObject *io1 = [[IntObject alloc] init];
    IntObject *io2 = [[IntObject alloc] init];
    IntObject *io3 = [[IntObject alloc] init];

    ArrayPropertyObject *array1 = [[ArrayPropertyObject alloc] init];
    ArrayPropertyObject *array2 = [[ArrayPropertyObject alloc] init];

    // Assigning NSArray shallow copies
    array1.intArray = (id)@[io1, io2];
    XCTAssertEqualObjects([array1.intArray valueForKey:@"self"], (@[io1, io2]));

    [array1 setValue:@[io3, io1] forKey:@"intArray"];
    XCTAssertEqualObjects([array1.intArray valueForKey:@"self"], (@[io3, io1]));

    array1[@"intArray"] = @[io2, io3];
    XCTAssertEqualObjects([array1.intArray valueForKey:@"self"], (@[io2, io3]));

    // Assigning RLMArray shallow copies
    array2.intArray = array1.intArray;
    XCTAssertEqualObjects([array2.intArray valueForKey:@"self"], (@[io2, io3]));

    [array1.intArray removeAllObjects];
    XCTAssertEqualObjects([array2.intArray valueForKey:@"self"], (@[io2, io3]));

    // Self-assignment is a no-op
    array2.intArray = array2.intArray;
    XCTAssertEqualObjects([array2.intArray valueForKey:@"self"], (@[io2, io3]));
}

- (void)testManagedAssignment {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];

    IntObject *io1 = [IntObject createInRealm:realm withValue:@[@1]];
    IntObject *io2 = [IntObject createInRealm:realm withValue:@[@2]];
    IntObject *io3 = [IntObject createInRealm:realm withValue:@[@3]];

    ArrayPropertyObject *array1 = [ArrayPropertyObject createInRealm:realm withValue:@[@""]];
    ArrayPropertyObject *array2 = [ArrayPropertyObject createInRealm:realm withValue:@[@""]];

    // Assigning NSArray shallow copies
    array1.intArray = (id)@[io1, io2];
    XCTAssertEqualObjects([array1.intArray valueForKey:@"intCol"], (@[@1, @2]));

    [array1 setValue:@[io3, io1] forKey:@"intArray"];
    XCTAssertEqualObjects([array1.intArray valueForKey:@"intCol"], (@[@3, @1]));

    array1[@"intArray"] = @[io2, io3];
    XCTAssertEqualObjects([array1.intArray valueForKey:@"intCol"], (@[@2, @3]));

    // Assigning RLMArray shallow copies
    array2.intArray = array1.intArray;
    XCTAssertEqualObjects([array2.intArray valueForKey:@"intCol"], (@[@2, @3]));

    [array1.intArray removeAllObjects];
    XCTAssertEqualObjects([array2.intArray valueForKey:@"intCol"], (@[@2, @3]));

    // Self-assignment is a no-op
    array2.intArray = array2.intArray;
    XCTAssertEqualObjects([array2.intArray valueForKey:@"intCol"], (@[@2, @3]));

    [realm cancelWriteTransaction];
}

- (void)testAssignIncorrectType {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm
                                                          withValue:@[@"", @[@[@"a"]], @[@[@0]]]];
    RLMAssertThrowsWithReason(array.intArray = (id)array.array,
                              @"Object of type (StringObject) does not match List type");
    RLMAssertThrowsWithReason(array[@"intArray"] = array[@"array"],
                              @"Invalid property value");
    [realm cancelWriteTransaction];
}

- (void)testNotificationSentInitially {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(change);
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:2.0 handler:nil];
    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationSentAfterCommit {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    __block bool first = true;
    __block id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssert(first ? !change : !!change);
        XCTAssertNil(error);
        first = false;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    expectation = [self expectationWithDescription:@""];
    [self dispatchAsyncAndWait:^{
        RLMRealm *realm = self.realmWithTestPath;
        [realm transactionWithBlock:^{
            RLMArray *array = [(ArrayPropertyObject *)[ArrayPropertyObject allObjectsInRealm:realm].firstObject array];
            [array addObject:[[StringObject alloc] init]];
        }];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationNotSentForUnrelatedChange {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(__unused RLMArray *array, __unused RLMCollectionChange *change, __unused NSError *error) {
        // will throw if it's incorrectly called a second time due to the
        // unrelated write transaction
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    // All notification blocks are called as part of a single runloop event, so
    // waiting for this one also waits for the above one to get a chance to run
    [self waitForNotification:RLMRealmDidChangeNotification realm:realm block:^{
        [self dispatchAsyncAndWait:^{
            RLMRealm *realm = self.realmWithTestPath;
            [realm transactionWithBlock:^{
                [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
            }];
        }];
    }];
    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationSentOnlyForActualRefresh {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    __block id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, __unused RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        // will throw if it's called a second time before we create the new
        // expectation object immediately before manually refreshing
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    // Turn off autorefresh, so the background commit should not result in a notification
    realm.autorefresh = NO;

    // All notification blocks are called as part of a single runloop event, so
    // waiting for this one also waits for the above one to get a chance to run
    [self waitForNotification:RLMRealmRefreshRequiredNotification realm:realm block:^{
        [self dispatchAsyncAndWait:^{
            RLMRealm *realm = self.realmWithTestPath;
            [realm transactionWithBlock:^{
                RLMArray *array = [(ArrayPropertyObject *)[ArrayPropertyObject allObjectsInRealm:realm].firstObject array];
                [array addObject:[[StringObject alloc] init]];
            }];
        }];
    }];

    expectation = [self expectationWithDescription:@""];
    [realm refresh];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

- (void)testDeletingObjectWithNotificationsRegistered {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    __block id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, __unused RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [realm beginWriteTransaction];
    [realm deleteObject:array];
    [realm commitWriteTransaction];

    [(RLMNotificationToken *)token stop];
}

- (void)testAllMethodsCheckThread {
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block IntObject *io;
    __block RLMArray *array;
    [realm transactionWithBlock:^{
        io = [IntObject createInDefaultRealmWithValue:@[@0]];
        ArrayPropertyObject *obj = [ArrayPropertyObject createInDefaultRealmWithValue:@[@"", @[], @[io]]];
        array = obj.intArray;
    }];
    [realm beginWriteTransaction];

    [self dispatchAsyncAndWait:^{
        RLMAssertThrowsWithReasonMatching([array count], @"thread");
        RLMAssertThrowsWithReasonMatching([array objectAtIndex:0], @"thread");
        RLMAssertThrowsWithReasonMatching([array firstObject], @"thread");
        RLMAssertThrowsWithReasonMatching([array lastObject], @"thread");

        RLMAssertThrowsWithReasonMatching([array addObject:io], @"thread");
        RLMAssertThrowsWithReasonMatching([array addObjects:@[io]], @"thread");
        RLMAssertThrowsWithReasonMatching([array insertObject:io atIndex:0], @"thread");
        RLMAssertThrowsWithReasonMatching([array removeObjectAtIndex:0], @"thread");
        RLMAssertThrowsWithReasonMatching([array removeLastObject], @"thread");
        RLMAssertThrowsWithReasonMatching([array removeAllObjects], @"thread");
        RLMAssertThrowsWithReasonMatching([array replaceObjectAtIndex:0 withObject:io], @"thread");
        RLMAssertThrowsWithReasonMatching([array moveObjectAtIndex:0 toIndex:1], @"thread");
        RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"thread");

        RLMAssertThrowsWithReasonMatching([array indexOfObject:[IntObject allObjects].firstObject], @"thread");
        RLMAssertThrowsWithReasonMatching([array indexOfObjectWhere:@"intCol = 0"], @"thread");
        RLMAssertThrowsWithReasonMatching([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"thread");
        RLMAssertThrowsWithReasonMatching([array objectsWhere:@"intCol = 0"], @"thread");
        RLMAssertThrowsWithReasonMatching([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"thread");
        RLMAssertThrowsWithReasonMatching([array sortedResultsUsingKeyPath:@"intCol" ascending:YES], @"thread");
        RLMAssertThrowsWithReasonMatching([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]], @"thread");
        RLMAssertThrowsWithReasonMatching(array[0], @"thread");
        RLMAssertThrowsWithReasonMatching(array[0] = io, @"thread");
        RLMAssertThrowsWithReasonMatching([array valueForKey:@"intCol"], @"thread");
        RLMAssertThrowsWithReasonMatching([array setValue:@1 forKey:@"intCol"], @"thread");
        RLMAssertThrowsWithReasonMatching({for (__unused id obj in array);}, @"thread");
    }];
    [realm cancelWriteTransaction];
}

- (void)testAllMethodsCheckForInvalidation {
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block IntObject *io;
    __block RLMArray *array;
    [realm transactionWithBlock:^{
        io = [IntObject createInDefaultRealmWithValue:@[@0]];
        ArrayPropertyObject *obj = [ArrayPropertyObject createInDefaultRealmWithValue:@[@"", @[], @[io]]];
        array = obj.intArray;
    }];

    [realm beginWriteTransaction];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    XCTAssertNoThrow([array count]);
    XCTAssertNoThrow([array objectAtIndex:0]);
    XCTAssertNoThrow([array firstObject]);
    XCTAssertNoThrow([array lastObject]);

    XCTAssertNoThrow([array addObject:io]);
    XCTAssertNoThrow([array addObjects:@[io]]);
    XCTAssertNoThrow([array insertObject:io atIndex:0]);
    XCTAssertNoThrow([array removeObjectAtIndex:0]);
    XCTAssertNoThrow([array removeLastObject]);
    XCTAssertNoThrow([array removeAllObjects]);
    [array addObjects:@[io, io, io]];
    XCTAssertNoThrow([array replaceObjectAtIndex:0 withObject:io]);
    XCTAssertNoThrow([array moveObjectAtIndex:0 toIndex:1]);
    XCTAssertNoThrow([array exchangeObjectAtIndex:0 withObjectAtIndex:1]);

    XCTAssertNoThrow([array indexOfObject:[IntObject allObjects].firstObject]);
    XCTAssertNoThrow([array indexOfObjectWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array objectsWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array sortedResultsUsingKeyPath:@"intCol" ascending:YES]);
    XCTAssertNoThrow([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]]);
    XCTAssertNoThrow(array[0]);
    XCTAssertNoThrow(array[0] = io);
    XCTAssertNoThrow([array valueForKey:@"intCol"]);
    XCTAssertNoThrow([array setValue:@1 forKey:@"intCol"]);
    XCTAssertNoThrow({for (__unused id obj in array);});

    [realm cancelWriteTransaction];
    [realm invalidate];
    [realm beginWriteTransaction];
    io = [IntObject createInDefaultRealmWithValue:@[@0]];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    RLMAssertThrowsWithReasonMatching([array count], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array objectAtIndex:0], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array firstObject], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array lastObject], @"invalidated");

    RLMAssertThrowsWithReasonMatching([array addObject:io], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array addObjects:@[io]], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array insertObject:io atIndex:0], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array removeObjectAtIndex:0], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array removeLastObject], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array removeAllObjects], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array replaceObjectAtIndex:0 withObject:io], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array moveObjectAtIndex:0 toIndex:1], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"invalidated");

    RLMAssertThrowsWithReasonMatching([array indexOfObject:[IntObject allObjects].firstObject], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array indexOfObjectWhere:@"intCol = 0"], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array objectsWhere:@"intCol = 0"], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array sortedResultsUsingKeyPath:@"intCol" ascending:YES], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]], @"invalidated");
    RLMAssertThrowsWithReasonMatching(array[0], @"invalidated");
    RLMAssertThrowsWithReasonMatching(array[0] = io, @"invalidated");
    RLMAssertThrowsWithReasonMatching([array valueForKey:@"intCol"], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array setValue:@1 forKey:@"intCol"], @"invalidated");
    RLMAssertThrowsWithReasonMatching({for (__unused id obj in array);}, @"invalidated");

    [realm cancelWriteTransaction];
}

- (void)testMutatingMethodsCheckForWriteTransaction {
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block IntObject *io;
    __block RLMArray *array;
    [realm transactionWithBlock:^{
        io = [IntObject createInDefaultRealmWithValue:@[@0]];
        ArrayPropertyObject *obj = [ArrayPropertyObject createInDefaultRealmWithValue:@[@"", @[], @[io]]];
        array = obj.intArray;
    }];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    XCTAssertNoThrow([array count]);
    XCTAssertNoThrow([array objectAtIndex:0]);
    XCTAssertNoThrow([array firstObject]);
    XCTAssertNoThrow([array lastObject]);

    XCTAssertNoThrow([array indexOfObject:[IntObject allObjects].firstObject]);
    XCTAssertNoThrow([array indexOfObjectWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array objectsWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array sortedResultsUsingKeyPath:@"intCol" ascending:YES]);
    XCTAssertNoThrow([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]]);
    XCTAssertNoThrow(array[0]);
    XCTAssertNoThrow([array valueForKey:@"intCol"]);
    XCTAssertNoThrow({for (__unused id obj in array);});


    RLMAssertThrowsWithReasonMatching([array addObject:io], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array addObjects:@[io]], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array insertObject:io atIndex:0], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array removeObjectAtIndex:0], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array removeLastObject], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array removeAllObjects], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array replaceObjectAtIndex:0 withObject:io], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array moveObjectAtIndex:0 toIndex:1], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"write transaction");

    RLMAssertThrowsWithReasonMatching(array[0] = io, @"write transaction");
    RLMAssertThrowsWithReasonMatching([array setValue:@1 forKey:@"intCol"], @"write transaction");
}
#endif
@end
