from klinik import app, db, bcrypt

class User(db.Model):
    __tablename__ = 'user'
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150))
    password = db.Column(db.Text)
    level = db.Column(db.String(100))

    pasiens = db.relationship('Pasien', back_populates='user') 

    def __init__(self, username, password, level):
        self.username = username
        if password != '':
            self.password = bcrypt.generate_password_hash(password).decode('UTF-8')
        self.level = level

         

class Dokter(db.Model):
    __tablename__ = 'dokter'
    id = db.Column(db.Integer, primary_key=True)
    id_pegawai = db.Column(db.String(10), db.ForeignKey('pegawai.id_pegawai'), unique=True, nullable=False)
    jadwal = db.Column(db.String(100))
    tarif_medis = db.Column(db.Numeric(10, 2))

    
    pegawai = db.relationship('Pegawai', back_populates='dokter')
    pembayaran = db.relationship('Pembayaran', back_populates='jasa_dokter_ref')

class Pegawai(db.Model):
    __tablename__ = 'pegawai'
    
    id_pegawai = db.Column(db.String(10), primary_key=True)  
    nama = db.Column(db.String(150), nullable=False)  
    alamat = db.Column(db.Text, nullable=True)  
    no_hp = db.Column(db.String(15), nullable=True)  
    jabatan = db.Column(db.String(100), nullable=True) 
    spesialisasi = db.Column(db.String(100)) 
    
    detailobat = db.relationship('DetailObat', overlaps='pegawai')
    dokter = db.relationship('Dokter', back_populates='pegawai', uselist=False)
    pendaftaran = db.relationship('Pendaftaran', back_populates='pegawai')


    def __init__(self, id_pegawai, nama, alamat, no_hp, jabatan, spesialisasi):
        self.id_pegawai = id_pegawai 
        self.nama = nama
        self.alamat = alamat
        self.no_hp = no_hp
        self.jabatan = jabatan
        self.spesialisasi = spesialisasi


class Suplier(db.Model):
    __tablename__ = 'suplier'
    
    id = db.Column(db.Integer, primary_key=True)
    perusahaan = db.Column(db.String(200))
    kontak = db.Column(db.String(100))
    alamat = db.Column(db.Text)
    supliernya = db.relationship('Obat', backref=db.backref('suplier', lazy=True))

    def __init__(self, perusahaan, kontak, alamat):
        self.perusahaan = perusahaan
        self.kontak = kontak
        self.alamat = alamat

class Pendaftaran(db.Model):
    __tablename__ = 'pendaftaran'
    
    id_daftar = db.Column(db.String(10), primary_key=True)
    nama = db.Column(db.String(150))
    tl = db.Column(db.String(100))
    tg_lahir = db.Column(db.String(100))
    jk = db.Column(db.String(100))
    status = db.Column(db.String(100))
    profesi = db.Column(db.String(100))
    alamat = db.Column(db.Text)
    keterangan = db.Column(db.String(50))

   
    id_pegawai = db.Column(db.String(10), db.ForeignKey('pegawai.id_pegawai'))
    

    pegawai = db.relationship('Pegawai', back_populates='pendaftaran')
    pasien = db.relationship('Pasien', back_populates='pendaftaran')
    pembayaran = db.relationship('Pembayaran', back_populates='pendaftaran')
    detail_obats = db.relationship('DetailObat', back_populates="pendaftaran")
    biaya_obats = db.relationship('BiayaObat', back_populates="pendaftaran")


    def __init__(self, id_daftar, nama, tl, tg_lahir, jk, status, profesi, alamat, id_pegawai, keterangan):
        self.id_daftar = id_daftar
        self.nama = nama
        self.tl = tl
        self.tg_lahir = tg_lahir
        self.jk = jk
        self.status = status
        self.profesi = profesi
        self.alamat = alamat
        self.id_pegawai = id_pegawai
        self.keterangan = keterangan

class Pasien(db.Model):
    __tablename__ = 'pasien'
    
    id = db.Column(db.BigInteger, primary_key=True)
    nama = db.Column(db.String(150))
    keluhan = db.Column(db.Text)
    diagnosa = db.Column(db.String(100))
    resep = db.Column(db.Text)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    pendaftaran_id = db.Column(db.String(10), db.ForeignKey('pendaftaran.id_daftar'))
    tanggal = db.Column(db.String(100))

    
    pendaftaran = db.relationship('Pendaftaran', back_populates='pasien')
    user = db.relationship('User', back_populates='pasiens')  

    def __init__(self, nama, keluhan, diagnosa, resep, user_id, pendaftaran_id, tanggal):
        self.nama = nama
        self.keluhan = keluhan
        self.diagnosa = diagnosa
        self.resep = resep
        self.user_id = user_id
        self.pendaftaran_id = pendaftaran_id
        self.tanggal = tanggal
 

class BiayaPendaftaran(db.Model):
    __tablename__ = 'biayapendaftaran'
    id = db.Column(db.Integer, primary_key=True)
    nama = db.Column(db.String(100), nullable=False)
    biaya = db.Column(db.Float, nullable=False)  

    def __init__(self, nama, biaya):
        self.nama = nama
        self.biaya = biaya

class BiayaAdministrasi(db.Model):
    __tablename__ = 'biayaadministrasi'
    id = db.Column(db.Integer, primary_key=True)
    nama = db.Column(db.String(100), nullable=False)
    biaya = db.Column(db.Float, nullable=False)  

    pembayaran = db.relationship('Pembayaran', back_populates='biaya_admin_ref')

    def __init__(self, nama, biaya):
        self.nama = nama
        self.biaya = biaya

class Pembayaran(db.Model):
    __tablename__ = 'pembayaran'

    id_bmedis = db.Column(db.String(10), primary_key=True)
    id_daftar = db.Column(db.String(10), db.ForeignKey('pendaftaran.id_daftar'))
    tanggal_bayar = db.Column(db.Date, nullable=False)
    admin_id= db.Column(db.Integer, db.ForeignKey('biayaadministrasi.id'))   
    dokter_id = db.Column(db.Integer, db.ForeignKey('dokter.id'))
    total_bayar = db.Column(db.Numeric(10, 2), nullable=False, default=0)

    
    pendaftaran = db.relationship('Pendaftaran', back_populates='pembayaran')

    
    biaya_admin_ref = db.relationship('BiayaAdministrasi', back_populates='pembayaran')
    jasa_dokter_ref = db.relationship('Dokter', back_populates='pembayaran')

    def __init__(self, id_bmedis, id_daftar, tanggal_bayar, admin_id, dokter_id, total_bayar=0):
        self.id_bmedis = id_bmedis
        self.id_daftar = id_daftar
        self.tanggal_bayar = tanggal_bayar
        self.admin_id = admin_id
        self.dokter_id = dokter_id
        self.total_bayar = total_bayar



class Obat(db.Model):
    __tablename__ = 'obat'
    
    id = db.Column(db.Integer, primary_key=True)
    namaObat = db.Column(db.String(150))
    jenisObat = db.Column(db.String(150))
    harga_beli = db.Column(db.Integer)
    harga_jual = db.Column(db.Integer)
    kondisi = db.Column(db.String(80))
    suplier_id = db.Column(db.Integer, db.ForeignKey('suplier.id'))

    detailobat = db.relationship("DetailObat", back_populates="obat", overlaps="detailobat")
    
    def __init__(self, namaObat, jenisObat, harga_beli, harga_jual, kondisi, suplier_id):
        self.namaObat = namaObat
        self.jenisObat = jenisObat
        self.harga_beli = harga_beli
        self.harga_jual = harga_jual
        self.kondisi = kondisi
        self.suplier_id = suplier_id


class DetailObat(db.Model):
    __tablename__ = 'detailobat'
    id_dobt = db.Column(db.String(10), primary_key=True)
    daftar_id = db.Column(db.String(10), db.ForeignKey('pendaftaran.id_daftar'))
    id_obat = db.Column(db.Integer, db.ForeignKey('obat.id'))
    qty = db.Column(db.Integer, nullable=False)
    harga = db.Column(db.Float, nullable=False)
    total = db.Column(db.Float, nullable=False, default=0.0)
    tanggal_resep = db.Column(db.Date, nullable=False)
    pegawai_id = db.Column(db.String(10), db.ForeignKey('pegawai.id_pegawai')) 

    pendaftaran = db.relationship('Pendaftaran', back_populates="detail_obats")
    obat = db.relationship('Obat', backref='detail_obat')
    pegawai = db.relationship('Pegawai', backref='detail_obat')

    def __init__(self, id_dobt, daftar_id, id_obat, qty, harga, total, tanggal_resep, pegawai_id):
        self.id_dobt = id_dobt
        self.daftar_id = daftar_id
        self.id_obat = id_obat
        self.qty = qty
        self.harga = harga
        self.total = total
        self.tanggal_resep = tanggal_resep
        self.pegawai_id = pegawai_id

class BiayaObat(db.Model):
    __tablename__ = 'biaya_obat'

    id_bobt = db.Column(db.String(10), primary_key=True)
    daftar_id = db.Column(db.String(10), db.ForeignKey('pendaftaran.id_daftar'))
    total_bayar = db.Column(db.Numeric(10, 2), nullable=False, default=0)
    metode_bayar = db.Column(db.String(20), nullable=False)

    pendaftaran = db.relationship('Pendaftaran', back_populates="biaya_obats")
    
    def __init__(self, id_bobt, daftar_id, total_bayar, metode_bayar):
        self.id_bobt = id_bobt
        self.daftar_id = daftar_id
        self.total_bayar = total_bayar
        self.metode_bayar = metode_bayar


with app.app_context():
    db.create_all()
