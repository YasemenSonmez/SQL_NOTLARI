CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

-- soru : id'si 124 olan ögrenciyi silin
DELETE from ogrenciler WHERE id = 124;
-- soru2 : ismi Kemal Yasa olan satiri siliniz


-- Soru : ismi Kemal Yasa olan satırı siliniz
DELETE from ogrenciler WHERE isim = 'Kemal Yasa';
-- Soru : ismi Nesibe Yılmaz veya Mustafa Bak olan kayıtları silelim
DELETE from ogrenciler WHERE isim = 'Nesibe Yılmaz' or isim ='Mustafa Bak';








