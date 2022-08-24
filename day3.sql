CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE, -- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL, -- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
ise_baslama DATE
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY




-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
--Calısanlar id ile adresler tablosundaki adres_id ile eşlesenlere bakmak için
select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;
DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir


delete from calisanlar where id= '10002' --parent

delete from adresler WHERE adres_id = '10002' --child

drop table calisanlar;

--ON DELETE CASCADE--
--Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliğini aktif hale getirebilirz
--Bunun ıcın FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli


CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

select * from talebeler

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);

select * from notlar

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

DELETE FROM notlar where talebe_id ='123'

DELETE FROM talebeler where id='126' --ON DELETE CASCADE kullndıgımız ıcın PARENT table'dan direk silebildik
--Parent table'dan sildiğimiz icin child table'dan da silmis olur
DELETE FROM talebeler


DROP table talebeler CASCADE; -- Parent tabloyu kaldırmak istersek 
--Drop table tablo_adi'ndan sonra CASCADE komunutu kullanırız

--Talebeler tablosundaki isim sutununa NOTT NULL kısıtlaması ekleyiniz ve veri tipini VARCHAR(30) olarak degıstırınız
alter table talebeler
alter column isim TYPE VARCHAR(30),
alter column isim SET NOT NULL;

--Talebeler tablosundaki yazili_notu sutununa 60 dan buyuk rakam girilebilsin
alter table talebeler
add constraint sinir check (yazili_notu > 60);
--CHECK kısıtlaması ile tablodaki istediğimiz sutunu sınırlandırabiliriz
--yukarıda 60'i sinir olarak belirlediğimiz ıcın bunu eklemedi
INSERT INTO talebeler VALUES(128, 'Mustafa Can', 'Hasan',45);


create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);
select * from ogrenciler


Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenci_adres

--Tablodaki bir sutuna PRIMARY KEY ekleme
alter table ogrenciler 
ADD PRIMARY KEY (id);

--PRIMARY KEY olusturmada 2.yol
alter table ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY(id);

--PK'den sonra FK ataması
alter table ogrenci_adres
ADD foreign key (id) REFERENCES ogrenciler;
--Child tabloyu parent tablodan olusturdugumuz ıcın sutun adı verilmedi

--PK' yi silme CONSTRANT silme
alter table ogrenciler DROP CONSTRAINT pk_id;
--FK'yi silme CONTRAINT silme
alter table ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;

--Yazılı notu 85 den buyuk olan talebe bilgilerini getirin
Select * from talebeler WHERE yazili_notu>85;

--İsmi Mustafa Bak olan talebenin tüm bilgilerini getirin
select * from talebeler WHERE isim='Mustafa Bak'

--SELECT komutunda -- BETWEEN Kosulu
--Between belirttigimiz 2 veri arasındaki bilgileri listeler
--Between de belirttiğimiz degerler de listelemeye dahildir

create table personel
(
id char(4),
isim varchar(50),
maas int
);
select * from personel

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir
Bir tanesi gerçekleşmezse listelemez
    Select * from matematik sinav1 > 50 AND sınav2 > 50
Hem sınav1 hemde sınav2 alanı, 50'den büyük olan kayıtları listeler
    OR (VEYA): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
    select * From matematik sınav>50 OR sınav2>50 
Hem sınav1 veya sınav2 alanı, 50 den büyük olan kayıtları listeler
*/

--id'si 1003 ile 1005 arasında olan personel bilgisini listeleyiniz
select * from personel where id between '1003' and '1005';

--2.yol
select * from personel where id>='1003' and id<='1005';

--Derya Soylu ile Yavuz Bal arasındaki personel bilgisini listeleyiniz
select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal';

--Maası 70000 ve ismi Sena olan personeli listele
select * from personel where maas = 70000 or isim = 'Sena Beyaz';

--IN (in) : Birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları tek komutta yazabilme imkanı verir
--Farklı sütunlar için IN kullanılamaz
--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele
select * from personel where id ='1001' or id='1002' or id='1004';

--2.yol
select * from personel where id in ('1001', '1002', '1004');

--Maası sadece 70000, 100000 olan personeli listele
select * from personel where maas in(70000, 100000);

/*
SELECT - LIKE kosulu
LIKE : Sorgulama yaparken belirli kalıp ifadeleri kullanabilmemizi saglar
ILIKE : Sorgulama yaparken büyük/kücük harfe duyarsız olarak eşleştirir.
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE : !~~*

% --> 0 veya daha fazla karakteri belirtir.
_ --> tek bir karakteri belirtir
*/

-- Ismi A harfi ile baslayan personeli listele
select * from personel where isim like 'A%';  --A ile baslaısn sonu ne olursa olsun demek

-- Ismi t harfi ile biten personeli listele
select * from personel where isim like '%t'; --> bası ne olursa olsun sonu t ile birtsin demek

--Isminin 2.harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';

















