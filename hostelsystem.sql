create database lab
CREATE TABLE Hostel (
    HostelID varchar(10) PRIMARY KEY,
    HostelName VARCHAR(100) NOT NULL,
    HostelLocation VARCHAR(255) NOT NULL,
    TotalRooms INT NOT NULL,
);
Create Table Visitor (
	NIC varchar(20) Primary key,
	Name varchar(100),
	ContactInfo varchar(255),
	Relation varchar(100),
	StudentID varchar(10),
	VisitingDate dateTime,
	Foreign key (StudentID) references Student(StudentID)
);
CREATE PROCEDURE VisitorInsert(
    @NIC varchar(10),
    @Name varchar(100),
    @ContactInfo varchar(255),
    @Relation varchar(100),
    @StudentID varchar(10),
	@VisitingDate dateTIME
)
AS
BEGIN
    INSERT INTO Visitor (NIC, Name, ContactInfo, Relation, StudentID,VisitingDate)
    VALUES (@NIC, @Name, @ContactInfo, @Relation, @StudentID,@VisitingDate);
END;
Create Procedure HostelInsert(@HostelID varchar(10), @HName varchar(100) , @HLocation varchar(255) , @TotalRooms int)
As Begin
insert into Hostel(HostelID, HostelName, HostelLocation ,TotalRooms)
values (@HostelID,@HName,@HLocation,@TotalRooms)
End
Exec HostelInsert 'H001', 'Bhatti Hostel' , 'Defence Road', 50;
Exec HostelInsert 'H002', 'Bhatti Hostel 2' , 'Bhoobtian Chowk', 60;
Exec HostelInsert 'H003', 'Bhatti Hostel 3' , 'LDA road', 55;
Exec HostelInsert 'H004', 'Bhatti Hostel 4' , 'Multan Road', 40;
Exec HostelInsert 'H005', 'Bhatti Hostel 5' , 'Raiwand Road', 25;
CREATE TABLE WorkSchedule (
    ScheduleID INT IDENTITY(1,1) PRIMARY KEY,
    StaffID VARCHAR(10),
    Date DATE,
    StartTime TIME,
    EndTime TIME,
    Status VARCHAR(50),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    RoomID VARCHAR(10) NOT NULL,
    Description VARCHAR(255),
    Date DATETIME,
	cost int,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);
drop procedure InsertMaintenance
select *from Maintenance

CREATE PROCEDURE InsertMaintenance
    @RoomID VARCHAR(20),
    @Description VARCHAR(255),
    @Date DATETIME,
	@cost int
AS
BEGIN
    INSERT INTO Maintenance (RoomID, Description, Date, cost)
    VALUES (@RoomID, @Description, @Date, @cost);
END;
CREATE PROCEDURE WorkScheduleInsert
    @StaffID VARCHAR(10),
    @Date DATE,
    @StartTime TIME,
    @EndTime TIME,
    @Status VARCHAR(50)
AS
BEGIN
    INSERT INTO WorkSchedule (StaffID, Date, StartTime, EndTime, Status)
    VALUES (@StaffID, @Date, @StartTime, @EndTime, @Status);
END;
Create table Staff(
	StaffID  varchar(10) Primary Key,
	HostelID varchar(10),
	Name VARCHAR (100) NOT NUll,
	Role VARCHAR(100),
	HireDate date,
	ContactInfo Varchar(255),
	Salary INT,
	Foreign key (HostelID) references Hostel(HostelID)
	);
	Create Procedure StaffInsert (@StaffID varchar(10), @HostelID varchar(10) ,@Name varchar(100) ,@Role varchar(100) ,@HireDate date ,@ContactInfo varchar(255),@Salary int)
	AS Begin
	insert into Staff (StaffID , HostelID ,Name ,Role,HireDate ,ContactInfo,Salary)
	values (@StaffID, @HostelID,@Name,@Role ,@HireDate,@ContactInfo,@Salary)
	End

create table HostelUtilities(
HostelID varchar(10),
Type varchar(25),
Amount INT,
Month varchar(13),
Paymentdate DATE,
FOREIGN KEY (HostelID) REFERENCES Hostel(HostelID)
);
delete from HostelUtilities
select * from HostelUtilities
CREATE PROCEDURE HostelUtilitiesInsert
    @HostelID VARCHAR(10),
    @Type VARCHAR(25),
    @Amount INT,
    @Month VARCHAR(13),
    @Paymentdate DATE
AS
BEGIN
    INSERT INTO HostelUtilities (HostelID, Type, Amount, Month, Paymentdate)
    VALUES (@HostelID, @Type, @Amount, @Month, @Paymentdate);
END;
Create table Attendence(
	AttendenceID varchar(10),
	StudentID varchar(10),
	Date date,
	Status varchar(50),
	Description varchar(100),
	PRIMARY KEY (AttendenceID, Date),
	Foreign key (StudentID) references Student(StudentID)
);
select * from Attendence
CREATE PROCEDURE AttendenceInsert(
    @AttendenceID varchar(10),
    @StudentID varchar(10),
    @Date date,
    @Status varchar(50),
	@Description varchar(100)
)
AS
BEGIN
    INSERT INTO Attendence (AttendenceID, StudentID, Date, Status,Description)
    VALUES (@AttendenceID, @StudentID, @Date, @Status,@Description);
END;
Create Table Room(
	RoomID varchar(10) primary Key,
	HostelID varchar(10),
	RoomType Varchar(50),
	OccupancyStatus varchar(50),
	AvailableSpace INT,
	Rent int,
	Foreign Key (HostelID) References Hostel(HostelID));




CREATE PROCEDURE RoomInsert
    @RoomID varchar(10),
    @HostelID varchar(10),
    @RoomType varchar(50),
    @OccupancyStatus varchar(50),
    @Rent int
AS
BEGIN
    DECLARE @AvailableSpace INT;

    -- Determine available space based on room type
    IF @RoomType = 'single'
        SET @AvailableSpace = 1;
    ELSE IF @RoomType = 'double'
        SET @AvailableSpace = 2;
    ELSE IF @RoomType = 'triple'
        SET @AvailableSpace = 3;

    INSERT INTO Room(RoomID, HostelID, RoomType, OccupancyStatus, Rent, AvailableSpace)
    VALUES (@RoomID, @HostelID, @RoomType, @OccupancyStatus, @Rent, @AvailableSpace);
END;
select * from Room
Create table Mess(
	MessID varchar(10) Primary key,
	MessType varchar(100),
	Description varchar(255),
	Cost int,	

);

CREATE PROCEDURE MessInsert(
    @MessID varchar(10),
    @MessType varchar(100),
	@Description varchar(255),
	@Cost int

)
AS
BEGIN
    INSERT INTO Mess(MessID , MessType , Description ,Cost)
    VALUES (@MessID, @MessType, @Description, @Cost);
END;
exec MessInsert 'M001', 'Basic','Standard mess service',7000
exec MessInsert 'M002', 'Premium','Premium mess service',10000
select * from Staff
UPDATE Staff
SET Salary = Salary * 0.90;

Create Table Student(
	StudentID varchar(10) Primary Key,
	CNIC varchar(20),
	Name Varchar(100) not null,
	Age int,
	Semester int,
	RoomID varchar(10),
	MessID varchar(10),
	Phone varchar(50),
	Email varchar(50),
	City varchar(20),
	Joining Date,
	Foreign Key (RoomID) references Room(RoomID),
	Foreign Key (MessID) references Mess(MessID)
);
CREATE TABLE Complaint (
    ComplaintID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID VARCHAR(10) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    ComplaintDate DATETIME NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Resolved')),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);
select *from Complaint
CREATE PROCEDURE InsertComplaint
    @StudentID VARCHAR(10),
    @Description VARCHAR(255),
    @ComplaintDate DATETIME,
    @Status VARCHAR(20)
AS
BEGIN
    INSERT INTO Complaint (StudentID, Description, ComplaintDate, Status)
    VALUES (@StudentID, @Description, @ComplaintDate, @Status);
END;
select * from Room where RoomID='H001-R027'
delete from WorkSchedule
CREATE TRIGGER trg_UpdateRoomOnStudentInsert
ON Student
AFTER INSERT
AS
BEGIN
    DECLARE @RoomID varchar(10), @RoomType varchar(50), @StudentCount INT;

    -- Get the RoomID and RoomType from the inserted student
    SELECT @RoomID = i.RoomID, @RoomType = r.RoomType
    FROM inserted i
    JOIN Room r ON i.RoomID = r.RoomID;

    -- Count the number of students in the room
    SELECT @StudentCount = COUNT(*) FROM Student WHERE RoomID = @RoomID;

    -- Update kand OccupancyStatus based on RoomType
    UPDATE Room
    SET AvailableSpace = 
        CASE 
            WHEN @RoomType = 'single' THEN 1 - @StudentCount
            WHEN @RoomType = 'double' THEN 2 - @StudentCount
            WHEN @RoomType = 'triple' THEN 3 - @StudentCount
        END,
        OccupancyStatus = CASE 
            WHEN @StudentCount = 0 THEN 'Non-Occupied'
            ELSE 'Occupied'
        END
    WHERE RoomID = @RoomID;
END;




CREATE TRIGGER trg_UpdateRoomOnStudentDelete
ON Student
AFTER DELETE
AS
BEGIN
    -- Declare a cursor to iterate through the deleted rows
    DECLARE @RoomID varchar(10);

    DECLARE deleted_cursor CURSOR FOR
    SELECT RoomID
    FROM deleted;

    OPEN deleted_cursor;

    FETCH NEXT FROM deleted_cursor INTO @RoomID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Update AvailableSpace by increasing it by 1
        UPDATE Room
        SET AvailableSpace = AvailableSpace + 1,
            OccupancyStatus = CASE 
                WHEN AvailableSpace + 1 = CASE 
                                           WHEN RoomType = 'single' THEN 1
                                           WHEN RoomType = 'double' THEN 2
                                           WHEN RoomType = 'triple' THEN 3
                                          END THEN 'Non-Occupied'
                ELSE 'Occupied'
            END
        WHERE RoomID = @RoomID;

        FETCH NEXT FROM deleted_cursor INTO @RoomID;
    END;

    CLOSE deleted_cursor;
    DEALLOCATE deleted_cursor;
END;

CREATE TABLE FinancialTransaction (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    OwnerID VARCHAR(10), -- StudentID for student rent, StaffID for staff salary, etc.
    TransactionType VARCHAR(20), -- 'studentrent', 'staffsalary', 'utility', 'maintenance'
    Amount DECIMAL(10, 2),
    TransactionDate DATE,
    Month VARCHAR(20),
    TransactionNature VARCHAR(10) -- 'incoming' for rent, 'outgoing' for others
);
CREATE PROCEDURE InsertStudentRentRecord
    @StudentID VARCHAR(10),
    @TransactionDate DATE,
    @Amount DECIMAL(10, 2) = NULL -- Default to NULL if not provided
AS
BEGIN
    DECLARE @RoomID VARCHAR(10);
    DECLARE @MessID VARCHAR(10);
    DECLARE @Rent DECIMAL(10, 2);
    DECLARE @MessCost DECIMAL(10, 2);
    DECLARE @Month VARCHAR(20);

    -- Fetch RoomID and MessID based on StudentID
    SELECT @RoomID = RoomID, @MessID = MessID FROM Student WHERE StudentID = @StudentID;

    -- Check if RoomID and MessID are found
    IF @RoomID IS NULL OR @MessID IS NULL
    BEGIN
        RAISERROR ('RoomID or MessID not found for the given StudentID', 16, 1);
        RETURN;
    END

    -- Fetch room rent
    SELECT @Rent = Rent FROM Room WHERE RoomID = @RoomID;

    -- Fetch mess cost
    SELECT @MessCost = Cost FROM Mess WHERE MessID = @MessID;

    -- Calculate total amount if not provided
    IF @Amount IS NULL
    BEGIN
        SET @Amount = @Rent + @MessCost;
    END

    SET @Month = FORMAT(@TransactionDate, 'MMM yyyy');

    INSERT INTO FinancialTransaction (OwnerID, TransactionType, Amount, TransactionDate, Month, TransactionNature)
    VALUES (@StudentID, 'studentrent', @Amount, @TransactionDate, @Month, 'incoming');
END;
CREATE PROCEDURE InsertStaffSalaryRecord
    @StaffID VARCHAR(10),
    @TransactionDate DATE
AS
BEGIN
    DECLARE @Salary DECIMAL(10, 2);
    DECLARE @Month VARCHAR(20);
    DECLARE @DailySalary DECIMAL(10, 2);
    DECLARE @MonthlySalary DECIMAL(10, 2);
    DECLARE @Absences INT;
    DECLARE @FirstDayOfMonth DATE;
    DECLARE @LastDayOfMonth DATE;

    -- Fetch staff salary based on StaffID
    SELECT @Salary = Salary 
    FROM Staff 
    WHERE StaffID = @StaffID;

    -- Check if Salary is found
    IF @Salary IS NULL
    BEGIN
        RAISERROR ('Salary not found for the given StaffID', 16, 1);
        RETURN;
    END

    -- Format the month
    SET @Month = FORMAT(@TransactionDate, 'MMM yyyy');

    -- Calculate the first and last day of the transaction month
    SET @FirstDayOfMonth = DATEFROMPARTS(YEAR(@TransactionDate), MONTH(@TransactionDate), 1);
    SET @LastDayOfMonth = EOMONTH(@TransactionDate);

    -- Fetch the number of absences for the staff in the transaction month
    SELECT @Absences = COUNT(*)
    FROM WorkSchedule
    WHERE StaffID = @StaffID
      AND Date BETWEEN @FirstDayOfMonth AND @LastDayOfMonth
      AND Status = 'Absent';

    -- Calculate the daily salary
    SET @DailySalary = @Salary / 30.0;

    -- Calculate the monthly salary after deducting for absences
    SET @MonthlySalary = @Salary - (@DailySalary * @Absences);

    -- Insert the transaction
    INSERT INTO FinancialTransaction (OwnerID, TransactionType, Amount, TransactionDate, Month, TransactionNature)
    VALUES (@StaffID, 'staffsalary', @MonthlySalary, @TransactionDate, @Month, 'outgoing');
END;
CREATE TRIGGER trg_InsertMaintenanceRecord
ON Maintenance
AFTER INSERT
AS
BEGIN
    DECLARE @RoomID VARCHAR(10);
    DECLARE @Description VARCHAR(255);
    DECLARE @Amount DECIMAL(10, 2);
    DECLARE @TransactionDate DATE;
    DECLARE @Month VARCHAR(20);
    DECLARE @MaintenanceID INT;

    -- Use a cursor to iterate through the inserted rows
    DECLARE ins_cursor CURSOR FOR
    SELECT MaintenanceID, RoomID, Description, Cost, Date
    FROM inserted;

    OPEN ins_cursor;

    FETCH NEXT FROM ins_cursor INTO @MaintenanceID, @RoomID, @Description, @Amount, @TransactionDate;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Format the month
        SET @Month = FORMAT(@TransactionDate, 'MMM yyyy');

        -- Insert the transaction into FinancialTransaction
        INSERT INTO FinancialTransaction (OwnerID, TransactionType, Amount, TransactionDate, Month, TransactionNature)
        VALUES (@RoomID, 'maintenance', @Amount, @TransactionDate, @Month, 'outgoing');

        FETCH NEXT FROM ins_cursor INTO @MaintenanceID, @RoomID, @Description, @Amount, @TransactionDate;
    END;

    CLOSE ins_cursor;
    DEALLOCATE ins_cursor;
END;

CREATE TRIGGER trg_InsertUtilityRecord
ON HostelUtilities
AFTER INSERT
AS
BEGIN
    DECLARE @HostelID VARCHAR(10);
    DECLARE @Type VARCHAR(25);
    DECLARE @Amount DECIMAL(10, 2);
    DECLARE @TransactionDate DATE;
    DECLARE @Month VARCHAR(20);

    -- Use a cursor to iterate through the inserted rows
    DECLARE ins_cursor CURSOR FOR
    SELECT HostelID, Type, Amount, Paymentdate
    FROM inserted;

    OPEN ins_cursor;

    FETCH NEXT FROM ins_cursor INTO @HostelID, @Type, @Amount, @TransactionDate;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Format the month
        SET @Month = FORMAT(@TransactionDate, 'MMM yyyy');

        -- Insert the transaction into FinancialTransaction
        INSERT INTO FinancialTransaction (OwnerID, TransactionType, Amount, TransactionDate, Month, TransactionNature)
        VALUES (@HostelID, 'utility', @Amount, @TransactionDate, @Month, 'outgoing');

        FETCH NEXT FROM ins_cursor INTO @HostelID, @Type, @Amount, @TransactionDate;
    END;

    CLOSE ins_cursor;
    DEALLOCATE ins_cursor;
END;
CREATE TRIGGER trg_DeleteFinancialTransactionOnMaintenanceDelete
ON Maintenance
AFTER DELETE
AS
BEGIN
    DELETE ft
    FROM FinancialTransaction ft
    INNER JOIN deleted d ON ft.OwnerID = d.RoomID 
                         AND ft.TransactionType = 'maintenance'
                         AND ft.Amount = d.cost
                         AND ft.TransactionDate = d.Date;
END;
CREATE TRIGGER trg_DeleteFinancialTransactionOnUtilityDelete
ON HostelUtilities
AFTER DELETE
AS
BEGIN
    DELETE ft
    FROM FinancialTransaction ft
    INNER JOIN deleted d ON ft.OwnerID = d.HostelID 
                         AND ft.TransactionType = 'utility'
                         AND ft.Amount = d.Amount
                         AND ft.TransactionDate = d.Paymentdate;
END;



select * from FinancialTransaction where TransactionType='utility'


CREATE MATERIALIZED VIEW FinancialSummary AS
WITH YearlyTransactions AS (
    SELECT
        YEAR(TransactionDate) AS Year,
        SUM(CASE WHEN TransactionNature = 'incoming' THEN Amount ELSE 0 END) AS Income,
        SUM(CASE WHEN TransactionNature = 'outgoing' THEN Amount ELSE 0 END) AS Expenses
    FROM FinancialTransaction
    WHERE YEAR(TransactionDate) BETWEEN 2019 AND 2024
    GROUP BY YEAR(TransactionDate)
),
CumulativeNet AS (
    SELECT
        YEAR(TransactionDate) AS Year,
        SUM(CASE WHEN TransactionNature = 'incoming' THEN Amount ELSE -Amount END) AS NetAmount
    FROM FinancialTransaction
    WHERE YEAR(TransactionDate) BETWEEN 2019 AND 2024
    GROUP BY YEAR(TransactionDate)
),
CumulativeBalance AS (
    SELECT
        Year,
        SUM(NetAmount) OVER (ORDER BY Year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeNet
    FROM CumulativeNet
),
FinalBalance AS (
    SELECT
        yt.Year,
        COALESCE(LAG(cb.CumulativeNet, 1, 0) OVER (ORDER BY cb.Year), 0) AS OpeningBalance,
        yt.Income,
        yt.Expenses,
        yt.Income - yt.Expenses AS NetProfit,
        COALESCE(LAG(cb.CumulativeNet, 1, 0) OVER (ORDER BY cb.Year), 0) +
            (yt.Income - yt.Expenses) AS ClosingBalance
    FROM YearlyTransactions yt
    LEFT JOIN CumulativeBalance cb ON yt.Year = cb.Year
)
SELECT
    Year,
    OpeningBalance,
    Income,
    Expenses,
    NetProfit,
    ClosingBalance
FROM FinalBalance
WHERE Year BETWEEN 2019 AND 2024;

SELECT *
FROM FinancialSummary
ORDER BY Year;




/////////////////////     -------STAFF
CREATE VIEW StaffSalarySummary AS
WITH StaffAbsences AS (
    SELECT
        StaffID,
        FORMAT(Date, 'yyyy-MM') AS Month,
        COUNT(*) AS AbsenceCount
    FROM WorkSchedule
    WHERE Status = 'Absent'
    GROUP BY StaffID, FORMAT(Date, 'yyyy-MM')
),
StaffSalary AS (
    SELECT
        s.StaffID,
        s.Name,
        s.Salary AS MonthlySalary,
        ISNULL(a.AbsenceCount, 0) AS AbsenceCount,
        (s.Salary / 30.0) * ISNULL(a.AbsenceCount, 0) AS SalaryDeducted,
        s.Salary - ((s.Salary / 30.0) * ISNULL(a.AbsenceCount, 0)) AS NetSalary,
        a.Month
    FROM Staff s
    LEFT JOIN StaffAbsences a ON s.StaffID = a.StaffID
)
SELECT
    StaffID,
    Name,
    MonthlySalary,
    AbsenceCount,
    SalaryDeducted,
    NetSalary,
    Month
FROM StaffSalary;

SELECT
    StaffID,
    Name,
    MonthlySalary,
    AbsenceCount,
    SalaryDeducted,
    NetSalary,
    Month
FROM StaffSalarySummary
ORDER BY StaffID, Month;


select * from Staff









///////////////////// --  SHOWS FOR EACH MONTH CHANGE IN NETPROFIT,EXPENSE,INCOME

WITH MonthlyTransactions AS (
    SELECT
        FORMAT(TransactionDate, 'yyyy-MM') AS Month,
        SUM(CASE WHEN TransactionNature = 'incoming' THEN Amount ELSE 0 END) AS TotalIncome,
        SUM(CASE WHEN TransactionNature = 'outgoing' THEN Amount ELSE 0 END) AS TotalExpenses
    FROM FinancialTransaction
    WHERE TransactionDate BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY FORMAT(TransactionDate, 'yyyy-MM')
),
MonthlyTrends AS (
    SELECT
        Month,
        TotalIncome,
        TotalExpenses,
        TotalIncome - TotalExpenses AS NetProfit,
        LAG(TotalIncome) OVER (ORDER BY Month) AS PreviousIncome,
        LAG(TotalExpenses) OVER (ORDER BY Month) AS PreviousExpenses,
        LAG(TotalIncome - TotalExpenses) OVER (ORDER BY Month) AS PreviousNetProfit
    FROM MonthlyTransactions
)
SELECT
    Month,
    TotalIncome,
    TotalExpenses,
    NetProfit,
    CASE WHEN PreviousIncome IS NULL THEN 0 ELSE (TotalIncome - PreviousIncome) END AS IncomeChange,
    CASE WHEN PreviousExpenses IS NULL THEN 0 ELSE (TotalExpenses - PreviousExpenses) END AS ExpensesChange,
    CASE WHEN PreviousNetProfit IS NULL THEN 0 ELSE (NetProfit - PreviousNetProfit) END AS NetProfitChange
FROM MonthlyTrends
ORDER BY Month;








////////////////////////////////////////////////   ----STAFF FULL SALARY SUMMARY

WITH StaffAbsences AS (
    SELECT
        StaffID,
        FORMAT(Date, 'yyyy-MM') AS Month,
        COUNT(*) AS AbsenceCount
    FROM WorkSchedule
    WHERE Status = 'Absent' AND Date BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY StaffID, FORMAT(Date, 'yyyy-MM')
),
StaffSalary AS (
    SELECT
        s.StaffID,
        s.Name,
        s.Salary AS MonthlySalary,
        ISNULL(a.AbsenceCount, 0) AS AbsenceCount,
        (s.Salary / 30.0) * ISNULL(a.AbsenceCount, 0) AS SalaryDeducted,
        s.Salary - ((s.Salary / 30.0) * ISNULL(a.AbsenceCount, 0)) AS NetSalary
    FROM Staff s
    LEFT JOIN StaffAbsences a ON s.StaffID = a.StaffID
)
SELECT
    ss.StaffID,
    ss.Name,
    SUM(ss.MonthlySalary) AS TotalSalary,
    SUM(ss.SalaryDeducted) AS TotalSalaryDeducted,
    SUM(ss.NetSalary) AS TotalNetSalary
FROM StaffSalary ss
GROUP BY ss.StaffID, ss.Name
ORDER BY TotalNetSalary DESC;




////////////////////////////////////////       ---TOTAL UTILITY AND MAINTAINANCE COST OF EACH HOSTEL BY YEAR



WITH MaintenanceCosts AS (
    SELECT
        h.HostelID,
        YEAR(m.Date) AS Year,
        SUM(m.Cost) AS TotalMaintenanceCost
    FROM Maintenance m
    JOIN Room r ON m.RoomID = r.RoomID
    JOIN Hostel h ON r.HostelID = h.HostelID
    WHERE m.Date BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY h.HostelID, YEAR(m.Date)
),
UtilityCosts AS (
    SELECT
        hu.HostelID,
        YEAR(hu.Paymentdate) AS Year,
        SUM(hu.Amount) AS TotalUtilityCost
    FROM HostelUtilities hu
    WHERE hu.Paymentdate BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY hu.HostelID, YEAR(hu.Paymentdate)
),
CombinedCosts AS (
    SELECT
        COALESCE(mc.HostelID, uc.HostelID) AS HostelID,
        COALESCE(mc.Year, uc.Year) AS Year,
        COALESCE(mc.TotalMaintenanceCost, 0) AS TotalMaintenanceCost,
        COALESCE(uc.TotalUtilityCost, 0) AS TotalUtilityCost
    FROM MaintenanceCosts mc
    FULL OUTER JOIN UtilityCosts uc ON mc.HostelID = uc.HostelID AND mc.Year = uc.Year
)
SELECT
    cc.HostelID,
    cc.Year,
    SUM(cc.TotalMaintenanceCost) AS TotalMaintenanceCost,
    SUM(cc.TotalUtilityCost) AS TotalUtilityCost,
    SUM(cc.TotalMaintenanceCost + cc.TotalUtilityCost) AS TotalCost
FROM CombinedCosts cc
GROUP BY cc.HostelID, cc.Year
ORDER BY cc.HostelID, cc.Year;




///////////////////////    ------FINANCIAL SUMMARY BY CHANGE


WITH YearlyFinancials AS (
    SELECT
        YEAR(TransactionDate) AS Year,
        r.HostelID,
        SUM(CASE WHEN ft.TransactionNature = 'incoming' THEN ft.Amount ELSE 0 END) AS TotalIncome,
        SUM(CASE WHEN ft.TransactionNature = 'outgoing' THEN ft.Amount ELSE 0 END) AS TotalExpenses,
        SUM(CASE WHEN ft.TransactionNature = 'incoming' THEN ft.Amount ELSE -ft.Amount END) AS NetProfit
    FROM FinancialTransaction ft
    JOIN Student s ON ft.OwnerID = s.StudentID
    JOIN Room r ON s.RoomID = r.RoomID
    WHERE ft.TransactionDate BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY YEAR(TransactionDate), r.HostelID
),
YearlyTrends AS (
    SELECT
        yf.HostelID,
        yf.Year,
        yf.TotalIncome,
        yf.TotalExpenses,
        yf.NetProfit,
        LAG(yf.TotalIncome) OVER (PARTITION BY yf.HostelID ORDER BY yf.Year) AS PreviousIncome,
        LAG(yf.TotalExpenses) OVER (PARTITION BY yf.HostelID ORDER BY yf.Year) AS PreviousExpenses,
        LAG(yf.NetProfit) OVER (PARTITION BY yf.HostelID ORDER BY yf.Year) AS PreviousNetProfit
    FROM YearlyFinancials yf
)
SELECT
    yt.HostelID,
    yt.Year,
    yt.TotalIncome,
    yt.TotalExpenses,
    yt.NetProfit,
    CASE WHEN yt.PreviousIncome IS NULL OR yt.PreviousIncome = 0 THEN 0 ELSE ((yt.TotalIncome - yt.PreviousIncome) * 100.0 / yt.PreviousIncome) END AS IncomeChangePercent,
    CASE WHEN yt.PreviousExpenses IS NULL OR yt.PreviousExpenses = 0 THEN 0 ELSE ((yt.TotalExpenses - yt.PreviousExpenses) * 100.0 / yt.PreviousExpenses) END AS ExpensesChangePercent,
    CASE WHEN yt.PreviousNetProfit IS NULL OR yt.PreviousNetProfit = 0 THEN 0 ELSE ((yt.NetProfit - yt.PreviousNetProfit) * 100.0 / yt.PreviousNetProfit) END AS NetProfitChangePercent
FROM YearlyTrends yt
ORDER BY yt.HostelID, yt.Year;



////////////////////////   ----------------   MAINTAINANCE AND UTILITY SUMMARY ANALYSIS 

WITH YearlyMaintenance AS (
    SELECT
        YEAR(m.Date) AS Year,
        r.HostelID,
        SUM(m.Cost) AS TotalMaintenanceCost
    FROM Maintenance m
    JOIN Room r ON m.RoomID = r.RoomID
    WHERE m.Date BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY YEAR(m.Date), r.HostelID
),
YearlyUtility AS (
    SELECT
        YEAR(hu.Paymentdate) AS Year,
        hu.HostelID,
        SUM(hu.Amount) AS TotalUtilityCost
    FROM HostelUtilities hu
    WHERE hu.Paymentdate BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY YEAR(hu.Paymentdate), hu.HostelID
),
CombinedCosts AS (
    SELECT
        COALESCE(ym.HostelID, yu.HostelID) AS HostelID,
        COALESCE(ym.Year, yu.Year) AS Year,
        COALESCE(ym.TotalMaintenanceCost, 0) AS TotalMaintenanceCost,
        COALESCE(yu.TotalUtilityCost, 0) AS TotalUtilityCost,
        COALESCE(ym.TotalMaintenanceCost, 0) + COALESCE(yu.TotalUtilityCost, 0) AS TotalCost
    FROM YearlyMaintenance ym
    FULL OUTER JOIN YearlyUtility yu ON ym.HostelID = yu.HostelID AND ym.Year = yu.Year
),
CostTrends AS (
    SELECT
        cc.HostelID,
        cc.Year,
        cc.TotalMaintenanceCost,
        cc.TotalUtilityCost,
        cc.TotalCost,
        LAG(cc.TotalMaintenanceCost) OVER (PARTITION BY cc.HostelID ORDER BY cc.Year) AS PreviousMaintenanceCost,
        LAG(cc.TotalUtilityCost) OVER (PARTITION BY cc.HostelID ORDER BY cc.Year) AS PreviousUtilityCost,
        LAG(cc.TotalCost) OVER (PARTITION BY cc.HostelID ORDER BY cc.Year) AS PreviousTotalCost
    FROM CombinedCosts cc
)
SELECT
    ct.HostelID,
    ct.Year,
    ct.TotalMaintenanceCost,
    ct.TotalUtilityCost,
    ct.TotalCost,
    CASE WHEN ct.PreviousMaintenanceCost IS NULL OR ct.PreviousMaintenanceCost = 0 THEN 0 ELSE ((ct.TotalMaintenanceCost - ct.PreviousMaintenanceCost) * 100.0 / ct.PreviousMaintenanceCost) END AS MaintenanceChangePercent,
    CASE WHEN ct.PreviousUtilityCost IS NULL OR ct.PreviousUtilityCost = 0 THEN 0 ELSE ((ct.TotalUtilityCost - ct.PreviousUtilityCost) * 100.0 / ct.PreviousUtilityCost) END AS UtilityChangePercent,
    CASE WHEN ct.PreviousTotalCost IS NULL OR ct.PreviousTotalCost = 0 THEN 0 ELSE ((ct.TotalCost - ct.PreviousTotalCost) * 100.0 / ct.PreviousTotalCost) END AS TotalCostChangePercent
FROM CostTrends ct
ORDER BY ct.HostelID, ct.Year;




/////////////////////////////    --------HOSTEL OCCUPANCY RATES AND CHANGE IN THEM

WITH RoomCapacity AS (
    SELECT
        r.HostelID,
        SUM(CASE 
                WHEN r.RoomType = 'single' THEN 1 
                WHEN r.RoomType = 'double' THEN 2 
                WHEN r.RoomType = 'triple' THEN 3 
                ELSE 1 
            END) AS TotalCapacity
    FROM Room r
    GROUP BY r.HostelID
),
YearlyOccupancy AS (
    SELECT
        YEAR(ft.TransactionDate) AS Year,
        r.HostelID,
        COUNT(DISTINCT s.StudentID) AS NumberOfStudents
    FROM FinancialTransaction ft
    JOIN Student s ON ft.OwnerID = s.StudentID
    JOIN Room r ON s.RoomID = r.RoomID
    WHERE ft.TransactionType = 'studentrent' AND ft.TransactionDate BETWEEN '2019-01-01' AND '2024-12-31'
    GROUP BY YEAR(ft.TransactionDate), r.HostelID
),
OccupancyRates AS (
    SELECT
        yo.HostelID,
        yo.Year,
        yo.NumberOfStudents,
        rc.TotalCapacity,
        CASE 
            WHEN rc.TotalCapacity = 0 THEN 0 
            ELSE (yo.NumberOfStudents * 100.0 / rc.TotalCapacity) 
        END AS OccupancyRate,
        LAG(
            CASE 
                WHEN rc.TotalCapacity = 0 THEN 0 
                ELSE (yo.NumberOfStudents * 100.0 / rc.TotalCapacity) 
            END
        ) OVER (PARTITION BY yo.HostelID ORDER BY yo.Year) AS PreviousOccupancyRate
    FROM YearlyOccupancy yo
    JOIN RoomCapacity rc ON yo.HostelID = rc.HostelID
)
SELECT
    orates.HostelID,
    orates.Year,
    orates.NumberOfStudents,
    orates.TotalCapacity,
    orates.OccupancyRate,
    CASE 
        WHEN orates.PreviousOccupancyRate IS NULL OR orates.PreviousOccupancyRate = 0 THEN 0 
        ELSE ((orates.OccupancyRate - orates.PreviousOccupancyRate) * 100.0 / orates.PreviousOccupancyRate) 
    END AS OccupancyRateChangePercent
FROM OccupancyRates orates
ORDER BY orates.HostelID, orates.Year;


////////////////////////////////////

 CREATE TABLE Years (
    Year INT 
);
create VIEW ComplaintSummaryByYear AS
SELECT
    y.Year,
    COUNT(c.ComplaintID) AS TotalComplaints,
    SUM(CASE WHEN c.Status = 'Resolved' THEN 1 ELSE 0 END) AS ResolvedComplaints,
    SUM(CASE WHEN c.Status = 'Pending' THEN 1 ELSE 0 END) AS PendingComplaints
FROM Years y
LEFT JOIN Complaint c ON y.Year = YEAR(c.ComplaintDate)
GROUP BY y.Year;
CREATE PROCEDURE GenerateComplaintSummaryReport
AS
BEGIN
    -- Create a temporary table to hold the summary data
    IF OBJECT_ID('tempdb..#ComplaintSummary') IS NOT NULL DROP TABLE #ComplaintSummary;
    
    SELECT 
        Year,
        TotalComplaints,
        ResolvedComplaints,
        PendingComplaints,
        LAG(TotalComplaints) OVER (ORDER BY Year) AS PrevTotalComplaints,
        LAG(ResolvedComplaints) OVER (ORDER BY Year) AS PrevResolvedComplaints,
        LAG(PendingComplaints) OVER (ORDER BY Year) AS PrevPendingComplaints
    INTO #ComplaintSummary
    FROM ComplaintSummaryByYear;

    -- Calculate the final report with safe division
    SELECT 
        Year,
        TotalComplaints,
        ResolvedComplaints,
        PendingComplaints,
        CASE 
            WHEN PrevTotalComplaints IS NULL OR PrevTotalComplaints = 0 THEN NULL
            ELSE CAST((TotalComplaints - PrevTotalComplaints) * 100.0 / PrevTotalComplaints AS DECIMAL(5, 2))
        END AS PercentageChangeInComplaints,
        CASE 
            WHEN TotalComplaints = 0 THEN 0
            ELSE CAST(ResolvedComplaints * 100.0 / TotalComplaints AS DECIMAL(5, 2))
        END AS PercentageResolved,
        CASE 
            WHEN TotalComplaints = 0 THEN 0
            ELSE CAST(PendingComplaints * 100.0 / TotalComplaints AS DECIMAL(5, 2))
        END AS PercentagePending,
        CASE 
            WHEN PrevResolvedComplaints IS NULL OR PrevResolvedComplaints = 0 THEN NULL
            ELSE CAST((ResolvedComplaints - PrevResolvedComplaints) * 100.0 / PrevResolvedComplaints AS DECIMAL(5, 2))
        END AS PercentageChangeInResolved,
        CASE 
            WHEN PrevPendingComplaints IS NULL OR PrevPendingComplaints = 0 THEN NULL
            ELSE CAST((PendingComplaints - PrevPendingComplaints) * 100.0 / PrevPendingComplaints AS DECIMAL(5, 2))
        END AS PercentageChangeInPending
    FROM #ComplaintSummary
    ORDER BY Year;
	delete from Complaint
    -- Drop the temporary table
    DROP TABLE #ComplaintSummary;
END;
exec GenerateComplaintSummaryReport;



/////////////////////////////////////   -----ATTENDANCE CHANGE SUMMARY REPORT


CREATE  VIEW AttendanceYearlySummary AS
SELECT
    a.StudentID,
    s.Name AS StudentName,
    YEAR(a.Date) AS Year,
    SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS DaysPresent,
    SUM(CASE WHEN a.Status = 'Absent' THEN 1 ELSE 0 END) AS DaysAbsent,
    SUM(CASE WHEN a.Status = 'Leave' THEN 1 ELSE 0 END) AS DaysOnLeave
FROM Attendence a
JOIN Student s ON a.StudentID = s.StudentID
GROUP BY a.StudentID, s.Name, YEAR(a.Date);

WITH YearlyTrends AS (
    SELECT
        ays.StudentID,
        ays.StudentName,
        ays.Year,
        ays.DaysPresent,
        ays.DaysAbsent,
        ays.DaysOnLeave,
        LAG(ays.DaysPresent) OVER (PARTITION BY ays.StudentID ORDER BY ays.Year) AS PreviousYearPresent,
        LAG(ays.DaysAbsent) OVER (PARTITION BY ays.StudentID ORDER BY ays.Year) AS PreviousYearAbsent,
        LAG(ays.DaysOnLeave) OVER (PARTITION BY ays.StudentID ORDER BY ays.Year) AS PreviousYearLeave
    FROM AttendanceYearlySummary ays
)
SELECT
    yt.StudentID,
    yt.StudentName,
    yt.Year,
    yt.DaysPresent,
    yt.DaysAbsent,
    yt.DaysOnLeave,
    yt.PreviousYearPresent,
    yt.PreviousYearAbsent,
    yt.PreviousYearLeave,
    CASE 
        WHEN yt.PreviousYearPresent IS NULL OR yt.PreviousYearPresent = 0 THEN NULL
        ELSE (yt.DaysPresent - yt.PreviousYearPresent) * 100.0 / yt.PreviousYearPresent
    END AS PresentChangePercent,
    CASE 
        WHEN yt.PreviousYearAbsent IS NULL OR yt.PreviousYearAbsent = 0 THEN NULL
        ELSE (yt.DaysAbsent - yt.PreviousYearAbsent) * 100.0 / yt.PreviousYearAbsent
    END AS AbsentChangePercent,
    CASE 
        WHEN yt.PreviousYearLeave IS NULL OR yt.PreviousYearLeave = 0 THEN NULL
        ELSE (yt.DaysOnLeave - yt.PreviousYearLeave) * 100.0 / yt.PreviousYearLeave
    END AS LeaveChangePercent
FROM YearlyTrends yt
WHERE yt.Year BETWEEN 2019 AND 2024
ORDER BY yt.StudentID, yt.Year;