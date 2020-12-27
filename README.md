# Internship-6-Rent-a-Car-Database
DUMP Internship homework task for advanced SQL lesson.

Zadatak:
Modelirati i implementirati strukturu relacijske baze podataka koja služi rent-a-car firmi za realizaciju poslovanja. Rent-a-car ima samo jednu poslovnicu (drugim riječima, NE raditi entitet poslovnice).
Rent-a-car ima vozila, od kojih je svako definirano raznim parametrima od kojih su najbitniji: marka (Suzuki), model (Swift), registracija, boja, vrsta vozila (auto, skuter, kombi…), kilometraža... Svako vozilo ima spremljeno kad je registrirano svake godine, te naravno dokad vrijedi trenutna registracija.
Zaposlenici rent-a-car-a iznajmljuju vozila kupcima. Svaki najam ima određeno trajanje koje je zaokruženo na pola dana, a najam je najmanje 1 cijeli dan (dakle, trajanje najma može bit 1 dan, 1.5 dan, 2 dana, 2.5 dana, 3 dana...).
Cijena najma se određuje u odnosu na više parametara. Prvo, slična vozila imaju istu cijenu po danu najma (pogledajte malo rent-a-car stranice ako vam nije jasno, tipa Chevrolet Spark i VW Up će imat istu cijenu jer su isti tip osobnog vozila, auto manjih dimenzija. Dakle definirajte neki parametar koji će govorit u koju ‘klasu’ vozila spada određeno vozilo, pa da se zna koja cijena se primjenjuje). Drugo, rent-a-car voli pljačkat ljude pa ima definirane zimske i ljetne tarife cijena, tako da su ljetne skuplje. Zimska tarifa se primjenjuje od 1.10. do 1.3. u godini (1.10. i 1.3. se ne ubrajaju u interval), a ljetna se primjenjuje od 1.3. do 1.10. u godini (1.3. i 1.10. se ubrajaju u interval).
Svaki najam ima uz sebe zapisane i podatke o kupcu. Sustav ne pamti kupca kao takvog jer nema nikakvog loyalty programa, bitno je da se na razini najma znaju iduće informacije o kupcu: ime, prezime, OIB, datum rođenja, broj vozačke, broj kreditne kartice iskorištene za najam.
Rent-a-car ne izdaje račune preko softvera pa stoga nema potrebe za generiranjem istih, zapis o najmu se može smatrati dokazom najma. Ono što ćemo morat napravit je pružit mogućnost izračuna cijene najma na temelju kojeg će zaposlenik na zasebnom uređaju koji nije dio ovog taska izdati račun.
Nakon implementacije strukture baze, ubaciti određenu količinu testnih podataka, neka bude bar 5 zaposlenika, 20 najmova, 20 vozila i bar po jedna registracija po vozilu, definirana i zimska i ljetna tarifa za svaku kategoriju vozila.

Napisati SQL upite koji će napraviti iduće:
 - Dohvatiti sva vozila kojima je istekla registracija
 - Dohvatiti sva vozila kojima registracija ističe unutar idućih mjesec dana
 - Dohvatiti koliko vozila postoji po vrsti
 - Dohvatiti zadnjih 5 najmova koje je ostvario neki zaposlenik
 - Izračunati ukupnu cijenu najma za određeni najam (hint: pripaziti na najmove koji imaju miješanu zimsku i ljetnu tarifu tijekom trajanja)
 - Dohvatiti sve kupce najmova ikad, s tim da se ne ponavljaju u rezultatima
 - Dohvatiti za svakog zaposlenika timestamp zadnjeg najma kojeg je ostvario
 - Dohvatiti broj vozila svake marke koji rent-a-car ima
 - Arhivirati sve najmove koji su završili u novu tablicu. Osim već postojećih podataka u najmu, arhivirana tablica će sadržavati i podatak koliko je taj najam koštao.
 - Pobrojati koliko je najmova bilo po mjesecu, u svakom mjesecu 2020. godine.
 - Za sva vozila određene vrste, osim informaciju o vozilu, ispisati tekstualnu informaciju treba li registrirati vozilo unutar idućih mjesec dana (‘Treba registraciju’, ‘Ne treba registraciju’)
 - Dohvatiti broj najmova po vrsti vozila čija duljina najma (razdoblje) prelazi prosječnu duljinu najma