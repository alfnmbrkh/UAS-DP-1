program penjadwalankegiatan; //deklarasi awal program dengan nama 'penjadwalankegiatan'

uses crt;

type
    Jadwal = record //mendefinisikan tipe data 'Jadwal' untuk menyimpan informasi setiap kegiatan
        nmkgtn: string; //nama kegiatan
        wktmulai: string; //waktu mulai kegiatan (format hh:mm)
        wktselesai: string; //waktu selesai kegiatan (format hh:mm)
        drs: integer; //durasi kegiatan dalam menit
    end;

var
    kegiatan: array[1..10] of Jadwal; //mendeklarasikan array 'kegiatan' untuk menyimpan hingga 10 jadwal kegiatan
    jmlhkgtn: integer; //variabel untuk melacak jumlah kegiatan yang telah ditambahkan

function waktukemenit(waktu: string): integer; //fungsi untuk mengonversi waktu dalam format 'hh:mm' menjadi total menit
var
    jam, menit: integer;
begin
    val(copy(waktu, 1, 2), jam); //mengambil dua karakter pertama (jam)
    val(copy(waktu, 4, 2), menit); //mengambil dua karakter setelah titik dua (menit)
    waktukemenit := (jam * 60) + menit; //menghitung total menit
end;

procedure tambahkegiatan; //prosedur untuk menambahkan jadwal kegiatan baru
var
    nama, mulai, selesai: string; //variabel sementara untuk menyimpan input data
    mulaimenit, selesaimenit: integer; //variabel sementara untuk menyimpan input data
begin
    if jmlhkgtn < 10 then //mengecek apakah masih ada ruang untuk menambah kegiatan (maksimal 10 kegiatan) 
    begin
        writeln('--- Tambah Kegiatan ---');
        write('Nama Kegiatan: '); readln(nama); //meminta input nama kegiatan
        write('Waktu Mulai (hh:mm): '); readln(mulai); //meminta input waktu mulai
        write('Waktu Selesai (hh:mm): '); readln(selesai); //meminta input waktu selesai

        //menghitung waktu mulai dan selesai dalam menit
        mulaimenit := waktukemenit(mulai);
        selesaimenit := waktukemenit(selesai);

        if selesaimenit > mulaimenit then //memeriksa apakah waktu selesai lebih besar daripada waktu mulai
        begin
            inc(jmlhkgtn); //menambah jumlah kegiatan yang sudah terdaftar
            with kegiatan[jmlhkgtn] do
            begin
                nmkgtn := nama; //menyimpan nama kegiatan
                wktmulai := mulai; //menyimpan waktu mulai
                wktselesai := selesai; //menyimpan waktu selesai
                drs := selesaimenit - mulaimenit; //menghitung durasi kegiatan dalam menit
            end;
            writeln('Kegiatan berhasil ditambahkan!');
        end
        else
            writeln('Waktu selesai harus lebih besar dari waktu mulai!'); //peringatan jika waktu selesai lebih kecil dari waktu mulai
    end
    else
        writeln('Data kegiatan penuh!'); //peringatan jika jumlah kegiatan sudah mencapai batas maksimum
end;

procedure tampilkanjadwal; //prosedur untuk menampilkan semua jadwal kegiatan yang telah ditambahkan
var
    i: integer; //variabel loop untuk iterasi
begin
    if jmlhkgtn = 0 then //memeriksa apakah belum ada jadwal yang ditambahkan
        writeln('Belum ada jadwal kegiatan.')
    else
    begin
        writeln('--- Daftar Jadwal Kegiatan ---');
        for i := 1 to jmlhkgtn do 
        begin
            with kegiatan[i] do //menampilkan semua jadwal yang telah ditambahkan
            begin
                writeln(i, '. ', nmkgtn, ' | Mulai: ', wktmulai, ' | Selesai: ', wktselesai, ' | Durasi: ', drs, ' menit');
            end;
        end;
    end;
end;

function hitungtotaldurasi: integer; //fungsi untuk menghitung total durasi semua kegiatan
var
    i, total: integer; //variabel untuk iterasi dan menghitung total
begin
    total := 0; //inisialisasi total durasi
    for i := 1 to jmlhkgtn do //menjumlahkan durasi semua kegiatan
        total := total + kegiatan[i].drs; //menambahkan durasi kegiatan ke total
    hitungtotaldurasi := total; //mengembalikan total durasi kegiatan
end;

var
    pilihan: integer; //variabel untuk menyimpan pilihan menu
begin
    clrscr; //membersihkan layar
    jmlhkgtn := 0; //menginisialisasi jumlah kegiatan menjadi 0

    repeat
        writeln('=== Program Penjadwalan Kegiatan ==='); //menampilkan menu utama program kepada pengguna dalam loop
        writeln('1. Tambah Kegiatan');
        writeln('2. Tampilkan Jadwal');
        writeln('3. Hitung Total Durasi');
        writeln('4. Keluar');
        write('Pilihan Anda: '); readln(pilihan); //meminta input pilihan dari pengguna

        case pilihan of //menjalankan prosedur/fungsi berdasarkan pilihan pengguna
            1: tambahkegiatan; //menambah kegiatan
            2: tampilkanjadwal; //menampilkan daftar kegiatan
            3: writeln('Total Durasi Semua Kegiatan: ', hitungtotaldurasi, ' menit'); //menampilkan total durasi
            4: writeln('Keluar dari program...'); //keluar dari program
        else
            writeln('Pilihan tidak valid!'); //menampilkan pesan jika pilihan tidak valid
        end;

        writeln; //menambah baris kosong setelah setiap aksi
    until pilihan = 4; //mengulang menu sampai pengguna memilih keluar
end.
