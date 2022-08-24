--Personel isminde bir tablo olusturalım
create table personel(
pers_id int,
isim varchar (30),
sehir varchar (30),
sirket varchar(20),
adres varchar(50)
);

--Varolan personel tablosundan pers_id, sehir, adres fieldlarına sahip personel_adres adında yeni bir tablo olusturalim
create table personel_adres
as
select pers_id, sehir, adres from personel;

select * from personel

-- DML--> Data Manupulation Language.
-- INSERT - UPDATE - DELETE
-- Tabloya veri ekleme - tablodan veri güncelleme -  silme işlemlerinde kullanilan komutlar
--INSERT
create table student(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25 );
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003', 'Ayse Can',45);
INSERT into student VALUES ('1004', 'Derya Can',55);

--Tabloya parcalı veri ekleme
insert into student(st_name,age) values ('Murat Can', 65);

--DQL --> Data Query Language
--SELECT
select * from student;  --hepsini getirir

select st_name from student; -- st_name getirir

--SELECT KOMUTU WHERE KOSULU
select * from student WHERE age>35;

--TCL --> Transaction Control Language
--Begin - Savepoint - Rollback- Commit
--Transaction veritabanı sistemlerinde bir işlem basladıgında baslar ve işlem bitince sona erer.
--Bu işlem veri tabanı olusturma, veri silme, veri güncelleme, veriyi geri getirme gibi işlemler olabilir. 

create table ogrenciler2(
id serial,
isim varchar(50),
veli_isim varchar(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 values (default, 'Ali Can', 'Hasan Can', 75.5);
insert into ogrenciler2 values (default, 'Canan Gül', 'Ayse Sen', 90.5);
savepoint x;
insert into ogrenciler2 values (default, 'Kemal Can', 'Ahmet Can', 85.5);
insert into ogrenciler2 values (default, 'Ahmet Sen', 'Ayse Can', 65.5);

ROLLBACK TO x;

select * from ogrenciler2

commit;
--Transaction kullanımında SERIAL data türü kullanımı tavsiye edilmez. 
--savepoint'ten sonra ekledigimiz veride sayac mantıgı ile calıstıgı icin
--sayacta en son hangi sayıda kaldıysa ordan devam eder
--NOT :  PostgreSQL de transaction kullanımı ıcın 'Begin' komutuyla baslarız sonrasında tekrar yanlıs bir veriyi 
--düzeltmek veya bizim ıcın önemli olan verilerden sonra ekleme yapabilmek ıcın 'SAVEPOINT savepointadi (verdigimiz isim)' kullanırız 
--ve bu savepointe dönebilmek icin 'ROLLBACK TO savepointadi' komutunu kullanırız ve rollback calıstırıldıgında 
--savepoint yazdıgımız satırın üstündeki verileri tabloda bize verir 
--ve son olarak Transaction'ı sonlandırmak ıcın mutlaka 'COMMIT' komutu kullanırız. MySQL de transaction olmadanda kullanılır.

--DML - DELETE -
--DELETE FROM tablo_adi -- > Tablo'nun tüm icerigini siler
-- Veri'yi secerek silmek icin WHERE kosulu kullanılır
--DELETE FROM tablo_adi WHERE sutun_adi = veri --> Tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler VALUES (123, 'Ali Can', 'Hasan', 75);
INSERT INTO ogrenciler VALUES (124, 'Merve Gül', 'Ayse', 85);
INSERT INTO ogrenciler VALUES (125, 'Kemal Yasa', 'Hasan', 85);
INSERT INTO ogrenciler VALUES (126, 'Nesibe Yilmaz', 'Ayse', 95);
INSERT INTO ogrenciler VALUES (127, 'Mustafa Bak', 'Can', 99);
INSERT INTO ogrenciler VALUES (127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

--Soru : id'si 124 olan ogrenciyi siliniz
DELETE FROM ogrenciler WHERE id = 124;

--Soru : ismi Kemal Yasa olan satırı siliniz
DELETE FROM ogrenciler WHERE isim= 'Kemal Yasa';

--Soru : ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim
DELETE FROM ogrenciler WHERE isim='Nesibe Yilmaz' or isim= 'Mustafa Bak';

--Soru : ismi Ali Can ve id'si 123 olan kaydi siliniz
DELETE FROM ogrenciler WHERE isim='Ali Can' or id=123;

--Tablodaki tüm verileri silelim
DELETE FROM ogrenciler;

--DELETE - TRUNCATE --
-- TRUNCATE komutu DELETE  komutu gibi tablodaki verilerin tamamını siler.
--Ancak secmeli silme yapma
TRUNCATE TABLE ogrenciler;

-- DDL - Data Definition Language
-- CREATE - ALTER - DROP
-- ALTER TABLE --
-- ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS işlemleri icin kullanılır


--Peronel isminde bir tablo olusturalım
create table isciler(
pers_id int,
isim varchar (30),
sehir varchar (30),
sirket varchar(20),
adres varchar(50)
);
select * from isciler;

-- Personel tablosuna cinsiyet VARCHAR(20) ve yas int seklinde yeni sutunlar ekleyiniz.
alter table personel add cinsiyet varchar(20), add yas int;

--Personel tablosundan şirker field'ini siliniz.
alter table personel drop column sirket;

--Personel tablosundaki sehir sutununun adını ulke olarak degistirelim.
alter table personel rename column sehir to ulke;

--Personel tablosunun adını isciler olarak degistirin
alter table personel rename to isciler;

-- DDL - DROP komutu 
DROP table isciler;

--CONSTRAINT -- Kısıtlamalar
--Primary Key --> Bir sutunun NULL icermemesini ve sutundaki verilerin BENZERSİZ olmasını saglar (NOT NULL - UNIQUE)
--Foregin Key --> Baska bir tablodaki Primary Key'i referans göstermek ıcın kullanılır
--Böylelikle, tablolar arasında ilişki kurmus oluruz.
--UNIQUE --> Bir sutundaki tum degerlerin BENZERSİZ yani tek olmasını saglar
--NOT NULL --> Bir sutunun NULL icermemesini yani bos olmamasını saglar
--NOT NULL kısıtlaması ıcın CONSTRAINT ismi tanımlanmaz. Bu kısıtlama veri türünden hemen sonra yerleştirilir
--CHECK --> Bir sutuna yerleştirilebilecek deger aralıgını sınırlamak ıcın kullanılır.


CREATE TABLE calisanlar(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);


INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY

select * from calisanlar


-- FOREIGN KEY--
CREATE TABLE adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)   
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;



























    









