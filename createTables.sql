-- 1. טבלת תפקידים
CREATE TABLE Roles (
    RoleID SERIAL PRIMARY KEY,
    RoleName VARCHAR(100),
    BasicSalary NUMERIC(10,2)
);

-- 2. טבלת עובדים מאוחדת
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    FullName VARCHAR(100),
    Phone VARCHAR(50),
    HireDate DATE,
    BirthDate DATE,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- 3. טבלת סניפים
CREATE TABLE Branches (
    BranchID SERIAL PRIMARY KEY,
    BranchName VARCHAR(255),
    Address VARCHAR(255),
    Phone VARCHAR(50),
    ManagerID INT,
    FoundedDate DATE,
    AvgCustomersPerMonth INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- 4. קטגוריות מוצרים
CREATE TABLE ProductCategories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(80)
);

-- 5. מוצרים
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(80),
    CategoryID INT,
    Price NUMERIC(10,2),
    IsAvailable BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategories(CategoryID)
);

-- 6. לקוחות
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(40),
    LastName VARCHAR(40),
    Phone VARCHAR(20),
    Email VARCHAR(80),
    RegistrationDate DATE
);

-- 7. הזמנות (מחוברות לסניף ולעובד)
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    BranchID INT, -- הקישור לסניף
    OrderDate DATE,
    Status VARCHAR(30),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- 8. פריטי הזמנה
CREATE TABLE OrderItems (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice NUMERIC(10,2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 9. ניהול משמרות ולו"ז (מהמסד השני)
CREATE TABLE BranchSchedules (
    ScheduleID SERIAL PRIMARY KEY,
    BranchID INT,
    DayInWeek VARCHAR(20),
    OpenAt TIME,
    CloseAt TIME,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

CREATE TABLE EmployeeShifts (
    ShiftID SERIAL PRIMARY KEY,
    EmployeeID INT,
    BranchID INT,
    ShiftDate DATE,
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

