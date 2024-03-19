-- Challenge 3

-- 1. Create Table
-- Create table nasabah
CREATE TABLE Nasabah (
    nasabah_id BIGSERIAL PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    nomor_telepon VARCHAR(15) NOT NULL,
    kelamin VARCHAR(10) NOT NULL
);

-- Create table akun
CREATE TABLE Akun (
    akun_id BIGSERIAL PRIMARY KEY,
    jenis_akun VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    pin VARCHAR(6) NOT NULL,
    saldo DECIMAL(15, 2) DEFAULT 0,
    nasabah_id INT NOT NULL
);

-- Create table transaksi
CREATE TABLE Transaksi (
    transaksi_id BIGSERIAL PRIMARY KEY,
    jumlah_transaksi DECIMAL(15, 2) NOT NULL,
    tanggal_transaksi DATE NOT NULL,
    catatan TEXT NOT NULL,
    akun_id INT NOT NULL
);


-- 2. Create (Insert)
-- Insert data ke dalam tabel Nasabah
INSERT INTO Nasabah (nama, alamat, nomor_telepon, kelamin)
VALUES 
  ('Dewangga', 'Surabaya, Indonesia', '0812345678', 'Laki-laki'),
  ('Aziq', 'Malang, Indonesia', '0823456789', 'Laki-laki'),
  ('Luna', 'Jakarta, Indonesia', '0834567890', 'Perempuan'),
  ('Crescentia', 'Semarang, Indonesia', '0856789012', 'Perempuan'),
  ('Jason', 'Bandung, Indonesia', '0878901234', 'Laki-laki');

-- Insert data ke dalam tabel Akun
INSERT INTO Akun (jenis_akun, email, password, pin, saldo, nasabah_id)
VALUES 
  ('Tabungan', 'dewangga@example.com', 'dewa186', '123456', 1000000.00, 1),
  ('Tabungan', 'aziq@example.com', 'aziqgaming123', '654321', 2000000.00, 2),
  ('Deposito', 'luna@example.com', 'luna789', '987654', 5000000.00, 3),
  ('Tabungan', 'crescentia@example.com', 'crescentia456', '321123', 3000000.00, 4),
  ('Tabungan', 'jason@example.com', 'jason123', '999888', 4000000.00, 5);

-- Insert data ke dalam tabel Transaksi
INSERT INTO Transaksi (jumlah_transaksi, tanggal_transaksi, catatan, akun_id)
VALUES 
  (100000.00, '2023-01-19', 'Setoran awal', 1),
  (200000.00, '2023-11-10', 'Pembayaran tagihan', 2),
  (5000000.00, '2023-02-01', 'Penyetoran deposito', 3),
  (300000.00, '2023-02-05', 'Transfer ke akun lain', 4),
  (400000.00, '2023-12-31', 'Pembelian barang', 5);

-- 2.1. Transaksi Tambahan (Insert)
INSERT INTO Transaksi (jumlah_transaksi, tanggal_transaksi, catatan, akun_id)
VALUES 
  (1000000.00, '2024-03-19', 'Setoran awal bulan ini', 1),
  (500000.00, '2024-03-20', 'Pembayaran tagihan listrik', 1),
  (2000000.00, '2024-03-21', 'Setoran tunai', 2),
  (700000.00, '2024-03-22', 'Transfer ke rekening lain', 2),
  (300000.00, '2024-03-23', 'Pembayaran tagihan air', 2),
  (3000000.00, '2024-03-24', 'Setoran dana darurat', 3),
  (1500000.00, '2024-03-25', 'Transfer ke rekening tabungan', 3),
  (800000.00, '2024-03-26', 'Pembayaran tagihan internet', 3),
  (1200000.00, '2024-03-27', 'Penarikan tunai', 3),
  (4000000.00, '2024-03-28', 'Setoran investasi', 4),
  (200000.00, '2024-03-29', 'Transfer ke akun tabungan', 4),
  (5000000.00, '2024-03-30', 'Setoran awal bulan ini', 5),
  (1000000.00, '2024-03-31', 'Transfer ke tabungan lain', 5),
  (700000.00, '2024-04-01', 'Pembayaran tagihan kartu kredit', 5),
  (200000.00, '2024-04-02', 'Penarikan tunai darurat', 5);


-- 3. Read (Select)
-- Menampilkan semua data dari tabel Nasabah
SELECT * FROM Nasabah;

-- Menampilkan semua data dari tabel Akun
SELECT * FROM Akun;

-- Menampilkan semua data dari tabel Transaksi
SELECT * FROM Transaksi;


-- 4. Update
-- Memperbarui saldo dalam tabel Akun
UPDATE Akun
SET saldo = saldo + 500000.00
WHERE akun_id = 1;

-- Memperbarui catatan dalam tabel Transaksi
UPDATE Transaksi
SET catatan = 'Penambahan saldo'
WHERE transaksi_id = 1;


-- 5. Delete
-- Menghapus transaksi dengan transaksi_id 11
DELETE FROM Transaksi WHERE transaksi_id = 11;

-- Menghapus transaksi dengan transaksi_id 7
DELETE FROM Transaksi WHERE transaksi_id = 7;


-- 6. Gabungan
WITH JumlahTransaksiPerAkun AS (
    SELECT akun_id, count(*) from transaksi group by akun_id
) SELECT
    Nasabah.nama "Nama Nasabah",
    Nasabah.alamat "Alamat Nasabah",
    Nasabah.nomor_telepon "Nomor Telepon Nasabah",
    Nasabah.kelamin "Kelamin Nasabah",
    Akun.jenis_akun "Jenis Tabungan",
    Akun.saldo "Saldo Nasabah",
    JumlahTransaksiPerAkun.count "Jumlah Transaksi"
FROM 
    Nasabah
LEFT JOIN 
    Akun ON Nasabah.nasabah_id = Akun.nasabah_id
LEFT JOIN 
    JumlahTransaksiPerAkun ON Nasabah.nasabah_id = JumlahTransaksiPerAkun.akun_id;