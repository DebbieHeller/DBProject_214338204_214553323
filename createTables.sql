CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR2(40),
    LastName VARCHAR2(40),
    Phone VARCHAR2(20),
    Email VARCHAR2(80),
    RegistrationDate DATE
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR2(40),
    LastName VARCHAR2(40),
    Role VARCHAR2(40),
    HireDate DATE
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR2(80)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR2(80),
    CategoryID INT,
    Price NUMERIC(10,2),
    IsAvailable VARCHAR2(1),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    Status VARCHAR2(30),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE OrderItems (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice NUMERIC(10,2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
