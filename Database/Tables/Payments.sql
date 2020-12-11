﻿CREATE TABLE [dbo].[Payments]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY REFERENCES Reservations(Id),
	[Amount] MONEY NOT NULL,
	[DateTime] DATETIME NOT NULL,
	[TransactionNumber] NVARCHAR(50) NOT NULL
)
