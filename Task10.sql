Create Database [Library]

use [Library]

-- Tables and Foreign Keys
create table [dbo].[Books](
        [Id] int primary key identity(1,1),
		[Name] nvarchar(100),
		[AuthorId] int,
		[GenreId] int,
		[Price] decimal(18,2) CHECK ([Price] > 0),
		[PageCount] int,
		[Published] datetime,
		[CreatedDate] datetime DEFAULT(getdate()) not null	
)


create table [dbo].[Authors](
        [Id] int primary key identity(1,1),
		[Name] nvarchar(100)
)

create table [dbo].[Genres](
        [Id] int primary key identity(1,1),
		[Name] nvarchar(100)
)

alter table [dbo].[Books]
add constraint FK_Books_Authors foreign key ([AuthorId]) references [Authors]([Id])

alter table [dbo].[Books]
add constraint FK_Books_Genres foreign key ([GenreId]) references [Genres]([Id])

--Insert

Insert into [dbo].[Authors]([Name])
Values(N'Sabahattin Ali'),     
      (N'Çingiz Abdullayev'), 
	  (N'Stefan Zweig'), 
	  (N'Mary Sheley'), 
	  (N'James Clear');
	  
Insert into [dbo].[Genres]([Name])
Values(N'Roman'),     
      (N'Dedektiv'), 
	  (N'Klassik'), 
	  (N'Bilim&Kurgu'), 
	  (N'Qorxu');


Insert into [dbo].[Books]([Name],[AuthorId],[GenreId],[Price],[PageCount],[Published])
Values(N'Kürk Mantolu Madonna', 1, 1, 5.70, 184, '2012.12.12 10:11:20'),
      (N'Etiraflar Vadisi', 2, 2, 7.40, 115, N'2009.03.14 20:35:00'),
      (N'Satranç', 3, 3, 4.99, 72, N'2009.03.14 17:45:10'),
      (N'Bilinmeyen Bir Kadının Mektubu', 3, 3, 3.55, 90, N'1993.11.23 13:32:43'),
      (N'Frankenstein', 4, 5, 15.33, 456, N'1981.07.05 03:22:53'),
	  (N'Atomic Habits', 5, 4, 20.23, 510, N'2007.10.13 14:24:13');


--7.  Kitabları ən bahadan ən ucuza doğru sıralamaq

select * from [dbo].[Books]
order by [Price] Desc


--8.  Ən ucuz 3 kitabı göstərmək (top - arasdirmaq)

select top(3) * from [dbo].[Books]
order by [Price] Asc


--9.  Müəllifi "Çingiz Abdullayev" olan kitabları göstərmək

select * from [dbo].[Books]
where [AuthorId] = 2 -- Cingiz Abdullayevin Id-si


--10. Müəllifi "Çingiz Abdullayev" olan kitabların cari qiymətlərini
--5% artırmaq üçün script yazmaq
--(ama hamısını yox sadecə müəllif "Çingiz Abdullayev"-dirsə)

Update [dbo].[Books]
set [Price] = [Price] * 1.05
where [AuthorId] = 2 -- Cingiz Abdullayevin Id-si


--11. Qiyməti 10m-dan böyük kitabları silmək

Delete  from [dbo].[Books] where [Price] > 10


--12. Sonda cədvəl elə silinsin ki yeni sətir
--insert edəndə Id - yeniden 1`dən başlasın

truncate table [dbo].[Books]
