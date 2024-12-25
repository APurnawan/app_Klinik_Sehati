-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2024 at 03:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbklinik`
--

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('0779eb09aed9');

-- --------------------------------------------------------

--
-- Table structure for table `bayar_obat`
--

CREATE TABLE `bayar_obat` (
  `id_bobt` varchar(10) NOT NULL,
  `daftar_id` varchar(10) DEFAULT NULL,
  `total_bayar` decimal(10,2) NOT NULL,
  `metode_bayar` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `biayaadministrasi`
--

CREATE TABLE `biayaadministrasi` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `biaya` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `biayaadministrasi`
--

INSERT INTO `biayaadministrasi` (`id`, `nama`, `biaya`) VALUES
(1, 'Biaya Admin', 30000);

-- --------------------------------------------------------

--
-- Table structure for table `biayapendaftaran`
--

CREATE TABLE `biayapendaftaran` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `biaya` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `biayapendaftaran`
--

INSERT INTO `biayapendaftaran` (`id`, `nama`, `biaya`) VALUES
(1, 'Biaya Pendaftaran', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `biaya_obat`
--

CREATE TABLE `biaya_obat` (
  `id_bobt` varchar(10) NOT NULL,
  `daftar_id` varchar(10) DEFAULT NULL,
  `total_bayar` decimal(10,2) NOT NULL,
  `metode_bayar` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `biaya_obat`
--

INSERT INTO `biaya_obat` (`id_bobt`, `daftar_id`, `total_bayar`, `metode_bayar`) VALUES
('B01', 'DF001', 30000.00, 'Debit'),
('B02', 'DF002', 20000.00, 'Debit');

-- --------------------------------------------------------

--
-- Table structure for table `detailobat`
--

CREATE TABLE `detailobat` (
  `id_dobt` varchar(10) NOT NULL,
  `daftar_id` varchar(10) DEFAULT NULL,
  `id_obat` int(11) DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `harga` float NOT NULL,
  `total` float NOT NULL DEFAULT 0,
  `tanggal_resep` date NOT NULL,
  `pegawai_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detailobat`
--

INSERT INTO `detailobat` (`id_dobt`, `daftar_id`, `id_obat`, `qty`, `harga`, `total`, `tanggal_resep`, `pegawai_id`) VALUES
('D01', 'DF001', 18, 1, 30000, 30000, '2024-11-09', 'DK001'),
('D02', 'DF002', 13, 1, 20000, 20000, '2024-12-18', 'DK001');

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id` int(11) NOT NULL,
  `id_pegawai` varchar(100) DEFAULT NULL,
  `jadwal` varchar(100) NOT NULL,
  `tarif_medis` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dokter`
--

INSERT INTO `dokter` (`id`, `id_pegawai`, `jadwal`, `tarif_medis`) VALUES
(1, 'DK001', 'Senin - Jumat 8:00 - 12:00', 150000.00),
(7, 'DK002', 'Senin - Jumat 08:30 - 12:00', 100000.00);

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `namaObat` varchar(150) DEFAULT NULL,
  `jenisObat` varchar(150) DEFAULT NULL,
  `harga_beli` int(11) DEFAULT NULL,
  `harga_jual` int(11) DEFAULT NULL,
  `suplier_id` int(11) DEFAULT NULL,
  `kondisi` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `namaObat`, `jenisObat`, `harga_beli`, `harga_jual`, `suplier_id`, `kondisi`) VALUES
(10, 'Bodrek', 'Paten', 10000, 12000, 6, 'Rusak'),
(13, 'Omeprazole', 'Paten', 12000, 15000, 1, 'Baik'),
(15, 'Paramex', 'Paten', 5000, 7000, NULL, 'Baik'),
(16, 'Omeprazole', 'Paten', 15000, 20000, 6, 'Baik'),
(17, 'Amoxilin', 'Paten', 10000, 15000, 1, 'Baik'),
(18, 'Paracetamol', 'Paten', 25000, 30000, 1, 'Baik'),
(25, 'Konidin', 'Paten', 5000, 10000, 1, 'Baik');

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` bigint(20) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `keluhan` text DEFAULT NULL,
  `diagnosa` varchar(100) DEFAULT NULL,
  `resep` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `pendaftaran_id` varchar(10) DEFAULT NULL,
  `tanggal` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `keluhan`, `diagnosa`, `resep`, `user_id`, `pendaftaran_id`, `tanggal`) VALUES
(2, 'Johan', 'Batuk, Meriang', 'Flu dan Radang tengorokan', 'Paracetamol (2x1) -  selama 3 hari', 9, 'DF001', '09 November 2024 Jam 05:24:12'),
(4, 'Linda', 'Perut Kembung dan Mual', 'Asam Lambung tinggi', 'Omeprazole 2 x sehari selama 5 hari', 19, 'DF002', '15 December 2024 Jam 14:50:21'),
(8, 'Linda', 'Sakit Perut', 'Maag', 'Omeprzole', 9, 'DF002', '18 December 2024 Jam 19:17:43');

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `jabatan` varchar(100) NOT NULL,
  `spesialisasi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `nama`, `alamat`, `no_hp`, `jabatan`, `spesialisasi`) VALUES
('DK001', 'Dr. Ridwan', 'Jl. Kamboja No. 4', '080987654321', 'Dokter', 'Dokter Umum'),
('DK002', 'Dr. Dewi', 'Jl. Bunga No. 1, Surabaya', '08111001001', 'Dokter', 'Dokter Anak'),
('DK003', 'Dr. Bagus', 'Jl. Agrek1', '081234567', 'Dokter', 'Dokter Umum'),
('DK004', 'Dr. Ruli', 'Jl. Anggrek', '0811111111', 'Dokter', 'Dokter Umum'),
('PG001', 'Alan', 'Jl. Bunga No. 2', '08111001008', 'Staff Klinik', 'Admin'),
('PG002', 'Rara', 'Jl. Mawar No. 2', '08111001005', 'Staff Klinik', 'Kasir'),
('PG003', 'Mimin', 'Jl. Angsana No. 5', '08111001005', 'Staff Klinik', 'Apoteker'),
('PG004', 'Lisa', 'Jl. Pahlawan 1', '081223222222', 'Staft Klinik', 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_bmedis` varchar(10) NOT NULL,
  `id_daftar` varchar(10) DEFAULT NULL,
  `tanggal_bayar` date NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `dokter_id` int(11) DEFAULT NULL,
  `total_bayar` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_bmedis`, `id_daftar`, `tanggal_bayar`, `admin_id`, `dokter_id`, `total_bayar`) VALUES
('BM001', 'DF001', '2024-12-15', 1, 1, 180000.00),
('BM002', 'DF002', '2024-12-18', 1, 7, 130000.00);

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `id_daftar` varchar(100) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `tl` varchar(100) DEFAULT NULL,
  `tg_lahir` varchar(100) DEFAULT NULL,
  `jk` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `profesi` varchar(100) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `id_pegawai` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`id_daftar`, `nama`, `tl`, `tg_lahir`, `jk`, `status`, `profesi`, `alamat`, `keterangan`, `id_pegawai`) VALUES
('DF001', 'Johan', 'Jakarta', '2024-11-21', 'Laki-Laki', 'Sudah Menikah', 'Karyawan Swasta', 'Jl. Bunga No. 2, Surabaya', 'Selesai', 'DK001'),
('DF002', 'Linda', 'Surabaya', '2024-11-01', 'Perempuan', 'Sudah Menikah', 'Guru', 'Jl. Bunga No. 2, Surabaya', 'Selesai', 'DK002');

-- --------------------------------------------------------

--
-- Table structure for table `suplier`
--

CREATE TABLE `suplier` (
  `id` int(11) NOT NULL,
  `perusahaan` varchar(200) DEFAULT NULL,
  `kontak` varchar(100) DEFAULT NULL,
  `alamat` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suplier`
--

INSERT INTO `suplier` (`id`, `perusahaan`, `kontak`, `alamat`) VALUES
(1, 'PT Kimia Farma', '081222111', 'Jl. Garuda'),
(6, 'PT Sido Muncul', '081222111', 'Jl. Fatmawati'),
(15, 'PT ABC', '08155544444', 'JL Bukit Duri 1');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `level`) VALUES
(2, 'Admin', '$2b$12$nBK1c1fKcUR8AoV53P/lE.JNeMjVpKM4fcwkHqcwrwVvQibECdhSm', 'Admin'),
(9, 'Dr.Ridwan', '$2b$12$NxsQ8Aoe6/N.crudZL6hqe/VvA0tU3UTYy5TpU5ATLy8DUNwafjyu', 'Dokter'),
(13, 'Mimin', '$2b$12$QuZNjgJ6KTtIOXpDj89UmOLcQ93z47gODys2uz45v2UMfJA4bohhi', 'Apoteker'),
(14, 'Rara', '$2b$12$mCEdLd8NlwboeL5iwtFd8O2smHzpUVFPq6BsBfPTvKGCv4rulkiVW', 'Kasir'),
(15, 'Lisa', '$2b$12$2eu/sBYENVQ.4qAfjhObPuM/XUoY9FUYrYXvADv092zpbPQ5tgjve', 'Administrasi'),
(19, 'Dr. Dewi', '$2b$12$MSDTfkmjGcNn4rqKXjfqEuEBljFjuz.hWM.jWL9Om1rjG7/gHSj/q', 'Dokter');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indexes for table `bayar_obat`
--
ALTER TABLE `bayar_obat`
  ADD PRIMARY KEY (`id_bobt`),
  ADD KEY `daftar_id` (`daftar_id`);

--
-- Indexes for table `biayaadministrasi`
--
ALTER TABLE `biayaadministrasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `biayapendaftaran`
--
ALTER TABLE `biayapendaftaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `biaya_obat`
--
ALTER TABLE `biaya_obat`
  ADD PRIMARY KEY (`id_bobt`),
  ADD KEY `daftar_id` (`daftar_id`);

--
-- Indexes for table `detailobat`
--
ALTER TABLE `detailobat`
  ADD PRIMARY KEY (`id_dobt`),
  ADD KEY `id_daftar` (`daftar_id`),
  ADD KEY `id_obat` (`id_obat`),
  ADD KEY `pegawai_id` (`pegawai_id`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_id_pegawai` (`id_pegawai`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suplier_id` (`suplier_id`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_pendaftaran` (`pendaftaran_id`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_bmedis`),
  ADD KEY `pendaftaran_id` (`id_daftar`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `dokter_id` (`dokter_id`);

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`id_daftar`),
  ADD KEY `id_pegawai` (`id_pegawai`);

--
-- Indexes for table `suplier`
--
ALTER TABLE `suplier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `biayaadministrasi`
--
ALTER TABLE `biayaadministrasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `biayapendaftaran`
--
ALTER TABLE `biayapendaftaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `suplier`
--
ALTER TABLE `suplier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bayar_obat`
--
ALTER TABLE `bayar_obat`
  ADD CONSTRAINT `bayar_obat_ibfk_1` FOREIGN KEY (`daftar_id`) REFERENCES `pendaftaran` (`id_daftar`);

--
-- Constraints for table `biaya_obat`
--
ALTER TABLE `biaya_obat`
  ADD CONSTRAINT `biaya_obat_ibfk_1` FOREIGN KEY (`daftar_id`) REFERENCES `pendaftaran` (`id_daftar`);

--
-- Constraints for table `detailobat`
--
ALTER TABLE `detailobat`
  ADD CONSTRAINT `detailobat_ibfk_1` FOREIGN KEY (`daftar_id`) REFERENCES `pendaftaran` (`id_daftar`),
  ADD CONSTRAINT `detailobat_ibfk_2` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id`),
  ADD CONSTRAINT `detailobat_ibfk_3` FOREIGN KEY (`pegawai_id`) REFERENCES `pegawai` (`id_pegawai`);

--
-- Constraints for table `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `dokter_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `obat`
--
ALTER TABLE `obat`
  ADD CONSTRAINT `obat_ibfk_1` FOREIGN KEY (`suplier_id`) REFERENCES `suplier` (`id`);

--
-- Constraints for table `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `fk_pendaftaran` FOREIGN KEY (`pendaftaran_id`) REFERENCES `pendaftaran` (`id_daftar`) ON DELETE CASCADE,
  ADD CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `pasien_ibfk_2` FOREIGN KEY (`pendaftaran_id`) REFERENCES `pendaftaran` (`id_daftar`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_daftar`) REFERENCES `pendaftaran` (`id_daftar`),
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `biayaadministrasi` (`id`),
  ADD CONSTRAINT `pembayaran_ibfk_3` FOREIGN KEY (`dokter_id`) REFERENCES `dokter` (`id`);

--
-- Constraints for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD CONSTRAINT `pendaftaran_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
