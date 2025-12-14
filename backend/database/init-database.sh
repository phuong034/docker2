#!/bin/bash
# Wait for SQL Server to be ready
echo "Waiting for SQL Server to start..."
sleep 30

# Create database
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P YourStrong@Passw0rd -Q "IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'StudentManagement') CREATE DATABASE StudentManagement" || exit 1

echo "Database StudentManagement created successfully!"

