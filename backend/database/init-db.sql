-- Create database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'StudentManagement')
BEGIN
    CREATE DATABASE StudentManagement;
END
GO

USE StudentManagement;
GO

-- Create students table if missing (matches Laravel migration)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[students]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[students] (
        [id] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [student_code] NVARCHAR(50) NOT NULL UNIQUE,
        [full_name] NVARCHAR(255) NOT NULL,
        [email] NVARCHAR(255) NULL,
        [phone] NVARCHAR(20) NULL,
        [date_of_birth] DATE NULL,
        [class_name] NVARCHAR(100) NULL,
        [created_at] DATETIME2 NULL,
        [updated_at] DATETIME2 NULL
    );
END
GO

-- Seed sample students (idempotent by student_code)
IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV001')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV001', N'Nguyễn Văn An', 'nguyenvanan@example.com', '0912345678', '2000-01-15', 'CNTT2020A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV002')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV002', N'Trần Thị Bình', 'tranthibinh@example.com', '0923456789', '2001-03-20', 'CNTT2020B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV003')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV003', N'Lê Văn Cường', 'levancuong@example.com', '0934567890', '2000-07-10', 'CNTT2020A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV004')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV004', N'Phạm Thị Dung', 'phamthidung@example.com', '0945678901', '2001-05-25', 'CNTT2020B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV005')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV005', N'Hoàng Văn Em', 'hoangvanem@example.com', '0956789012', '2000-11-30', 'CNTT2020A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV006')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV006', N'Vũ Thị Phương', 'vuthiphuong@example.com', '0967890123', '2001-09-12', 'CNTT2020B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV007')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV007', N'Đỗ Văn Giang', 'dovangiang@example.com', '0978901234', '2000-04-18', 'CNTT2020A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV008')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV008', N'Bùi Thị Hoa', 'buithihoa@example.com', '0989012345', '2001-08-22', 'CNTT2020B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV009')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV009', N'Ngô Văn Hùng', 'ngovanhung@example.com', '0911222333', '2000-02-05', 'CNTT2021A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV010')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV010', N'Phan Thị Lan', 'phanthilan@example.com', '0921333444', '2001-06-18', 'CNTT2021B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV011')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV011', N'Đinh Văn Minh', 'dinhvanminh@example.com', '0931444555', '1999-12-12', 'CNTT2020C', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV012')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV012', N'Tạ Thị Ngọc', 'tathingoc@example.com', '0941555666', '2001-01-27', 'CNTT2021A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV013')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV013', N'Đoàn Văn Phúc', 'doanvanphuc@example.com', '0951666777', '2000-10-03', 'CNTT2020B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV014')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV014', N'Mai Thị Quỳnh', 'maithiquynh@example.com', '0961777888', '2002-04-11', 'CNTT2022A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV015')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV015', N'Trương Văn Sơn', 'truongvanson@example.com', '0971888999', '1999-09-09', 'CNTT2020C', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV016')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV016', N'Lâm Thị Trang', 'lamthitrang@example.com', '0981999000', '2002-07-21', 'CNTT2022B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV017')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV017', N'Hồ Văn Uy', 'hovanuy@example.com', '0991000111', '2001-11-15', 'CNTT2021B', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV018')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV018', N'Võ Thị Vân', 'vothivan@example.com', '0902111222', '2000-05-06', 'CNTT2020A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV019')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV019', N'Lương Văn Xuyên', 'luongvanxuyen@example.com', '0912333444', '1999-03-30', 'CNTT2019A', SYSDATETIME(), SYSDATETIME());

IF NOT EXISTS (SELECT 1 FROM students WHERE student_code = 'SV020')
INSERT INTO students (student_code, full_name, email, phone, date_of_birth, class_name, created_at, updated_at)
VALUES ('SV020', N'Kiều Thị Yến', 'kieuthiyen@example.com', '0922444555', '2002-02-14', 'CNTT2022C', SYSDATETIME(), SYSDATETIME());
