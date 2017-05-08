/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Copyright (c) 2017 Kelompok 7 C2 Teknik Informatika 2015
	
Project : Sistem Pakar Mendeteksi Gejala Depresi
Matakuliah : Kecerdasan Buatan
Purpose	: Sebagai pendeteksi dini gejala-gejala seseorang mengalami depresi.

Written by :
Kelompok 7 C2 Teknik Informatika 2015 FKTI Unmul
- Hadi Yoga Fachrozi Madjid	(1515015133)
- Muhammad Jodi Saputra		(1515015139)
- Abdul Aziz			(1515015150)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

domains
gejala = symbol
symptom = symbol
pernyataan = string
respons = char
anggota = string*
 
 facts
ya_ya(symptom)
tidak_tidak(symptom)
 
 predicates
nondeterm mulai
nondeterm prompt
nondeterm pernyataan(symptom)
nondeterm ya(pernyataan,symptom)
nondeterm tidak(pernyataan,symptom)
nondeterm deteksi(gejala)
terdeteksi(gejala)
nondeterm penanganan(gejala)
nondeterm statement(pernyataan,symptom,respons)
simpan(symptom,respons)
jawaban(char,char)
kelompok(anggota)
nondeterm pilihan(char)


clauses
 
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ START ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  kelompok([]).
 
 kelompok([H|T]):-
 	write(H),nl,
 	kelompok(T).
 	
 	
 jawaban(Y,Y):-!.
 jawaban(_,_):-fail.


 mulai:-
	write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),nl,
	write("~~~~~~~~~~~~~~~ APLIKASI PENDETEKSIAN ~~~~~~~~~~~~~~"),nl,
 	write("~~~~~~~~~~~~~~~~~~ GEJALA DEPRESI ~~~~~~~~~~~~~~~~~~"),nl,
 	write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),nl,nl,nl,
 	write("Written by :"),nl,
 	write("Untuk menjalankan aplikasi, tekan tombol Y untuk mulai."),nl,
 	write("Input selain tombol Y akan menutup aplikasi ini."),nl,nl,
 	readchar(A), pilihan(A).
 	pilihan(A):-jawaban(A,'y'), prompt.
 	pilihan(A):-jawaban(A,'Y'), prompt.
 	pilihan(_):-
 		write("Input yang dimasukkan bukan huruf Y."),nl,nl,
 		write("Aplikasi akan ditutup. Terima kasih telah menggunakan"),nl,
 		write("Aplikasi Pendeteksi Gejala Depresi."),nl,nl,fail.
 		
 prompt:-
		deteksi(_),!,
		save("deteksi.txt").
 prompt:-
		write("Selamat, anda tidak memiliki gejala mengidap sindrom depresi."),nl.

 ya(_,Symptom):-
 		ya_ya(Symptom),!.
 ya(Pernyataan,Symptom):-
 		not(tidak_tidak(Symptom)),
		statement(Pernyataan,Symptom,Respons),
		Respons='y'.
		
 tidak(_,Symptom):-
 		tidak_tidak(Symptom),!.
 tidak(Pernyataan,Symptom):-
 		not(ya_ya(Symptom)),
 		statement(Pernyataan,Symptom,Respons),
 		Respons='t'.
 
 statement(Pernyataan,Symptom,Respons):-
 		write(Pernyataan),
 		readchar(Respons),
 		write(Respons),nl,
 		simpan(Symptom,Respons).
 
 simpan(Symptom,'y'):-
 		asserta(ya_ya(Symptom)).
 simpan(Symptom,'t'):-
 		asserta(tidak_tidak(Symptom)).

	
	
/* ~~~~~ SET LIST OF QUESTIONS ASKED ~~~~ */
 
 pernyataan(Symptom):-
 		ya_ya(Symptom),!.
 pernyataan(Symptom):-
 		tidak_tidak(Symptom),!,fail.
 		
 pernyataan(set1_1):-
 		ya("Saya merasa tidak berharga.",set1_1).
 pernyataan(set1_2):-
 		ya("Saya merasa lelah bahkan setelah istirahat yang cukup.",set1_2).
 pernyataan(set1_3):-
 		ya("Saya merasa hampa secara terus-menerus.",set1_3).
 pernyataan(set1_4):-
 		ya("Saya selalu terpikir tentang mengakhiri hidup saya.",set1_4).
 pernyataan(set1_5):-
 		ya("Masalah-masalah dalam hidup saya cenderung semakin bertambah, mengarah ke kondisi depresi karena saya merasa saya tidak dapat mengendalikan apakah suatu masalah telah terselesaikan dengan baik.",set1_5).
 
 pernyataan(set2_1):-
 		ya("Saya merasa bahwa saya hanya bisa menjadi beban bagi orang-orang di sekitar saya.",set2_1).
 pernyataan(set2_2):-
 		ya("Saya merasa ingin menangis tanpa ada alasan yang jelas.",set2_2).
 pernyataan(set2_3):-
 		ya("Saya terus berpikir tentang bagaimana hal-hal yang berlangsung dalam kehidupan saya tiap malam.",set2_3).
 pernyataan(set2_4):-
 		ya("Saya merasa tidak dapat memulai tugas atau proyek penting yang harus saya kerjakan.",set2_4).
 		
 pernyataan(set3_1):-
 		ya("Saya mengacaukan apa saja yang saya sentuh.",set3_1).
 pernyataan(set3_2):-
 		ya("Mengambil keputusan terasa seperti siksaan bagi saya.",set3_2).
 pernyataan(set3_3):-
 		ya("Saya merasa melambat, baik secara mental maupun secara fisik.",set3_3).
 		
 		
/*~~~~~~~ DETEKSI ~~~~~~~~*/
 deteksi("Severe Depression"):-
  		pernyataan(set1_1),
  		pernyataan(set1_2),
  		pernyataan(set1_3),
  		pernyataan(set1_4),
  		pernyataan(set1_5),
  		terdeteksi("Depresi Akut"),
  		penanganan("Hubungi dokter atau psikiater segera untuk pengobatan secara medis dan psikologis.").
  
 deteksi("Moderate Depression"):-
  		pernyataan(set2_1),
  		pernyataan(set2_2),
  		pernyataan(set2_3),
  		pernyataan(set2_4),
  		terdeteksi("Depresi Sedang"),
  		penanganan("Hubungi dokter atau psikiater untuk penanganan lebih lanjut mencegah depresi lanjut ke tingkat akut.").
  
 deteksi("Mild Depression"):-
  		pernyataan(set3_1),
  		pernyataan(set3_2),
  		pernyataan(set3_3),
  		terdeteksi("Depresi Ringan"),
  		penanganan("Ubah gaya hidup, serta hubungi dokter psikiater untuk penanganan dini dalam rangka mencegah depresi berakumulasi ke tingkat lanjut.").

/* ~~~~~~~~ PENANGANAN LEBIH LANJUT ~~~~~~~ */

 terdeteksi(Gejala):-
 		upper_lower(AGejala, Gejala),nl,
 		write("-)  Anda terdeteksi mengidap : ",AGejala),nl.
 penanganan(Gejala):-
 		upper_lower(AGejala, Gejala),nl,
 		write("-)  Salah satu solusinya adalah : ",AGejala),nl.
 
goal

 kelompok(["Muhammad Jodi Saputra (1515015139)","Abdul Aziz (1515015150)","Hadi Yoga F.M. (1515015133)"]),nl,nl,
 mulai.