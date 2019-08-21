--CREATE/DROP DATABASE, RELACIONI MODEL, LEGENDA
/*
CREATE DATABASE ShopV1_7
*/
/*
USE master	DROP DATABASE ShopV1_7
*/

/* ************** RELACIONI MODEL ****************
KatArt(ID,Naziv)
Grad(ID,Naziv,PTT)
Prodavnica(ID,Naziv,Adresa,GradID,Opis)
Dobavljac(ID,Naziv,Adresa,GradID,PIB,MatBr)
Korisnik(ID,userName,pass,Ime,Prezime,Adresa,GradID,Tel,Email,MB,Autentifikacija)
Artikal(ID,Naziv,KatArtID,Opis,DobavljacID,Cena)
Stanje(ID,ProdavnicaID,ArtikalID,Kolicina)
Fakture(ID,Oznaka,KorisnikID,ArtikalID,Kolicina,Iznos,Datum,ProdavnicaID,Napomena)
LogStanja(ID,KorisnikID,ArtikalID,StanjePre,Izmena,StanjePosle,Racun,StavkaID,Datum,ProdavnicaID)

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓LEGENDA▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--/ - Blok naredbi od tekuće tabele
--▓ - Kreiranje i postavljanje FK
--  - Svako naredno postavljanje FK

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/
USE ShopV1_7
/*
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓CREATE▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/
/* ////////////////KatArt//////////////////////////// */
CREATE TABLE KatArt(
ID INT IDENTITY(1,1),
Naziv nvarchar(30) NOT NULL,
CONSTRAINT PK_KatArtID PRIMARY KEY (ID))		--/ PK: KatArtID		--/ CREATE: KatArt
/* ////////////////Grad//////////////////////////// */
CREATE TABLE Grad(
ID INT IDENTITY(1,1),
Tekst nvarchar(50),
Naziv nvarchar(50),
PTT varchar(10),
CONSTRAINT PK_GradID PRIMARY KEY (ID))			--/ PK: GradID			--/ CREATE: Grad
/* //////////////////Prodavnica////////////////////////// */
CREATE TABLE Prodavnica(
ID INT IDENTITY(1,1),
Naziv nvarchar(20) NOT NULL,
Adresa nvarchar(50) NOT NULL,
GradID INT NOT NULL,
Opis nvarchar(200) NOT NULL,
CONSTRAINT PK_ProdavnicaID PRIMARY KEY (ID),	
CONSTRAINT FK_GradID FOREIGN KEY (GradID) REFERENCES Grad(ID))	--/ PK: ProdavnicaID	--▓FK: GradID		--/ CREATE: Prodavnica
/* ///////////////////Dobavljac///////////////////////// */
CREATE TABLE Dobavljac(
ID INT IDENTITY(1,1),
Naziv nvarchar(20) NOT NULL,
Adresa nvarchar(50) NOT NULL,
GradID INT NOT NULL,
PIB varchar(15) NOT NULL,
MatBr varchar(15) NOT NULL,
CONSTRAINT PK_DobavljacID PRIMARY KEY (ID),
FOREIGN KEY (GradID) REFERENCES Grad(ID))	--/ PK: DobavljacID		-- FK: GradID		--/ CREATE: Dobavljac	
/* ////////////////////// Korisnik ////////////////////// */
CREATE TABLE Korisnik(
ID INT IDENTITY(1,1),
userName varchar(30) UNIQUE NOT NULL,
pass varchar(30) MASKED WITH (FUNCTION = 'default()') NOT NULL,
Ime nvarchar(30) NOT NULL,
Prezime nvarchar(30) NOT NULL,
Adresa nvarchar(50) NOT NULL,
GradID INT NOT NULL,
Tel varchar(50) NOT NULL,
Email varchar(50) NOT NULL,
MB varchar(20) NOT NULL,
Autentifikacija varchar(1) NOT NULL,
CONSTRAINT PK_KorisnikID PRIMARY KEY (ID),			
FOREIGN KEY (GradID) REFERENCES Grad(ID))	--/ PK: KorisnikID		-- FK: GradID		--/ CREATE: Korisnik
/* //////////////////////Artikal////////////////////// */
CREATE TABLE Artikal(
ID INT IDENTITY(1,1),
Naziv nvarchar(150) NOT NULL,
KatArtID INT NOT NULL,
Opis nvarchar(2000) NOT NULL,
DobavljacID INT NOT NULL,
Cena INT NOT NULL,
CONSTRAINT PK_ArtikalID PRIMARY KEY (ID),			
CONSTRAINT FK_KatArtID FOREIGN KEY (KatArtID) REFERENCES KatArt(ID),			
CONSTRAINT FK_DobavljacID FOREIGN KEY (DobavljacID) REFERENCES Dobavljac(ID))	--/ PK: ArtikalID		--▓FK: KatArtID		--▓FK: DobavljacID	--/ CREATE: Artikal
/* ////////////////////// Stanje ////////////////////// */
CREATE TABLE Stanje(
ID INT IDENTITY(1,1),
ProdavnicaID INT NOT NULL,
ArtikalID INT NOT NULL,
Kolicina INT NOT NULL
CONSTRAINT PK_StanjeID PRIMARY KEY (ID),			
CONSTRAINT FK_ProdavnicaID FOREIGN KEY (ProdavnicaID) REFERENCES Prodavnica(ID),			
CONSTRAINT FK_ArtikalID FOREIGN KEY (ArtikalID) REFERENCES Artikal(ID))		--/ PK: StanjeID		--▓FK:ProdavnicaID	--▓FK: ArtikalID	--/ CREATE: Stanje
/* //////////////////////Fakture////////////////////// */
CREATE TABLE Fakture(
ID INT IDENTITY(1,1),
Oznaka varchar(10) NOT NULL,
KorisnikID INT NOT NULL,
ArtikalID INT NOT NULL,
Kolicina INT NOT NULL,
Iznos INT NOT NULL,
Datum date NOT NULL,
ProdavnicaID INT NOT NULL,
Napomena nvarchar(100) NOT NULL,
CONSTRAINT PK_FaktureID PRIMARY KEY (ID),
FOREIGN KEY (KorisnikID) REFERENCES Korisnik(ID),
FOREIGN KEY (ArtikalID) REFERENCES Artikal(ID),	
FOREIGN KEY (ProdavnicaID) REFERENCES Prodavnica(ID))	--/ PK: FaktureID		--▓FK: KorisnikID	-- FK: ProdavnicaID	--/ CREATE: Fakture
/* //////////////////////LogStanja////////////////////// */
CREATE TABLE LogStanja(
ID INT IDENTITY(1,1),
KorisnikID INT NOT NULL,
ArtikalID INT NOT NULL,
StanjePre INT NOT NULL,
Izmena INT NOT NULL,
StanjePosle INT NOT NULL,
Racun  NVARCHAR(20),
Stavka INT NULL,
Datum date NOT NULL,
ProdavnicaID INT NOT NULL,
CONSTRAINT PK_LogStanjaID PRIMARY KEY (ID),
FOREIGN KEY (KorisnikID) REFERENCES Korisnik(ID),
FOREIGN KEY (ArtikalID) REFERENCES Artikal(ID),
CONSTRAINT FK_FaktureID FOREIGN KEY (Stavka) REFERENCES Fakture(ID),
FOREIGN KEY (ProdavnicaID) REFERENCES Prodavnica(ID))	--/ PK: LogStanjaID	-- FK: KorisnikID	-- FK: ArtikalID	--▓FK: FaktureID	-- FK: ProdavnicaID		--/ CREATE: LogStanja
/*

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓INSERT▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/
/* ************** RELACIONI MODEL ****************
KatArt(ID,Naziv)
Grad(ID,Naziv,PTT)
Prodavnica(ID,Naziv,Adresa,GradID,Opis)
Dobavljac(ID,Naziv,Adresa,GradID,PIB,MatBr)
Korisnik(ID,userName,pass,Ime,Prezime,Adresa,GradID,Tel,Email,MB,Autentifikacija)
Artikal(ID,Naziv,KatArtID,Opis,DobavljacID,Cena)
Stanje(ID,ProdavnicaID,ArtikalID,Kolicina)
Fakture(ID,Oznaka,KorisnikID,ArtikalID,Kolicina,Iznos,Datum,ProdavnicaID,Napomena)
LogStanja(ID,KorisnikID,ArtikalID,StanjePre,Izmena,StanjePosle,Racun,StavkaID,Datum,ProdavnicaID)*/

/*▓//////////////// KatArt(ID,Naziv) //////////////////////// */
INSERT INTO KatArt VALUES 
('Apple'),
('Displays'),
('PCConfigurations'),
('PCComponents');			-- KatArt

/*▓//////////////// Grad(ID,Naziv,PTT) ////////////////////// */
INSERT INTO Grad VALUES 
(N'Ada','24430'),(N'Adaševci','22244'),(N'Adorjan','24425'),(N'Adrani','36203'),(N'Aleksinački Rudnik','18226'),(N'Aleksa Šantić','25212'),(N'Aleksandrovac (Kruševački)','37230'),(N'Aleksandrovac (Požarevački)','12370'),(N'Aleksandrovo','23217'),(N'Aleksinac','18220'),(N'Alibunar','26310'),(N'Aljinovici','31307'),(N'Apatin','25260'),(N'Aradac','23207'),(N'Aranđelovac','34300'),(N'Arilje','31230'),(N'Ašanja','22418'),(N'Azanja','11423'),(N'Babin Kal','18315'),(N'Babušnica','18330'),(N'Bač','21420'),(N'Bačevci','31258'),(N'Bačina','37265'),(N'Bačinci','22225'),(N'Bačka Palanka','21400'),(N'Bačka Topola','24300'),(N'Bački Breg','25275'),(N'Bački Brestovac','25242'),(N'Bački Gracac','25252'),(N'Bački Jarak','21234'),(N'Bački Monoštor','25272'),(N'Bački Petrovac','21470'),(N'Bački Sokolac','24343'),(N'Bački Vinogradi','24415'),(N'Bačko Dobro Polje','21465'),(N'Bačko Gradište','21217'),(N'Backo Novo Selo','21429'),(N'Backo Petrovo Selo','21226'),(N'Badnjevac','34226'),(N'Badovinci','15358'),(N'Bagrdan','35204'),(N'Bajina Bašta','31250'),(N'Bajmok','24210'),(N'Bajsa','24331'),(N'Balajinac','18257'),(N'Baljevac Na Ibru','36344'),(N'Banatska Palanka','26324'),(N'Banatsko Aranđelovo','23332'),(N'Banatski Brestovac','26234'),(N'Banatski Despotovac','23242'),(N'Banatsko Karađorđevo','23216'),(N'Banatsko Novo Selo','26314'),(N'Banatska Subotica','26327'),(N'Banatsko Visnjicevo','23237'),(N'Banatska Dubica','23251'),(N'Banatska Topola','23315'),(N'Banatski Dvor','23213'),(N'Banatski Karlovac','26320'),(N'Banatsko Veliko Selo','23312'),(N'Banicina','11424'),(N'Banja','34304'),(N'Banja Kod Priboja','31337'),(N'Banja Koviljaca','15316'),(N'Banjani','14214'),(N'Banjska','38216'),(N'Banostor','21312'),(N'Banovci Dunav','22303'),(N'Banovo Polje','15362'),(N'Barajevo','11460'),(N'Baranda','26205'),(N'Barbatovac','18426'),(N'Bare','34205'),(N'Baric','11504'),(N'Barice','26367'),(N'Barlovo','18432'),(N'Barosevac','11565'),(N'Basaid','23316'),(N'Batocina','34227'),(N'Batrovci','22251'),(N'Bavaniste','26222'),(N'Bečej','21220'),(N'Becmen','11279'),(N'Begaljica','11308'),(N'Begeč','21411'),(N'Begejci','23232'),(N'Bela Crkva','26340'),(N'Bela Crkva (kod Krupnja)','15313'),(N'Bela Palanka','18310'),(N'Bela Voda','37253'),(N'Bela Zemlja','31311'),(N'Belanovica','14246'),(N'Bele Vode','32259'),(N'Belegiš','22306'),(N'Beli Potok','11223'),(N'Beli Potok (kod Svrljiga)','19366'),(N'Beljina','11461'),(N'Belo Blato','23205'),(N'Beloljin','18424'),(N'Belosavci','34312'),(N'Belotinac','18411'),(N'Belusic','35263'),(N'Beocin','21300'),(N'Beograd','11000'),(N'Berkasovo','22242'),(N'Beršići','32305'),(N'Besenovo','22212'),(N'Beška','22324'),(N'Bezdan','25270'),(N'Bigrenica','35238'),(N'Bikic Do','22254'),(N'Bikovo','24206'),(N'Biljaca','17522'),(N'Bingula','22253'),(N'Bioska','31241'),(N'Bistar','17546'),(N'Bistrica','31325'),(N'Blace','18420'),(N'Blazevo','37226'),(N'Bobovo','35217'),(N'Bocar','23274'),(N'Bođani','21427'),(N'Bogaraš','24408'),(N'Bogatić','15350'),(N'Bogojevo','25245'),(N'Bogovađa','14225'),(N'Bogovina','19372'),(N'Bogutovac','36341'),(N'Bojnik','16205'),(N'Boka','23252'),(N'Boleč','11307'),(N'Boljevac','19370'),(N'Boljevci','11275'),(N'Boljkovci','32312'),(N'Bor','19210'),(N'Borča','11211'),(N'Borski Brestovac','19229'),(N'Borsko Bucje','19231'),(N'Bosilegrad','17540'),(N'Bošnjace','16232'),(N'Bošnjane','37262'),(N'Bosut','22217'),(N'Botoš','23243'),(N'Božetići','31322'),(N'Boževac','12313'),(N'Božica','17537'),(N'Braćevac','19315'),(N'Bradarac','12206'),(N'Braničevo','12222'),(N'Brankovina','14201'),(N'Bratinac','12225'),(N'Bratljevo','32256'),(N'Brđani','32303'),(N'Brekovo','31234'),(N'Bresnica','32213'),(N'Brestac','22415'),(N'Brestovacka Banja','19216'),(N'Brestovac','16253'),(N'Brezane','12205'),(N'Brezde','14244'),(N'Brezjak','15309'),(N'Brezna','32307'),(N'Brezova','32253'),(N'Brezovica','38157'),(N'Brgule','14212'),(N'Brnjica','12230'),(N'Brodarevo','31305'),(N'Brus','37220'),(N'Brusnik','19313'),(N'Brvenik','36346'),(N'Brza Palanka','19323'),(N'Brzan','34228'),(N'Brzeće','37225'),(N'Bučje','19369'),(N'Buđanovci','22421'),(N'Budisava','21242'),(N'Bujanovac','17520'),(N'Bukovac','21209'),(N'Bukovica','32251'),(N'Bukovik','34301'),(N'Bukurovac','34217'),(N'Bumbarevo Brdo','34242'),(N'Bunar','35273'),(N'Burdimo','18368'),(N'Burovac','12307'),(N'Busilovac','35249'),(N'Cerovac','15224'),(N'Crepaja','26213'),(N'Crkvine','36321'),(N'Crna Bara','23328'),(N'Crna Bara','15355'),(N'Crna Trava','16215'),(N'Crnoklište','18304'),(N'Crvena Crkva','26323'),(N'Crvena Reka','18313'),(N'Crvenka','25220'),(N'Čačak','32000'),(N'Čajetina','31310'),(N'Čalma','22231'),(N'Čantavir','24220'),(N'Čecina','18417'),(N'Čelarevo','21413'),(N'Čenej','21233'),(N'Čenta','23266'),(N'Čerević','21311'),(N'Čestereg','23215'),(N'Čitluk (kod Kruševca)','37208'),(N'Čitluk (kod Soko Banje)','18232'),(N'Čoka','23320'),(N'Čonoplja','25210'),(N'Čortanovci','22326'),(N'Čurug','21238'),(N'Čukojevac','36220'),(N'Čumić','34322'),(N'Ćićevac','37210'),(N'Ćuprija','35230'),(N'Darosava','34305'),(N'Dasnica','37271'),(N'Debeljača','26214'),(N'Debrc','15214'),(N'Deč','22441'),(N'Deliblato','26225'),(N'Delimede','36307'),(N'Deronje','25254'),(N'Desimirovac','34321'),(N'Despotovac','35213'),(N'Despotovo','21468'),(N'Devojački Bunar','26316'),(N'Deževa','36305'),(N'Dimitrovgrad','18320'),(N'Divci','14222'),(N'Divčibare','14204'),(N'Divljaka','31236'),(N'Divoš','22232'),(N'Divostin','34204'),(N'Dobanovci','11272'),(N'Dobra','12224'),(N'Dobri Do','18408'),(N'Dobrić','15235'),(N'Dobrica','26354'),(N'Dobrinci','22412'),(N'Dolac','18314'),(N'Doljevac','18410'),(N'Dolovo','26227'),(N'Donja Bela Reka','19213'),(N'Donja Borina','15317'),(N'Donja Kamenica','19352'),(N'Donja Livadica','11326'),(N'Donja Ljubata','17544'),(N'Donja Mutnica','35255'),(N'Donja Orovica','15323'),(N'Donja Rečica','18404'),(N'Donja Šatornja','34314'),(N'Donja Trnava','18421'),(N'Donje Vidovo','35258'),(N'Donje Crnatovo','18414'),(N'Donje Crniljevo','15227'),(N'Donje Medurovo','18254'),(N'Donje Tlamino','17547'),(N'Donje Zuniče','19345'),(N'Donji Dušnik','18242'),(N'Donji Krčin','37258'),(N'Donji Milanovac','19220'),(N'Donji Stajevac','17526'),(N'Doroslovo','25243'),(N'Dračić','14203'),(N'Draginac','15311'),(N'Draginje','15226'),(N'Draglica','31317'),(N'Dragobraca','34231'),(N'Dragocvet','35272'),(N'Dragoševac','35262'),(N'Dragovo','35265'),(N'Drajkovce','38239'),(N'Draževac','11506'),(N'Draževac (kod Aleksinca)','18223'),(N'Drenovac','15212'),(N'Drenovac (kod Paraćina)','35257'),(N'Drlače','15324'),(N'Drugovac','11432'),(N'Dublje','15359'),(N'Duboka','12255'),(N'Dubovac','26224'),(N'Dubovo','18406'),(N'Dubravica','12207'),(N'Dudovica','11561'),(N'Duga Poljana','36312'),(N'Dugo Polje','18237'),(N'Dušanovac','19335'),(N'Dupljaja','26328'),(N'Dvorane','37206'),(N'Džep','17514'),(N'Džigolj','18405'),(N'Đala','23335'),(N'Đeneral Janković','38238'),(N'Đunis','37202'),(N'Đurđevo','21239'),(N'Đurđevo (kod Kragujevca)','34215'),(N'Đurđin','24213'),(N'Ečka','23203'),(N'Elemir','23208'),(N'Erdeč','34207'),(N'Erdevik','22230'),(N'Farkaždin','23264'),(N'Feketić','24323'),(N'Futog','21410'),(N'Gadžin Han','18240'),(N'Gaj','26223'),(N'Gajdobra','21432'),(N'Gakovo','25282'),(N'Gamzigradska Banja','19228'),(N'Gardinovci','21247'),(N'Gibarac','22258'),(N'Glavinci','35261'),(N'Globoder','37251'),(N'Glogonj','26202'),(N'Glogovac','35222'),(N'Gložan','21412'),(N'Glušci','15356'),(N'Golobok','11316'),(N'Golubac','12223'),(N'Golubinci','22308'),(N'Goračići','32232'),(N'Goričani','32225'),(N'Gornja Dobrinja','31214'),(N'Gornja Draguša','18425'),(N'Gornja Lisina','17538'),(N'Gornja Sabanta','34206'),(N'Gornja Toplica','14243'),(N'Gornja Toponica','18202'),(N'Gornja Trepča','32215'),(N'Gornji Banjani','32306'),(N'Gornji Barbeš','18241'),(N'Gornji Breg','24406'),(N'Gornji Brestovac','16244'),(N'Gornji Milanovac','32300'),(N'Gornji Matejevac','18204'),(N'Gornji Stepos','37221'),(N'Gornji Stupanj','37234'),(N'Gospođinci','21237'),(N'Gostilje','31313'),(N'Grabovac','11508'),(N'Grabovci','22423'),(N'Gracanica','38205'),(N'Gradina','18321'),(N'Gradskovo','19205'),(N'Graševci','37229'),(N'Grdelica','16220'),(N'Grebenac','26347'),(N'Gredetin','18213'),(N'Grejač','18219'),(N'Grgurevci','22213'),(N'Grlište','19342'),(N'Grljan','19341'),(N'Grocka','11306'),(N'Grošnica','34202'),(N'Gruža','34230'),(N'Guberevac','34232'),(N'Guča','32230'),(N'Gudurica','26335'),(N'Gunaroš','24312'),(N'Guševac','18208'),(N'Gušterica','38209'),(N'Hajdučica','26370'),(N'Hajdukovo','24414'),(N'Halovo','19236'),(N'Hetin','23235'),(N'Horgoš','24410'),(N'Horgoš Granični Prelaz','24411'),(N'Hrtkovci','22427'),(N'Iđoš','23323'),(N'Idvor','26207'),(N'Ilandža','26352'),(N'Ilićevo','34203'),(N'Ilinci','22250'),(N'Inđija','22320'),(N'Irig','22406'),(N'Iriški Venac','22407'),(N'Ivanjica','32250'),(N'Ivanovo','26233'),(N'Izbište','26343'),(N'Jablanica','31314'),(N'Jabučje','14226'),(N'Jabuka','31306'),(N'Jabukovac','19304'),(N'Jadranska Lešnica','15308'),(N'Jagnjilo','11412'),(N'Jagodina','35000'),(N'Jakovo','11276'),(N'Jamena','22248'),(N'Janošik','26362'),(N'Jarak','22426'),(N'Jarkovac','23250'),(N'Jarmenovci','34318'),(N'Jaša Tomić','23230'),(N'Jasenovo','26346'),(N'Jasenovo (kod Nove Varoši)','31319'),(N'Jasenovo (kod Despotovca)','35241'),(N'Jasika','37252'),(N'Jazak','22409'),(N'Jazovo','23327'),(N'Jelašnica','18206'),(N'Jelašnica','17531'),(N'Jelen Do','31215'),(N'Jelovik','34309'),(N'Jermenovci','26363'),(N'Ježevica','32222'),(N'Ježevica (Užička)','31213'),(N'Jošanica','18234'),(N'Jošanicka Banja','36345'),(N'Jovac','35205'),(N'Jugbogdanovac','18253'),(N'Junkovac','11562'),(N'Kać','21241'),(N'Kačarevo','26212'),(N'Kajtasovo','26329'),(N'Kalna','19353'),(N'Kaluđerske Bare','31257'),(N'Kaluđerica','11130'),(N'Kamenica (kod Čačka)','32206'),(N'Kamenica (kod Dimitrovgrada)','18324'),(N'Kamenica (Valjevska)','14252'),(N'Kanjiža','24420'),(N'Kaona','32234'),(N'Kaonik','37256'),(N'Karađorđevo','21421'),(N'Karan','31204'),(N'Karavukovo','25255'),(N'Karlovčić','22443'),(N'Katun','18225'),(N'Kelebija','24104'),(N'Kelebija Granični Prelaz','24205'),(N'Kevi','24407'),(N'Kikinda','23300'),(N'Kisač','21211'),(N'Kladovo','19320'),(N'Klek','23211'),(N'Klenak','22424'),(N'Klenike','17524'),(N'Klenje','15357'),(N'Klenje (kod Golubca)','12258'),(N'Kličevac','12209'),(N'Klisura','17535'),(N'Kljajićevo','25221'),(N'Klokočevac','19222'),(N'Knić','34240'),(N'Knićanin','23265'),(N'Knjaževac','19350'),(N'Kobišnica','19316'),(N'Koceljeva','15220'),(N'Kokin Brod','31318'),(N'Kolare','35242'),(N'Kolari','11431'),(N'Kolut','25274'),(N'Komirić','14254'),(N'Konak','23253'),(N'Konarevo','36340'),(N'Končarevo','35219'),(N'Konjuh','37254'),(N'Kopaonik','36354'),(N'Koprivnica','19223'),(N'Koračica','11415'),(N'Korbevac','17545'),(N'Korbovo','19329'),(N'Korenita','15302'),(N'Korman','18216'),(N'Korman (Kragujevački)','34224'),(N'Kosovska Mitrovica','38220'),(N'Kosančić','16206'),(N'Kosjerić','31260'),(N'Kosovo Polje','38210'),(N'Kostojevići','31254'),(N'Kostolac','12208'),(N'Kotraža','32235'),(N'Kovačevac','11409'),(N'Kovačica','26210'),(N'Kovilj','21243'),(N'Kovilje','32257'),(N'Kovin','26220'),(N'Kragujevac','34000'),(N'Krajišnik','23231'),(N'Kraljevci','22411'),(N'Kraljevo','36000'),(N'Krčedin','22325'),(N'Kremna','31242'),(N'Krepoljin','12316'),(N'Kriva Feja','17543'),(N'Kriva Reka','37282'),(N'Krivaja','24341'),(N'Krivelj','19219'),(N'Krivi Vir','19375'),(N'Krnješevci','22314'),(N'Krnjevo','11319'),(N'Krupac','18307'),(N'Krupanj','15314'),(N'Krušar','35227'),(N'Kruščić','25225'),(N'Kruščica','31233'),(N'Krušedol','22328'),(N'Kruševac','37000'),(N'Kruševica','18409'),(N'Kučevo','12240'),(N'Kucura','21466'),(N'Kukljin','37255'),(N'Kukujevci','22224'),(N'Kula','25230'),(N'Kulina','18214'),(N'Kulpin','21472'),(N'Kumane','23271'),(N'Kupci','37222'),(N'Kupinik','26368'),(N'Kupinovo','22419'),(N'Kupusina','25262'),(N'Kuršumlija','18430'),(N'Kuršumlijska Banja','18435'),(N'Kusadak','11425'),(N'Kusić','26349'),(N'Kušići','32258'),(N'Kušiljevo','35226'),(N'Kuštilj','26336'),(N'Kuzmin','22223'),(N'Laćarak','22221'),(N'Laćisled','37232'),(N'Lađevci','36204'),(N'Lajkovac','14224'),(N'Lalić','25234'),(N'Lalinac','18201'),(N'Lapovo','34220'),(N'Lapovo Selo','34223'),(N'Lazarevac','11550'),(N'Lazarevo','23241'),(N'Laznica','12321'),(N'Lebane','16230'),(N'Lece','16248'),(N'Ledinci','21207'),(N'Lelić','14205'),(N'Lenovac','19343'),(N'Lepenac','37224'),(N'Lepenica','17513'),(N'Leposavić','38218'),(N'Lesak','38219'),(N'Leskovac','16000'),(N'Lešnica','15307'),(N'Leštane','11309'),(N'Lezimir','22207'),(N'Lički Hanovi','18245'),(N'Lipar','25232'),(N'Lipe','11310'),(N'Lipolist','15305'),(N'Loćika','35274'),(N'Lok','21248'),(N'Lokve','26361'),(N'Lovćenac','24322'),(N'Loznica','15300'),(N'Lozovik','11317'),(N'Lubnica','19208'),(N'Lučani','32240'),(N'Lug','21315'),(N'Lugavčina','11321'),(N'Luka','19234'),(N'Lukare','36306'),(N'Lukićevo','23261'),(N'Lukino Selo','23224'),(N'Lukovo','19371'),(N'Lukovo (kod Kuršumlije)','18437'),(N'Lunovo Selo','31203'),(N'Lužane','18228'),(N'Lužnice','34325'),(N'Ljig','14240'),(N'Ljuba','22255'),(N'Ljuberađa','18217'),(N'Ljubiš','31209'),(N'Ljubovija','15320'),(N'Ljukovo','22321'),(N'Ljutovo','24215'),(N'Mala Moštanica','11261'),(N'Mačkat','31312'),(N'Mačvanska Mitrovica','22202'),(N'Mačvanski Pričinović','15211'),(N'Maglić','21473'),(N'Majdan','23333'),(N'Majdanpek','19250'),(N'Majilovac','12221'),(N'Majur','15353'),(N'Majur (kod Jagodine)','35270'),(N'Mala Bosna','24217'),(N'Mala Krsna','11313'),(N'Mala Plana','18423'),(N'Malča','18207'),(N'Male Pčelice','34216'),(N'Male Pijace','24416'),(N'Mali Beograd','24309'),(N'Mali Iđoš','24321'),(N'Mali Izvor','19347'),(N'Mali Jasenovac','19209'),(N'Mali Požarevac','11235'),(N'Mali Zvornik','15318'),(N'Malo Crniće','12311'),(N'Malo Krčmare','34212'),(N'Malošište','18415'),(N'Manđelos','22208'),(N'Manojlovce','16201'),(N'Maradik','22327'),(N'Margita','26364'),(N'Markovac','11325'),(N'Markovica','32243'),(N'Maršić','34209'),(N'Martinci','22222'),(N'Martonoš','24417'),(N'Mataruška Banja','36201'),(N'Međa','23234'),(N'Medoševac','18209'),(N'Međurečje','32255'),(N'Medveđa','16240'),(N'Medveđa (kod Despotovca)','35224'),(N'Medveđa (kod Trstenika)','37244'),(N'Melenci','23270'),(N'Meljak','11426'),(N'Melnica','12305');
INSERT INTO Grad VALUES 
(N'Merćez','18436'),(N'Merdare','18445'),(N'Merošina','18252'),(N'Metlić','15233'),(N'Metovnica','19204'),(N'Mihajlovac (kod Smedereva)','11312'),(N'Mihajlovac (Krajinski)','19322'),(N'Mihajlovo','23202'),(N'Mijatovac','35236'),(N'Milentija','37227'),(N'Mileševo','21227'),(N'Miletićevo','26373'),(N'Miloševac','11318'),(N'Miloševo','35268'),(N'Milutovac','37246'),(N'Minićevo','19340'),(N'Mionica','14242'),(N'Mirosaljci','11567'),(N'Miroševce','16204'),(N'Mišićevo','24211'),(N'Mitrovac','31251'),(N'Mladenovac','11400'),(N'Mladenovo','21422'),(N'Mojsinje','32211'),(N'Mokra Gora','31243'),(N'Mokranja','19317'),(N'Mokrin','23305'),(N'Mol','24435'),(N'Molovin','22256'),(N'Morović','22245'),(N'Mošorin','21245'),(N'Mozgovo','18229'),(N'Mramor','18251'),(N'Mramorak','26226'),(N'Mrčajevci','32210'),(N'Muhovac','17529'),(N'Mužlja','23206'),(N'Nadalj','21216'),(N'Nakovo','23311'),(N'Natalinci','34313'),(N'Negotin','19300'),(N'Neresnica','12242'),(N'Neštin','21314'),(N'Neuzina','23245'),(N'Nikinci','22422'),(N'Nikolićevo','19311'),(N'Nikolinci','26322'),(N'Niš','18000'),(N'Niševac','18366'),(N'Niška Banja','18205'),(N'Noćaj','22203'),(N'Nova Crnja','23218'),(N'Nova Crvenka','25224'),(N'Nova Gajdobra','21431'),(N'Nova Pazova','22330'),(N'Nova Varoš','31320'),(N'Novi Banovci','22304'),(N'Novi Bečej','23272'),(N'Novi Itebej','23236'),(N'Novi Karlovci','22322'),(N'Novi Kneževac','23330'),(N'Novi Kozarci','23313'),(N'Novi Kozjak','26353'),(N'Novi Pazar','36300'),(N'Novi Sad','21000'),(N'Novi Slankamen','22323'),(N'Novi Žednik','24223'),(N'Novo Lanište','35271'),(N'Novo Miloševo','23273'),(N'Novo Orahovo','24351'),(N'Novo Selo','18250'),(N'Njegoševo','24311'),(N'Obrenovac','11500'),(N'Obrež','37266'),(N'Obrež (Srem)','22417'),(N'Obrovac','21423'),(N'Odžaci','25250'),(N'Ogar','22416'),(N'Omoljica','26230'),(N'Oparić','35267'),(N'Opovo','26204'),(N'Orane','16233'),(N'Oraovica','17557'),(N'Orašac','34308'),(N'Orešković','24344'),(N'Oreškovica','12308'),(N'Orid','15213'),(N'Orlovat','23263'),(N'Orom','24207'),(N'Osaonica','12317'),(N'Osečina','14253'),(N'Osipaonica','11314'),(N'Osnić','19378'),(N'Ostojićevo','23326'),(N'Ostrovica','18312'),(N'Ostružnica','11251'),(N'Ovča','11212'),(N'Ovčar Banja','32242'),(N'Pačir','24342'),(N'Padinska Skela','11213'),(N'Padej','23325'),(N'Padež','37257'),(N'Padina','26215'),(N'Palić','24413'),(N'Palilula','18363'),(N'Pambukovica','14213'),(N'Pančevo','26000'),(N'Panonija','24330'),(N'Paraćin','35250'),(N'Parage','21434'),(N'Parunovac','37201'),(N'Pasjane','38266'),(N'Pavliš','26333'),(N'Pečanjevce','16251'),(N'Pećinci','22410'),(N'Pecka','14207'),(N'Pejkovac','18413'),(N'Pepeljevac','37231'),(N'Perlez','23260'),(N'Perućac','31256'),(N'Petlovača','15304'),(N'Petrovac Na Mlavi','12300'),(N'Petrovaradin','21131'),(N'Pinosava','11226'),(N'Pirot','18300'),(N'Pivnice','21469'),(N'Plana','35247'),(N'Plandište','26360'),(N'Planinica','19207'),(N'Platičevo','22420'),(N'Plavna','21428'),(N'Plažane','35212'),(N'Pleš','37238'),(N'Ploča','37237'),(N'Pločica','26229'),(N'Pobeda','24313'),(N'Počekovina','37243'),(N'Poćuta','14206'),(N'Podunavci','36215'),(N'Podvis','19362'),(N'Podvrška','19321'),(N'Poganovo','18326'),(N'Pojate','37214'),(N'Poljana','12372'),(N'Popinci','22428'),(N'Popovac','18260'),(N'Popovac (kod Paraćina)','35254'),(N'Popučke','14221'),(N'Porodin','12375'),(N'Potočac','35207'),(N'Požarevac','12000'),(N'Požega','31210'),(N'Prahovo','19330'),(N'Pranjani','32308'),(N'Predejane','16222'),(N'Prekonoga','18365'),(N'Preljina','32212'),(N'Preševo','17523'),(N'Prevešt','35264'),(N'Prhovo','22442'),(N'Priboj','31330'),(N'Priboj Vranjski','17511'),(N'Pričević','14251'),(N'Prigrevica','25263'),(N'Prijepolje','31300'),(N'Prilički Kiseljak','32252'),(N'Prilužje','38213'),(N'Privina Glava','22257'),(N'Prnjavor Mačvanski','15306'),(N'Progar','11280'),(N'Prokuplje','18400'),(N'Prolom','18433'),(N'Provo','15215'),(N'Pružatovac','11413'),(N'Pukovac','18255'),(N'Putinci','22404'),(N'Rabrovo','12254'),(N'Rača','18440'),(N'Rača Kragujevačka','34210'),(N'Radalj','15321'),(N'Radenković','22206'),(N'Radičević','21225'),(N'Radinac','11311'),(N'Radljevo','14211'),(N'Radojevo','23221'),(N'Radujevac','19334'),(N'Rajac','19314'),(N'Rajković','14202'),(N'Rakinac','11327'),(N'Rakovac','21299'),(N'Ralja','11233'),(N'Ranilović','34302'),(N'Ranilug','38267'),(N'Ranovac','12304'),(N'Rašanac','12315'),(N'Raševica','35206'),(N'Raška','36350'),(N'Rastina','25283'),(N'Rataje','37236'),(N'Ratari','11411'),(N'Ratina','36212'),(N'Ratkovo','25253'),(N'Ravna Dubrava','18246'),(N'Ravna Reka','35235'),(N'Ravni','31206'),(N'Ravni Topolovac','23212'),(N'Ravnje','22205'),(N'Ravno Selo','21471'),(N'Ražana','31265'),(N'Ražanj','37215'),(N'Razbojna','37223'),(N'Razgojna','16252'),(N'Rekovac','35260'),(N'Reljan','17556'),(N'Resavica','35237'),(N'Resnik','34225'),(N'Rgotina','19214'),(N'Ribare (kod Jagodine)','35220'),(N'Ribari','15310'),(N'Ribarići','36309'),(N'Ribarska Banja','37205'),(N'Riđica','25280'),(N'Ripanj','11232'),(N'Ristovac','17521'),(N'Ritisevo','26331'),(N'Roćevci','36205'),(N'Rogača','11453'),(N'Rogačica','31255'),(N'Roge','31237'),(N'Rogljevo','19318'),(N'Rožanstvo','31208'),(N'Rudna Glava','19257'),(N'Rudnica','36353'),(N'Rudnik','32313'),(N'Rudno','36222'),(N'Rudovci','11566'),(N'Ruma','22400'),(N'Rumenka','21201'),(N'Ruplje','16223'),(N'Rušanj','11194'),(N'Ruski Krstur','25233'),(N'Rusko Selo','23314'),(N'Rutevac','18224'),(N'Sajan','23324'),(N'Sakule','26206'),(N'Salaš','19224'),(N'Salaš Noćajski','22204'),(N'Samaila','36202'),(N'Samoš','26350'),(N'Sanad','23331'),(N'Saraorci','11315'),(N'Sastav Reka','16213'),(N'Sastavci','31335'),(N'Savinac','19377'),(N'Savino Selo','21467'),(N'Seča Reka','31262'),(N'Sečanj','23240'),(N'Sedlare','35211'),(N'Sefkerin','26203'),(N'Selenča','21425'),(N'Seleuš','26351'),(N'Selevac','11407'),(N'Senta','24400'),(N'Senje','35233'),(N'Senjski Rudnik','35234'),(N'Sevojno','31205'),(N'Sibač','22440'),(N'Sibnica','11454'),(N'Sićevo','18311'),(N'Sijarinska Banja','16246'),(N'Sikirica','35256'),(N'Sikole','19225'),(N'Silbaš','21433'),(N'Simićevo','12373'),(N'Siokovac','35203'),(N'Sip','19326'),(N'Sirča','36208'),(N'Sirig','21214'),(N'Sirogojno','31207'),(N'Sivac','25223'),(N'Sjenica','36310'),(N'Skela','11509'),(N'Skobaj','11322'),(N'Skorenovac','26228'),(N'Slankamenački Vinogradi','22318'),(N'Slatina (kod čačka)','32224'),(N'Slavkovica','14245'),(N'Slovac','14223'),(N'Smederevo','11300'),(N'Smederevska Palanka','11420'),(N'Smilovci','18323'),(N'Smoljinac','12312'),(N'Soko Banja','18230'),(N'Sombor','25000'),(N'Sonta','25264'),(N'Sopoćani','36308'),(N'Sopot','11450'),(N'Sot','22243'),(N'Srbobran','21480'),(N'Srednjevo','12253'),(N'Sremčica','11253'),(N'Sremska Kamenica','21208'),(N'Sremska Mitrovica','22000'),(N'Sremska Rača','22247'),(N'Sremski Karlovci','21205'),(N'Sremski Mihaljevci','22413'),(N'Srpska Crnja','23220'),(N'Srpski Itebej','23233'),(N'Srpski Krstur','23334'),(N'Srpski Miletić','25244'),(N'Stajićevo','23204'),(N'Stalać','37212'),(N'Stanišić','25284'),(N'Stapar','25240'),(N'Stara Moravica','24340'),(N'Stara Pazova','22300'),(N'Starčevo','26232'),(N'Stari Banovci','22305'),(N'Stari Lec','26371'),(N'Stari Slankamen','22329'),(N'Stari Žednik','24224'),(N'Staro Selo (kod Velike Plane)','11324'),(N'Stave','14255'),(N'Stejanovci','22405'),(N'Stenjevac','35215'),(N'Stepanovićevo','21212'),(N'Stepojevac','14234'),(N'Stojnik','34307'),(N'Stopanja','37242'),(N'Stragari','34323'),(N'Straža (Banat)','26345'),(N'Strelac','18332'),(N'Strižilo','35269'),(N'Stubline','11507'),(N'Studenica','36343'),(N'Subotica','24000'),(N'Subotica (kod Svilajnca)','35209'),(N'Subotinac','18227'),(N'Subotište','22414'),(N'Sukovo','18322'),(N'Sumrakovac','19376'),(N'Supska','35228'),(N'Surčin','11271'),(N'Surduk','22307'),(N'Surdulica','17530'),(N'Susek','21313'),(N'Sutjeska','23244'),(N'Suvi Do','12322'),(N'Sveti Ilija','17508'),(N'Svetozar MiIetić','25211'),(N'Svilajnac','35210'),(N'Svileuva','15221'),(N'Svilojevo','25265'),(N'Svođe','16212'),(N'Svrljig','18360'),(N'Svojnovo','35259'),(N'Šabac','15000'),(N'Šajkaš','21244'),(N'Šarbanovac','19373'),(N'Šašinci','22425'),(N'Šepšin','11433'),(N'Šetonje','12309'),(N'Šid','22240'),(N'Šilopaj','32311'),(N'Šimanovci','22310'),(N'Šljivovica','31244'),(N'Šljivovo','37239'),(N'Štavalj','36311'),(N'Štitar','15354'),(N'Štubik','19303'),(N'Šurjan','23254'),(N'Takovo','32304'),(N'Taraš','23209'),(N'Tavankut','24214'),(N'Tekeriš','15234'),(N'Tekija','19325'),(N'Telečka','25222'),(N'Temerin','21235'),(N'Temska','18355'),(N'Tešica','18212'),(N'Titel','21240'),(N'Toba','23222'),(N'Tomaševac','23262'),(N'Topola','34310'),(N'Topolovnik','12226'),(N'Toponica','34243'),(N'Torda','23214'),(N'Tornjoš','24352'),(N'Tovariševo','21424'),(N'Trbušani','32205'),(N'Trešnjevac','24426'),(N'Trešnjevica','35248'),(N'Trgovište','17525'),(N'Trnava (kod (čačka)','32221'),(N'Trnavci','37235'),(N'Trnjane','19306'),(N'Trstenik','37240'),(N'Tršić','15303'),(N'Trupale','18211'),(N'Tulare','16247'),(N'Turekovac','16231'),(N'Turija (kod Kučeva)','12257'),(N'Turija','21215'),(N'Tutin','36320'),(N'Ub','14210'),(N'Ugao','36313'),(N'Ugrinovci','32314'),(N'Ugrinovci (kod Batajnice)','11277'),(N'Uljma','26330'),(N'Umčari','11430'),(N'Umka','11260'),(N'Urovica','19305'),(N'Utrine','24437'),(N'Ušće','36342'),(N'Uzdin','26216'),(N'Uzovnica','15319'),(N'Užice','31000'),(N'Vajska','21426'),(N'Valjevo','14000'),(N'Varda 031','31263'),(N'Varna (kod Šapca)','15232'),(N'Varvarin','37260'),(N'Vasilj','19367'),(N'Vatin','26337'),(N'Vašica','22241'),(N'Velesnica','19328'),(N'Velika Drenova','37245'),(N'Velika Grabovica','16221'),(N'Velika Greda','26366'),(N'Velika Ivanča','11414'),(N'Velika Krsna','11408'),(N'Velika Lomnica','37209'),(N'Velika Lukanja','18305'),(N'Velika Moštanica','11206'),(N'Velika Plana','11320'),(N'Velika Plana (Toplička)','18403'),(N'Velika Reka','15322'),(N'Velika Vrbnica','37233'),(N'Velike Livade','23217'),(N'Veliki Borak','11462'),(N'Veliki Crljeni','14233'),(N'Veliki Gaj','26365'),(N'Veliki lzvor','19206'),(N'Veliki Popović','35223'),(N'Veliki Radinci','22211'),(N'Veliki Šiljegovac','37204'),(N'Veliko Bonjince','18217'),(N'Veliko Gradište','12220'),(N'Veliko Laole','12306'),(N'Veliko Orašje','11323'),(N'Veliko Selo','12314'),(N'Veliko Središte','26334'),(N'Venčane','34306'),(N'Veternik','21203'),(N'Viča','32233'),(N'Vilovo','21246'),(N'Vina','19368'),(N'Vinarce','16207'),(N'Vionica','32254'),(N'Visočka Ržana','18306'),(N'Višnjevac','24222'),(N'Višnjićevo','22246'),(N'Vitanovac','36206'),(N'Vitkavac','36207'),(N'Vitojevci','22431'),(N'Vitoševac','37213'),(N'Vladičin Han','17510'),(N'Vladimirci','15225'),(N'Vladimirovac','26315'),(N'Vlajkovac','26332'),(N'Vlase','17507'),(N'Vlasina Okruglica','17532'),(N'Vlasina Rid','17533'),(N'Vlasina Stojkovićeva','17534'),(N'Vlasotince','16210'),(N'Vlaška','11406'),(N'Vlaški Do','12371'),(N'Vodanj','11328'),(N'Voganj','22429'),(N'Vojka','22313'),(N'Vojska','35208'),(N'Vojvoda Stepa','23219'),(N'Voluja','12256'),(N'Vraćevšnica','32315'),(N'Vračev Gaj','26348'),(N'Vranić','11427'),(N'Vranovo','11329'),(N'Vranje','17000'),(N'Vranjska Banja','17542'),(N'Vratamica','19344'),(N'Vražogrnac','19312'),(N'Vrba','36214'),(N'Vrbas','21460'),(N'Vrbica','23329'),(N'Vrčin','11224'),(N'Vrdnik','22408'),(N'Vreoci','14230'),(N'Vrnjačka Banja','36210'),(N'Vrnjci','36217'),(N'Vršac','26300'),(N'Vučje','16203'),(N'Zablaće','32223'),(N'Zabojnica','34244'),(N'Zabrežje','11505'),(N'Zagaljica','26344'),(N'Zajača','15315'),(N'Zaječar','19000'),(N'Zasavica','22201'),(N'Zavlaka','15312'),(N'Zdravinje','37203'),(N'Zemun','11080'),(N'Zlatibor','31315'),(N'Zlodol','31253'),(N'Zlot','19215'),(N'Zmajevo','21213'),(N'Zrenjanin','23000'),(N'Zuce','11225'),(N'Zvezdan','19227'),(N'Zvonce','18333'),(N'Žabalj','21230'),(N'Žabari','12374'),(N'Žagubica','12320'),(N'Železnik','11250'),(N'Žitište','23210'),(N'Žitkovac','18210'),(N'Žitni Potok','18407'),(N'Žitorađa','18412'),(N'Žuć','18348');

/*▓///////// Prodavnica(ID,Naziv,Adresa,GradID,Opis) /////////////// */
INSERT INTO Prodavnica VALUES 
('VIP1','Beogradska 1',103,'Trolejbuske linije br:19,21,22,29; Autobuske linije: E1,E9,30,31,33,36,39,42,47,48,59,78,83,401,402; Tramvajske linije: 2,3,9,10,14; Stajalište: Slavija; Radno vreme:8h-16h;'),
('VIP2','Glavna 2',103,'Autobuske linije: 15,17,45,73,83,84,703,704,706,706E,707; Stajalište: Zemun(Pošta); Radno vreme:8h-16h;'),
('VIP3','Bul.Kralja Petra I',683,'Autobuske linije: 3,8; Stajalište: Groblje(Smer A) ili Mašinska škola(Smer B); Radno vreme:8h-16h;'),
('VIP4','Obilićev venac 59',666,'Autobuske linije: 2,4,8; Stajalište: Obilićev venac; Radno vreme:8h-16h;'),
('VIP5','Kralja Milutina 104',975,'Na uglu Kralja Milutina i Drinske; Radno vreme:8h-16h;');

/*▓//////// Dobavljac(ID,Naziv,Adresa,GradID,PIB,MatBr) //////////// */
INSERT INTO Dobavljac VALUES 
('Emmi House doo','Bulevar Oslodilaca 78g',196,'110031011','21287733'),
('Vip House doo','Palmotićeva 7',103,'105107874','20311088'),
('Plutos Computers doo','Višnjički venac 55',103,'100205637','17335090'),
('Gigatron doo','Kirovljeva 17',103,'102778428','17479946');

/*▓//////////////// Korisnik(ID,userName,pass,Ime,Prezime,AdrPreb,GradID,Tel,Email,MB,Autentifikacija) ////////////////////// */
INSERT INTO Korisnik VALUES
('admin','admin',N'Nikola',N'Rnković',N'Beogradska 31',103,'011/321-34-54','nik.rnkovic@gmail.com','1103987710065','A'),
('admin2','admin2',N'Vladimir',N'Petrović',N'Bačka 55',103,'011/789-45-61','petrovicbbs@yahoo.com','2510987710131','A'),
('Dule91','dule91bgk',N'Dušan',N'Mandrapa',N'Požeška 666',103,'011/387-14-76','dusan.mandrapa@yahoo.com','0330991710009','Z'),
('Alex93','GummyBears',N'Aleksandra',N'Vukadinović',N'Cara Dušana 43',103,'011/915-23-93','aleksandra.vuk@yahoo.com','1805993715009','K')

/*▓///////// Artikal(ID,Naziv,KatArtID,Opis,DobavljacID,Cena) ///// *//*
Artikal(ID,Naziv,KatArtID,Opis,DobavljacID,Cena)
KatArtID:
1. ('Apple'),
2. ('Displays'),
3. ('PCConfigurations'),
4. ('PCComponents');*/

/* ///////// Artikal(ID,Naziv,KatArtID,Opis,DobavljacID,Cena) ///// */
INSERT INTO Artikal VALUES 
('MacBook Pro 13" Retina/DC i5/8GB/256GBSSD/IrisPlus 640',1,N'Naziv: MacBook Pro 13" Retina/DC i5/8GB/256GBSSD/IrisPlus 640; Proizvodac: Apple; Model: Macbook Pro 13", mpxt2cr/a; Procesor: Intel® Core™ 8thGen i5 Dual Core Processor 7360U, Brzina: 2.3GHz (Turbo do 3.6GHz), Keš memorija: 4MB; Grafika: Intel Iris Plus 640 sa deljenom sistemskom memorijom; Radna memorija: 8GB LPDDR3 2133 MHz SDRAM; Velicina ekrana: 13.3"; Tip ekrana: IPS Retina LED-backlit glossy 16:10; Rezolucija ekrana: 2560 x 1600; Kapacitet interne memorije: 256GB SSD; Povezivanje: USB-C x 2; Operativni sistem: macOS Sierra; Zadnja kamera: /; Dual Cam: /; Prednja kamera: 1.3 Mpix sa mikrofonom; Boja: Siva; GPS: Da, A-GPS; GLONASS : Da; NFC : /; Baterija: Lithium Polymer; Kapacitet baterije: /; Način unosa podataka : YU tastatura; Memorijska kartica: /; Opticki uredaj: /; Mreža : /; Podrzane tehnologije : WiFi, Bluetooth, HTML5; Mogucnosti koriscenja : Accelerometer, E-compass, fingerprint sensor, light sensor, proximity sensor; WiFi: 802.11 ac; Prenos podataka : /; Bluetooth: Da, v4.2; SIM slot: /; Dual SIM: /; Masa: 1,25kg;',1,350235),
('MacBook Air 13" Retina/i5 1.6GHz/8GB/256GB/UHD 617',1,N'Naziv: MacBook Air 13" Retina/i5 1.6GHz/8GB/256GB/UHD 617; Proizvodac: Apple; Model: Apple Macbook Air, mre92cr/a; Procesor: Intel® Core™ 8thGen i5, Dual Core, 1.6GHz - 3.6GHz, 4MB L3 keš memorije; Grafika: Intel UHD Graphics 617; Radna memorija: 8GB, 2133MHz LPDDR3; Velicina ekrana:  13.3"; Tip ekrana: IPS Retina LED-backlit glossy 16:10; Rezolucija ekrana: 2560 x 1600; Kapacitet interne memorije: 256GB SSD; Povezivanje: 3.5 mm headphone jack, 2 x Thunderbolt 3 (USB-C), DisplayPort, USB-C 3.1 Gen 2; Operativni sistem: MacOS; Zadnja kamera: /; Dual Cam: /; Prednja kamera: 720p; Boja: Siva; GPS: Da, A-GPS; GLONASS : Da; NFC : /; Baterija: Lithium Polymer; Kapacitet baterije: /; Način unosa podataka : CRO tastatura; Memorijska kartica: /; Opticki uredaj: /; Mreža : /; Podrzane tehnologije : WiFi, Bluetooth, HTML5; Mogucnosti koriscenja : Accelerometer, E-compass, fingerprint sensor, light sensor, proximity sensor; WiFi: 802.11 ac; Prenos podataka : /; Bluetooth: Da, v4.2; SIM slot: /; Dual SIM: /; Masa: 1,25kg;',1,323235),
('Apple 12.9-inch iPad Pro Cellular 256GB - Grey',1,N'Naziv: Apple 12.9-inch iPad Pro Cellular 256GB - Grey; Proizvodac: Apple; Model: Apple 12.9-inch iPad Pro Cellular 256GB - Space Grey, mpa42hc/a; Procesor: Apple A10X Hexa Core 2.93 GHz Fusion (ARMv8-A) 64-bit; Grafika: /; Radna memorija: 4GB LPDDR4; Velicina ekrana: 12.9"; Tip ekrana: Multi-Touch ekran sa LED pozadinskim osvetljenjem i IPS tehnologijom, otporan na otiske prstiju i ogrebotine.; Rezolucija ekrana: 2732 x 2048 piksela; Kapacitet interne memorije: 256GB eMMC; Povezivanje: HT80 with MIMO, Lightning port, Izlaz za slušalice; Operativni sistem: iOS 10; Zadnja kamera: 12.0 Mpix; Dual Cam: /; Prednja kamera: 7.0 Mpix; Boja: Siva; GPS: Da, A-GPS; GLONASS : Da; NFC : /; Baterija: Lithium ion; Kapacitet baterije: 10870mAh; Način unosa podataka : Touch Screen; Memorijska kartica: Ne; Opticki uredaj: Ne; Mreža : 4G/WiFi, Wi-Fi (802.11a/b/g/n/ac); dual band (2.4GHz and 5GHz); Podrzane tehnologije : WiFi, Bluetooth, HTML5; Mogucnosti koriscenja : Accelerometer, E-compass, fingerprint sensor, light sensor, proximity sensor; WiFi: Da; Prenos podataka : /; Bluetooth: Da, v4.2; SIM slot: Da, 1 x Nano SIM; Dual SIM: /; Masa: 677g;',1,249435),
('Apple 12.9-inch iPad Pro Cellular 256GB - Silver',1,N'Naziv: Apple 12.9-inch iPad Pro Cellular 256GB - Silver; Proizvodac: Apple; Model: Apple 12.9-inch iPad Pro Cellular 256GB - Space Grey, mpa42hc/a; Procesor: Apple A10X Hexa Core 2.93 GHz Fusion (ARMv8-A) 64-bit; Grafika: /; Radna memorija: 4GB LPDDR4; Velicina ekrana: 12.9"; Tip ekrana: Multi-Touch ekran sa LED pozadinskim osvetljenjem i IPS tehnologijom, otporan na otiske prstiju i ogrebotine.; Rezolucija ekrana: 2732 x 2048 piksela; Kapacitet interne memorije: 256GB eMMC; Povezivanje: HT80 with MIMO, Lightning port, Izlaz za slušalice; Operativni sistem: iOS 10; Zadnja kamera: 12.0 Mpix; Dual Cam: /; Prednja kamera: 7.0 Mpix; Boja: Srebrna; GPS: Da, A-GPS; GLONASS : Da; NFC : /; Baterija: Lithium ion; Kapacitet baterije: 10870mAh; Način unosa podataka : Touch Screen; Memorijska kartica: Ne; Opticki uredaj: Ne; Mreža : 4G/WiFi, Wi-Fi (802.11a/b/g/n/ac); dual band (2.4GHz and 5GHz); Podrzane tehnologije : WiFi, Bluetooth, HTML5; Mogucnosti koriscenja : Accelerometer, E-compass, fingerprint sensor, light sensor, proximity sensor; WiFi: Da; Prenos podataka : /; Bluetooth: Da, v4.2; SIM slot: Da, 1 x Nano SIM; Dual SIM: /; Masa: 677g;',1,249435),
('Apple 12.9-inch iPad Pro Cellular 256GB - Gold',1,N'Naziv: Apple 12.9-inch iPad Pro Cellular 256GB - Gold; Proizvodac: Apple; Model: Apple 12.9-inch iPad Pro Cellular 256GB - Gold, mpa42hc/a; Procesor: Apple A10X Hexa Core 2.93 GHz Fusion (ARMv8-A) 64-bit; Grafika: /; Radna memorija: 4GB LPDDR4; Velicina ekrana: 12.9"; Tip ekrana: Multi-Touch ekran sa LED pozadinskim osvetljenjem i IPS tehnologijom, otporan na otiske prstiju i ogrebotine.; Rezolucija ekrana: 2732 x 2048 piksela; Kapacitet interne memorije: 256GB eMMC; Povezivanje: HT80 with MIMO, Lightning port, Izlaz za slušalice; Operativni sistem: iOS 10; Zadnja kamera: 12.0 Mpix; Dual Cam: /; Prednja kamera: 7.0 Mpix; Boja: Gold; GPS: Da, A-GPS; GLONASS : Da; NFC : /; Baterija: Lithium ion; Kapacitet baterije: 10870mAh; Način unosa podataka : Touch Screen; Memorijska kartica: Ne; Opticki uredaj: Ne; Mreža : 4G/WiFi, Wi-Fi (802.11a/b/g/n/ac); dual band (2.4GHz and 5GHz); Podrzane tehnologije : WiFi, Bluetooth, HTML5; Mogucnosti koriscenja : Accelerometer, E-compass, fingerprint sensor, light sensor, proximity sensor; WiFi: Da; Prenos podataka : /; Bluetooth: Da, v4.2; SIM slot: Da, 1 x Nano SIM; Dual SIM: /; Masa: 677g;',1,249435),
('Altos Ripper, AMD Threadripper 2990WX/32GB/SSD 250GB/HDD 2TB/Rade RX Vega 56',3,N'Naziv: Altos Ripper, AMD Threadripper 2990WX/32GB/SSD 250GB/HDD 2TB/Rade RX Vega 56; Proizvodac: A-Comp; Namena : Profesionalni rad : Obrada fotografija, zvuka, vide i 3D rendera/Igre; Matična ploča : TR4 X399, DDR4/SATA3/GLAN/7.1/USB 3.1; Procesor : AMD Ryzen™ Threadripper™ 2990WX, 12nm, 32-fizička/64-logička jezgra, 64MB L3 keš memorije, potrošnja 250W; Hladnjak: ; Memorija : 32GB DDR4; SSD : Samsung 250GB SATA3, 550/520MB/s; Kapacitet hard diska : Toshiba 2TB SATA3 / 7200rpm; Grafička kartica : AMD Radeon RX VEGA 56, 8GB/HBM2/2048bit (Povezuje sa monitorom putem digitalnih izlaza HDMI i Display port); Optički uređaj : Nema; Zvučna kartica : 7.1 System (integrisana na matičnoj ploči); Kućište : Midi-Tower, Čelik/Plastika/Staklo/Ugradjen 1x 120cm ventilator; Napajanje : ATX 850W, Modulatno/135cm ventilator/Aktivan PFC/80 PLUS GOLD sertifikat; Ostalo : Vodeno Hladjenje 3x120 mm; ',2,612735),
('Altos Extreme II, Intel Core i7-8700K/32GB/SSD 480GB/HDD 2TB/nVidia RTX 2080',3,N'Naziv: Altos Extreme II, Intel Core i7-8700K/32GB/SSD 480GB/HDD 2TB/nVidia RTX 2080; Proizvodac: Altos; Namena : Profesionalni rad : 3D modeling / Obrada fotografija, zvuka, videa / Video Igre; Matična ploča : LGA1151 Z370, 4x DIMM DDR4 / SATA3 / GLAN / Audio 7.1 / USB 3.1; Procesor : Intel Core i7-8700K, 1151 / 14nm / 6-fizička, 12-logička jezgra / 12MB L3 keš memorija / Potrošnja 65W; Hladnjak: Be quiet Pure Rock Slim / BK008; Memorija : 32GB DDR4; SSD : 32GB DDR4; Kapacitet hard diska : 2TB SATA3 / 3.5 / 7200rpm; Grafička kartica : nVidia GeForce RTX 2080, 8GB / DDR6 / 256-bit (Povezuje sa monitorom putem digitalnih izlaza HDMI i Display port); Optički uređaj : Nema; Zvučna kartica : 7.1 System (integrisana na matičnoj ploči); Kućište : Midi Tower Raidmax ARTIO, crno / Providna bočna stranica / 1x LED ventilator; Napajanje : ATX 700W, 13.5cm ventilator / Aktivan PFC / 80 PLUS GOLD sertifikat / Efikasnost 90%; Ostalo : Sve naše računare karakteriše : Strogo i dugotrajno testiranje pre proizvodnje / Testiranje svakog pojedinačnog računara u trajanju od 24h nakom sklapanja / Savremena ambalaža koja štiti proizvod od neželjenih oštećenja u transportu. ; ',2,337485),
('Altos Shield, AMD Ryzen 7 2700X/16GB/SSD 480GB/AMD RADEON VII',3,N'Naziv: Altos Shield, AMD Ryzen 7 2700X/16GB/SSD 480GB/AMD RADEON VII; Proizvodac: Altos; Namena : Profesionalni rad : 3D modeling / Obrada fotografija, zvuka, videa / Video Igre; Matična ploča : AM4 X470, 4x DIMM DDR4 / SATA3 / GLAN / Audio 7.1 / USB 3.1; Procesor : AMD Ryzen 7 2700X, AM4 / 12nm / 8-fizička, 16-logička jezgra / 16MB L3 keš memorija / Potrošnja 105W; Hladnjak: Be quiet Pure Rock Slim; Memorija : 16GB DDR4; SSD : 480GB SATA3 / 2.5; Kapacitet hard diska : ; Grafička kartica : AMD Radeon RX VII, 16GB / 7NM / HBM2 / 4096-bit (Povezuje sa monitorom putem digitalnih izlaza HDMI i Display port); Optički uređaj : Nema; Zvučna kartica : 7.1 System (integrisana na matičnoj ploči); Kućište : Midi Tower Alexander Weiss Skywalker, Crno / Ugradjeni LED ventilatori : Napred 3x 120mm, Pozadi 1x 120mm / Providna bočna stranica / USB 3.0; Napajanje : ATX 700W, 13.5cm ventilator / Aktivan PFC / 80 PLUS GOLD sertifikat / Efikasnost 90% ; Ostalo : /; ',2,299835),
('HDD 3.5" SATA3 7200 10TB WD Purple, WD101PURZ, 256MB',4,N'Naziv: HDD 3.5" SATA3 7200 10TB WD Purple, WD101PURZ, 256MB; Kategorija: HDD; Proizvođač : WD; Model : WD101PURZ; Format : 3.5; Povezivanje : SATA 3; Kapacitet : 10TB; Bafer : 256MB; Broj obrtaja u minuti : 7200rpm; Garancija : 36 meseci ; ',4,60000),
('Asus TR4 X399 ROG Zenith Extreme DDR4/SATA3/GLAN/7.1/USB 3.1',4,N'Naziv: Asus TR4 X399 ROG Zenith Extreme DDR4/SATA3/GLAN/7.1/USB 3.1; Kategorija: MB; Proizvođač : Asus; Model : ROG ZENITH EXTREME; Format : ATX; Čipset : Build in AMD X399; Slot/Socket : TR4; Podržani procesori : AMD SocketTR4 for AMD Ryzen™ Threadripper™ Processors Supports CPU up to 16 cores; Memorijski slotovi : 8; Tip RAM-a : DDR4; Maksimalna količina memorije : 128GB; Radni takt RAM : 128GB, DDR4 3600(O.C.)/3200(O.C.)/2800(O.C.)/2666/2400/2133 MHz ECC and non-ECC, Un-buffered Memory * Quad Channel Memory Architecture; Latencija : PCI-Express 16xslot : 4x PCIe 3.0 x16, 1x PCIe 2.0 x4; PCI-Express 1xslot : 1x PCIe 2.0 x1; Prikljucci: 1x USB 3.1 Gen 2 (black)USB Type-C, 1x USB 3.1 Gen 2 (red)Type-A, 8x USB 3.1 Gen 1 (blue); Naponski konektori: /; Interni USB priključci : 1x USB 3.1 Gen 2 front panel connector; SATA : 6x SATA 6Gb/s port(s); Serial/ATA RAID modovi : Support Raid 0, 1, 10; Integrisana zvučna kartica : ROG SupremeFX 8-Channel High Definition Audio CODEC S1220; Integrisana mrežna kartica : Intel® I211-AT, 1 x Gigabit LAN Controller(s); Garancija : 36 meseci ; ',4,102000),
('AMD TR4 Ryzen Threadripper 2990WX, 4.2GHz BOX',4,N'Naziv: AMD TR4 Ryzen Threadripper 2990WX, 4.2GHz BOX; Kategorija: CPU; Proizvođač : AMD; Model : Treadripper; Slot/Socket : sTR4; Radni takt RAM : 3.0 GHz (Turbo frekvencija 4,2 GHz); Latencija : ; Broj jezgara : Cores : 32 Treads : 64; Kes: L1 : 3 MB; L2 : 16 MB; L3 : 64 MB; Maksimalna brzina memorije: 2933 MHz ; Garancija : 36 meseci ; ',4,345000),
('Memorija DIMM DDR4 4x16GB 3600MHz G.Skill Trident Z RGB CL17, F4-3600C17Q-64GTZR',4,N'Naziv: Memorija DIMM DDR4 4x16GB 3600MHz G.Skill Trident Z RGB CL17, F4-3600C17Q-64GTZR; Kategorija: RAM; Proizvođač : GSkill; Model : F4-3600C17Q-64GTZR; Kapacitet : 64GB (4x16GB); Tip RAM-a : DDR4; Radni takt RAM : 3600MHz; Latencija : CL17; Osvetljenje : RGB; Garancija : 120 meseci ; ',4,159000),
('GeForce RTX 2080Ti Zotac AMP 11GB DDR6,HDMI/3xDP/USB/352bit/ZT-T20810D-10P',4,N'Naziv: GeForce RTX 2080Ti Zotac AMP 11GB DDR6,HDMI/3xDP/USB/352bit/ZT-T20810D-10P; Kategorija: GPU; Proizvođač : Zotac; Model : ZT-T20810D-10P; Format : Model ; Povezivanje : Memorija ; Kapacitet : 11 GB; Čipset : RTX 2080Ti; DirectX&amp;OpenGL : DirectX 12.0 &amp; OpenGL 4.6; Slot/Socket : PCI-E; Tip RAM-a : GDDR6; Radni takt RAM : 352 bit; Maksimalna brzina memorije: Brzina čipa 1350-1665 Mhz / Brzina memorije 14000 Mhz; Prikljucci: HDMI; 3x DisplayPort; USB C; Naponski konektori: 2x 8-pin ; Interni USB priključci : Garancija : 36 meseci ; ',4,240000),
('TV 75" Smart LED SAMSUNG QE75Q7FAMTXXH,3840x2160 (Ultra HD),WiFi,T2,zakrivljeni',2,N'Naziv: TV 75" Smart LED SAMSUNG QE75Q7FAMTXXH,3840x2160 (Ultra HD),WiFi,T2,zakrivljeni; Proizvođač : Samsung; Model : QE75Q7FAMTXXH; Dijagonala : 75" (190 cm); Rezolucija : 3840 x 2160 (Ultra HD); Tip Tunera : DVB-T2/C/S2; SMART : Da; Wireless : Da; Povezivanje : HDMI, USB, Digitalni audio izlaz (optički), RF, LAN, CI; Boja : Srebrna; Android OS : Da; DVB-C : Da; DVB-S2 : Da; DVB-T2 : Da; Zvučnici : Da; Masa : Težina (kg) TV (bez postolja): 37,6 kg; Težina (kg) (sa postoljem): 42,9 kg; Dimenzije : ŠxVxD (mm) TV (bez postolja): 1671,2 × 957,9 × 53,2 mm; ŠxVxD (mm) sa postoljem: 1671,2 × 1046,6 × 405,0 mm ; Napomena: ; Garancija : 12 meseci ; Cena: 619000',3,619000),
('TV 65" Smart OLED Sony KD65AF9BAEP, 3840x2160 (Ultra HD), WiFi, T2, Android',2,N'Naziv: TV 65" Smart OLED Sony KD65AF9BAEP, 3840x2160 (Ultra HD), WiFi, T2, Android; Proizvođač : Sony; Model : KD65AF9BAEP; Dijagonala : 65" (163,9 cm); Rezolucija : 3840x2160 (Ultra HD); Tip Tunera : DVB-T2/C/S2; SMART : Da; Wireless : Ugrađen; Povezivanje : 4xHDMI (1 bočni / 3 donja), 3xUSB (2 (dno) / 1 (bočno)), Composite, IF, RF, LAN, WiFI; Boja : Crna; Android OS : Da; DVB-C : Da; DVB-S2 : Da; DVB-T2 : Da; Zvučnici : Zvuk (zvučnici i pojačalo): 13 W + 13 W + 13 W + 13 W + 13 W + 13 W + 10 W + 10 W; Masa : Bez postolja: Pribl. 27,2 kg Sa postoljem: Pribl. 35,6 kg ; Dimenzije : Bez postolja: Pribl. 144,9 x 83,5 x 8,6 cm Sa postoljem: Pribl. 144,9 x 83,2 x 32,0 cm; Napomena: Osigurajte 5-godišnju garanciju za televizor kupljen u periodu od 15.02.2019 do 31.03.2019. Aktivacija Vaše 5-ogodišnje garancije Kako biste aktivirali Vašu produženu garanciju potrebno je pratiti sledeće korake: 1. Posetite stranicu www.sony.eu/activation i odaberite Srbija i Crna Gora 2. Unesite aktivacioni kod* 3. Upišite sve zatražene detalje 4. Na Vaš e-mail će stići potvrda o aktivaciji i Ugovor o produženoj garanciji *Napomena: aktivacioni kod je jedinstven i može biti iskorišćen samo jednom Za ostvarivanje prava na besplatnu 5-ogodišnju garanciju, aktivaciju je neophodno izvršiti u roku od 15 dana od dana kupovine Vašeg televizora. Sačuvajte potvrdu o kupovini (račun) Vašeg proizvoda u slučaju pojave neispravnosti i potrebe za popravkom.; Garancija : 60 meseci ; Cena: 473000',3,473000),
('TV 65" Smart QLED SAMSUNG QE65Q8CAMTXXH, 3840x2160 (Ultra HD),WiFi,HDMI,USB,T2',2,N'Naziv: TV 65" Smart QLED SAMSUNG QE65Q8CAMTXXH, 3840x2160 (Ultra HD),WiFi,HDMI,USB,T2; Proizvođač : Samsung; Model : QE65Q8CAMTXXH; Dijagonala : 65" (165 cm); Rezolucija : 3840 x 2160 (Ultra HD); Tip Tunera : DVB-T/C/S2 x 2; SMART : Da; Wireless : Da; Povezivanje : HDMI, USB, Digitalni audio izlaz (optički), RF, LAN, CI; Boja : Crna; Android OS : /; DVB-C : /; DVB-S2 : /; DVB-T2 : /; Zvučnici : /; Masa : Težina (kg) TV (bez police): 26,5 kg; Težina (kg) sa policom: 30,2 kg; Dimenzije : ŠxVxD (mm) TV (bez police): 1441,9 × 828,8 × 107,3 mm; ŠxVxD (mm) sa policom: 1441,9 × 918,5 × 375,1 mm ; Napomena: /; Garancija : 24 meseci ; Cena: 415715',3,415715);

/*▓//////// Stanje(ID,ProdavnicaID,ArtikalID,Kolicina) //////////// */
INSERT INTO Stanje (ProdavnicaID,ArtikalID,Kolicina) 
SELECT Prodavnica.ID AS ProdavnicaID,Artikal.ID AS ArtikalID, Kolicina=0 FROM Prodavnica,Artikal ORDER BY ProdavnicaID

--DROP TABLE Stanje
--SELECT * FROM Stanje

/*INSERT INTO Stanje VALUES 
(1,1,20),(1,2,20),(1,3,20),(1,4,20),(1,5,20),(1,6,20),(1,7,20),(1,8,20),(1,9,20),(1,10,20),(1,11,20),(1,12,20),(1,13,20),(1,14,20),(1,15,20),(1,16,20),(2,1,20),(2,2,20),(2,3,20),(2,4,20),(2,5,20),(2,6,20),(2,7,20),(2,8,20),(2,9,20),(2,10,20),(2,11,20),(2,12,20),(2,13,20),(2,14,20),(2,15,20),(2,16,20),(3,1,20),(3,2,20),(3,3,20),(3,4,20),(3,5,20),(3,6,20),(3,7,20),(3,8,20),(3,9,20),(3,10,20),(3,11,20),(3,12,20),(3,13,20),(3,14,20),(3,15,20),(3,16,20),(4,1,20),(4,2,20),(4,3,20),(4,4,20),(4,5,20),(4,6,20),(4,7,20),(4,8,20),(4,9,20),(4,10,20),(4,11,20),(4,12,20),(4,13,20),(4,14,20),(4,15,20),(4,16,20),(5,1,20),(5,2,20),(5,3,20),(5,4,20),(5,5,20),(5,6,20),(5,7,20),(5,8,20),(5,9,20),(5,10,20),(5,11,20),(5,12,20),(5,13,20),(5,14,20),(5,15,20),(5,16,20);*/
--SELECT ROW_NUMBER() OVER(ORDER BY Prodavnica.ID,Artikal.ID ASC) AS ID, Prodavnica.ID AS ProdavnicaID,Artikal.ID AS ArtikalID, Kolicina=20 FROM Prodavnica,Artikal

/*▓//////// Fakture(ID,Oznaka,KorisnikID,ArtikalID,Kolicina,Iznos,Datum,ProdavnicaID,Napomena) //////////// */
INSERT INTO Fakture VALUES ('R0001/19',1,2,3,323235,'20190201',1,N'Dostava na kućnu adresu'),
('R0001/19',1,1,1,350235,'20190201',1,N'Dostava na kućnu adresu'),
('R0002/19',2,4,4,249435,'20190228',3,N'');

/*▓//////// LogStanja(ID,KorisnikID,ArtikalID,StanjePre,Izmena,StanjePosle,Racun,StavkaID,Datum,ProdavnicaID) //////////// */
INSERT INTO LogStanja VALUES (2,1,0,2,2,'',1,'20190310',1),
(2,2,0,1,1,'',1,'20190310',2),
(2,3,0,2,2,'',2,'20190310',3),
(2,4,0,5,5,'',2,'20190310',1);

/*▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/

/*▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ PROCEDURE ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/

/*▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/
	USE ShopV1_7
	GO

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ APLIKACIJA ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓ Artikli - prikaz svih Artikala, za Default.aspx ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE showArtikli
	AS
	SELECT Artikal.ID, Artikal.Naziv, KatArt.Naziv AS KatArt, Opis, Cena FROM Artikal
	INNER JOIN KatArt ON KatArt.ID = KatArtId
	GO

	--DROP PROCEDURE showArtikli
	--EXECUTE showArtikli

	--▓▓▓▓▓▓▓▓▓▓ Artikli - prikaz svih Artikala ILI Prema CatArtID, za Default.aspx (dopuna za koriscenje CatArtID)▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE shwArt @cat INT = 0
	AS
	IF (@cat=0) 
		BEGIN
			SELECT A.ID,Naziv,KatArtID,Opis,DobavljacID,Cena,SUM(Kolicina) AS Kolicina FROM Artikal AS A
			INNER JOIN Stanje ON A.ID=ArtikalID
			GROUP BY A.ID,Naziv,KatArtID,Opis,DobavljacID,Cena
		END
		ELSE
		BEGIN
			SELECT A.ID,Naziv,KatArtID,Opis,DobavljacID,Cena,SUM(Kolicina) AS Kolicina FROM Artikal AS A
			INNER JOIN Stanje ON A.ID=ArtikalID
			WHERE KatArtID=@cat
			GROUP BY A.ID,Naziv,KatArtID,Opis,DobavljacID,Cena
		END
	GO

	--DROP PROCEDURE shwArt
	--EXECUTE shwArt
	--		OR
	--EXECUTE shwArt 1

	--▓▓▓▓▓▓▓▓▓▓ Artikli - prikaz Artikala Kategorije, za filtriran Default.aspx ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE showItemsFrom @kategorija NVARCHAR(30)
	AS
	DECLARE @category INT = (SELECT ID FROM KatArt WHERE KatArt.Naziv=@kategorija);
	SELECT Artikal.ID, Artikal.Naziv, Opis, Cena FROM Artikal
	WHERE KatArtID = @category
	GO

	--DROP PROCEDURE showItemsFrom
	--EXECUTE showItemsFrom 'Apple'
	--@kategorija NVARCHAR(30)

	--▓▓▓▓▓▓▓▓▓▓ GetKatArt - prikaz Kategorija prozivoda ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE GetKatArt @catArtId INT
	AS
	SELECT * FROM KatArt WHERE KatArt.ID=@catArtId
	GO
	--DROP PROCEDURE GetKatArt
	--EXECUTE GetKatArt @catArtId
	--@catArtId INT

	--▓▓▓▓▓▓▓▓▓▓ GetTable - prikaz tabela(ID+glavna kolona) ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getTable @colomn varchar(20),@table varchar(20)
	AS
	DECLARE @komanda varchar(200) = 'SELECT ID, '+@colomn+' FROM '+@table+'';
	EXEC(@komanda);
	GO
	--DROP PROCEDURE getTable
	--EXECUTE getTable 'Naziv','Grad'
	--@colomn varchar(20),@table varchar(20)
	
	--▓▓▓▓▓▓▓▓▓▓ Artikal - prikaz Artikla, za UpdArt ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getArt @itemId INT
	AS
	SELECT * FROM Artikal WHERE Artikal.ID=@itemId
	GO
	--DROP PROCEDURE getArt
	--EXECUTE getArt 1
	--@itemId INT
	
	
	--▓▓▓▓▓▓▓▓▓▓ Artikal - prikaz Artikla, za Artikal.aspx ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getItem @itemId INT
	AS
	SELECT Artikal.Naziv,KatArtID AS KatID, KatArt.Naziv AS Kategorija,Opis,Cena,(SELECT SUM(Kolicina) FROM Stanje WHERE ArtikalID=@itemId) AS Stanje FROM Artikal 
	INNER JOIN KatArt ON KatArt.ID=KatArtId WHERE Artikal.ID=@itemId
	GO

	--DROP PROCEDURE getItem
	--EXECUTE getItem 1
	--@itemId INT

	--******************ArtikalID - getLastArt za potrebe novog proizvoda ************--
	CREATE PROCEDURE getLastArt
	AS
	SELECT MAX(ID) FROM Artikal
	GO
	--DROP PROCEDURE getLastArt
	--EXECUTE getLastArt
	
	--▓▓▓▓▓▓▓▓▓▓ Dobavljac - prikaz Dobavljaca ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getSupplier @supplierId INT
	AS
	SELECT Dobavljac.Naziv,Adresa,Grad.Naziv AS Grad,PIB,MatBr,Grad.ID AS GradId FROM Dobavljac
	INNER JOIN Grad ON Grad.ID = GradId
	WHERE Dobavljac.ID = @supplierId
	GO
	
	--DROP PROCEDURE getSupplier
	--EXECUTE getSupplier 1

	--▓▓▓▓▓▓▓▓▓▓ Korisnik - prikaz Korisnika sa userName-om i pass-om▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getUser @userName varchar(30), @pass varchar(30)
	AS 
	SELECT Korisnik.ID,userName,Ime,Prezime,Adresa, Grad.Naziv AS Grad,Tel AS Telefon,Email,MB AS MatBr, Autentifikacija FROM Korisnik
	INNER JOIN Grad ON Grad.ID = GradId
	WHERE Korisnik.userName = @userName AND Korisnik.pass=@pass
	GO
	
	--DROP PROCEDURE getUser
	--EXECUTE getUser 'admin','admin'
	
	--▓▓▓▓▓▓▓▓▓▓ Korisnik - prikaz Korisnika sa ID-iem▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE shwUser @userId INT
	AS 
	DECLARE @autentifikacija INT
	IF(SELECT Autentifikacija FROM Korisnik WHERE Korisnik.ID=@userId)='A'
	BEGIN
		SET @autentifikacija = 3
	END
	ELSE
	BEGIN
		IF(SELECT Autentifikacija FROM Korisnik WHERE Korisnik.ID=@userId)='Z'
		BEGIN
			SET @autentifikacija = 2
		END
		ELSE
		BEGIN
			SET @autentifikacija = 1
		END
	END
	SELECT Korisnik.ID,userName,Ime,Prezime,Adresa, Grad.Naziv AS Grad,Tel AS Telefon,Email,MB AS MatBr, Autentifikacija,GradID,pass,@autentifikacija AS Auth FROM Korisnik
	INNER JOIN Grad ON Grad.ID = GradId
	WHERE Korisnik.ID = @userId
	GO
	
	--DROP PROCEDURE shwUser
	--EXECUTE shwUser 1

	--▓▓▓▓▓▓▓▓▓▓ Prodavnice - prikaz svih Prodavnica za Kontakt.aspx ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE showProdavnice
	AS
	SELECT Prodavnica.ID, Prodavnica.Naziv, Prodavnica.Adresa AS Adresa, Grad.Naziv AS Grad, Prodavnica.Opis FROM Prodavnica
	INNER JOIN Grad ON Grad.ID = GradId
	GO
	
	--DROP PROCEDURE showProdavnice
	--EXECUTE showProdavnice

	--▓▓▓▓▓▓▓▓▓▓ Prodavnica - prikaz 1 Prodavnice za updShop ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getShop @shopId INT
	AS
	SELECT * FROM Prodavnica
	INNER JOIN Grad ON Grad.ID = GradId
	WHERE Prodavnica.ID = @shopId
	GO
	
	--DROP PROCEDURE getShop
	--EXECUTE getShop 1

	--▓▓▓▓▓▓▓▓▓▓ Prodavnica - prikaz 1 Prodavnice za Fakturu.aspx ▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE getProdavnica @shopId INT
	AS
	SELECT Prodavnica.ID, Prodavnica.Naziv, Prodavnica.Adresa AS Adresa, Grad.Naziv AS Grad, Prodavnica.Opis FROM Prodavnica
	INNER JOIN Grad ON Grad.ID = GradId
	WHERE Prodavnica.ID = @shopId
	GO
	
	--DROP PROCEDURE getProdavnica
	--EXECUTE getProdavnica 1
	
	--▓▓▓▓▓▓▓▓▓▓ listItems - izlistavanje tabela, za load Podesavanja.aspx▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE listItems @tabela varchar(20)
	AS
	DECLARE @table varchar(20);		--deklaracija tabele
	SET @table = @tabela;			--inicijalizacija tabele
	DECLARE @colomn varchar(20);	--deklaracija kolone
	SET @colomn = (SELECT CASE WHEN @table = 'Korisnik' THEN 'userName' WHEN @table='Fakture' OR @table='Stanje' OR @table='LogStanja' THEN 'ID' ELSE 'Naziv' END) --inicijalizacija kolone
	EXEC('SELECT ID,'+@colomn+' FROM '+@table)
	GO
	/*▓ /////// Pozivanje PROCEDURE listItems /////////
	EXECUTE listItems 'Artikal' 
	EXECUTE listItems 'Dobavljac'
	EXECUTE listItems 'Fakture'
	EXECUTE listItems 'Grad'
	EXECUTE listItems 'KatArt'
	EXECUTE listItems 'Korisnik'
	EXECUTE listItems 'LogStanja'
	EXECUTE listItems 'Prodavnica'
	EXECUTE listItems 'Stanje'
	DROP PROCEDURE listItems*/

	--▓▓▓▓▓▓▓▓▓▓ izmStanja - izmena stanja usled fakturisanja▓▓▓▓▓▓▓▓▓▓--
 	CREATE PROCEDURE izmStanja @kolicina INT,@itemID INT, @shopID INT
	AS
	DECLARE @stanje INT = (SELECT Kolicina FROM Stanje WHERE ArtikalID = @itemID AND ProdavnicaID = @shopID)
	UPDATE Stanje SET Kolicina = (@stanje - @kolicina) WHERE ArtikalID = @itemID AND ProdavnicaID = @shopID
	GO

	--EXECUTE showStanje
	--EXECUTE shwLogStanja
	--DROP PROCEDURE izmStanja
	--EXECUTE izmStanja -3,2,1
	--@kolicina INT,@itemID INT, @shop INT

	--▓▓▓▓▓▓▓▓▓▓ updStanja - izmena stanja usled popisa/otpisa/kradje i sl. ▓▓▓▓▓▓▓▓▓▓--
 	CREATE PROCEDURE updStanja @kolicina INT,@itemID INT, @shopID INT
	AS
	UPDATE Stanje SET Kolicina = @kolicina WHERE ArtikalID = @itemID AND ProdavnicaID = @shopID
	GO
	
	--DROP PROCEDURE updStanja
	--EXECUTE updStanja 5,5,2
	--@kolicina INT,@itemID INT, @shop INT



--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ NEW, UPD, DEL ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓


--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ DOBAVLJAC ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ newDobavljac - novi dobavljac ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE newDobavljac @name nvarchar(20), @adress nvarchar(50), @cityId INT, @PIB varchar(15),@MatBr varchar(15)
	AS
	INSERT INTO Dobavljac VALUES (@name,@adress,@cityId,@PIB,@MatBr)
	GO
	--DROP PROCEDURE newDobavljac
	--EXECUTE newDobavljac N'',N'',1,'',''
	--@name nvarchar(20), @adress nvarchar(50), @city int, @PIB varchar(15),@MatBr varchar(15)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ updDobavljac - izmena dobavljaca ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE updDobavljac @supplierId int, @name nvarchar(20), @adress nvarchar(50), @city int, @PIB varchar(15),@MatBr varchar(15)
	AS
	UPDATE Dobavljac SET Naziv=@name,Adresa=@adress,GradID=@city,PIB=@PIB,MatBr=@MatBr
	WHERE Dobavljac.ID=@supplierId
	GO
	--DROP PROCEDURE updDobavljac
	--EXECUTE updDobavljac 1,N'',N'',1,'',''
	--@supplierId int, @name nvarchar(20), @adress nvarchar(50), @city int, @PIB varchar(15),@MatBr varchar(15)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ delDobavljac - brisanje dobavljaca ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE delDobavljac @supplierId int
	AS
	IF (SELECT SUM(Stanje.Kolicina) FROM Artikal INNER JOIN Stanje ON Artikal.ID=ArtikalID WHERE DobavljacID=@supplierId) = 0
	BEGIN
		DELETE FROM Dobavljac
		WHERE Dobavljac.ID=@supplierId
	END
	ELSE
	BEGIN
		RETURN '0'
	END
	GO
	--DROP PROCEDURE delDobavljac
	--EXECUTE delDobavljac 1
	--@supplierId int

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ SHOP ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ newShop - nova prodavnica ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE newShop @name nvarchar(20), @adress nvarchar(50), @city int, @Desc nvarchar(200)
	AS
	INSERT INTO Prodavnica VALUES (@name,@adress,@city,@Desc)
	INSERT INTO Stanje(ProdavnicaID,ArtikalID,Kolicina)  SELECT Prodavnica.ID,Artikal.ID,Kolcina=0 FROM Prodavnica,Artikal WHERE Prodavnica.ID = (SELECT Max(Prodavnica.ID) FROM Prodavnica)
	GO

	--DROP PROCEDURE newShop
	--EXECUTE newShop N'',N'',1,N''
	--@name nvarchar(20), @adress nvarchar(50), @city int, @Desc nvarchar(200)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ updShop - izmena prodavnice ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE updShop @shopId int, @name nvarchar(20), @adress nvarchar(50), @city int, @Desc nvarchar(200)
	AS
	UPDATE Prodavnica SET Naziv=@name,Adresa=@adress,GradID=@city,Opis=@Desc
	WHERE Prodavnica.ID=@shopId
	GO
	--DROP PROCEDURE updShop
	--EXECUTE updShop 1,N'',N'',1,N''
	--@shopId int, @name nvarchar(20), @adress nvarchar(50), @city int, @Desc nvarchar(200)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ delShop - brisanje prodavnice ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE delShop @shopId int
	AS
	IF NOT EXISTS(SELECT * FROM Fakture WHERE ProdavnicaID=@shopId) AND NOT (SELECT SUM(Kolicina) FROM Stanje WHERE ProdavnicaID=@shopId) = 0
	BEGIN
		DELETE FROM Stanje WHERE ProdavnicaID=@shopId
		DELETE FROM Prodavnica	WHERE Prodavnica.ID=@shopId
	END
	ELSE
	BEGIN
		RETURN '0'
	END
	GO
	--DROP PROCEDURE delShop
	--EXECUTE delShop 1
	--@supplierId int

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ USER ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ newUser - nov korisnik ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE newUser @userName varchar(30), @pass varchar(30), @firstName nvarchar(30), @lastName nvarchar(30), @adress nvarchar(50), @city int, @phone varchar(50), @email varchar(50), @MB varchar(50),@authentication varchar(1) = 'K'
	AS
	INSERT INTO Korisnik VALUES (@userName,@pass,@firstName,@lastName,@adress,@city,@phone,@email,@MB,@authentication)
	GO
	
	--DROP PROCEDURE newUser
	--EXECUTE newUser '','',N'',N'',N'',1,'','','',''
	--@userName varchar(30), @pass varchar(30), @firstName nvarchar(30), @lastName nvarchar(30), @adress nvarchar(50), @city int, @phone varchar(50),@MB varchar(50),@authentication varchar(1)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ updUser - izmena korisnika ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE updUser @userId INT, @userName varchar(30), @pass varchar(30), @firstName nvarchar(30), @lastName nvarchar(30), @adress nvarchar(50), @city int, @phone varchar(50), @email varchar(50), @MB varchar(50),@authentication varchar(1)
	AS
	UPDATE Korisnik SET userName = @userName, pass=@pass, Ime=@firstName,Prezime=@lastName,Adresa=@adress,GradID=@city,Tel=@phone, Email=@email,MB=@MB,Autentifikacija=@authentication
	WHERE Korisnik.ID=@userId
	GO
	--DROP PROCEDURE updUser
	--EXECUTE updUser 1,'','',N'',N'',N'',1,'','','',''
--EXECUTE updUser @userId, @userName, @pass, @firstName, @lastName, @adress, @city, @phone, @email, @MB,@authentication
	--@userId INT, @userName varchar(30), @pass varchar(30), @firstName nvarchar(30), @lastName nvarchar(30), @adress nvarchar(50), @city int, @phone varchar(50), @email varchar(50), @MB varchar(50),@authentication varchar(1)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ delUser - brisanje korisnika ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	--------------------Izlistavanje racuna korisnika------------------------
	CREATE PROCEDURE userFakture @userId int
	AS
	SELECT Oznaka AS Racun FROM Fakture
	WHERE KorisnikID=@userId
	GROUP BY Oznaka
	GO
	--DROP PROCEDURE userFakture
	--EXECUTE userFakture 1
	--@userId int

	--------------Ukoliko korisnik ne načini kupovinu MOŽE se obrisati--------------------------------------------------------------------
	CREATE PROCEDURE delUser @userId int
	AS
	IF NOT EXISTS(SELECT Fakture.KorisnikID FROM Fakture WHERE KorisnikId=@userId)
	BEGIN
		DELETE FROM Korisnik WHERE Korisnik.ID=@userId
	END
	ELSE
	BEGIN
		RETURN '0'
	END
	GO
	--DROP PROCEDURE delUser
	--EXECUTE delUser 1
	--@userId int

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ CATEGORY ARTICLES ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ newCatArt - nova Kategorija ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE newCatArt @name nvarchar(30)
	AS
	INSERT INTO KatArt VALUES (@name)
	GO
	--DROP PROCEDURE newCatArt
	--EXECUTE newCatArt N''
	--@name nvarchar(30)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ updCatArt - izmena Kategorije ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE updCatArt @catArtId INT, @name nvarchar(30)
	AS
	UPDATE KatArt SET Naziv=@name
	WHERE KatArt.ID=@catArtId
	GO
	--DROP PROCEDURE updCatArt
	--EXECUTE updCatArt 1,N''
	--@catArtId INT, @name nvarchar(30)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ delCatArt - brisanje Kategorije ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE delCatArt @catArtId int
	AS
	IF (SELECT SUM(Kolicina) FROM Stanje INNER JOIN Artikal ON Artikal.ID=ArtikalId WHERE KatArtID=@catArtId)=0
	BEGIN
		DELETE FROM KatArt WHERE KatArt.ID=@catArtId
	END
	ELSE
	BEGIN
		RETURN '0'
	END
	GO
	--DROP PROCEDURE delCatArt
	--EXECUTE delCatArt 1
	--@catArtId int

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ARTICLES ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ newArt - nov Artikal ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE newArt @name nvarchar(150), @catArtId INT, @desc nvarchar(2000), @supplierId INT, @price INT
	AS
	INSERT INTO Artikal VALUES (@name, @catArtId, @desc, @supplierId, @price)
	INSERT INTO Stanje(ProdavnicaID,ArtikalID,Kolicina) SELECT Prodavnica.ID,Artikal.ID,Kolcina=0 FROM Prodavnica,Artikal WHERE Artikal.ID = (SELECT Max(Artikal.ID) FROM Artikal)
	GO

	--DROP PROCEDURE newArt
	--EXECUTE newArt N'',1,N'',1,1
	--@name nvarchar(150), @catArtId INT, @desc nvarchar(2000), @supplierId INT, @price INT

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ updArt - izmena Artikla ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE updArt @artId INT, @name nvarchar(150), @catArtId INT, @desc nvarchar(2000), @supplierId INT, @price INT
	AS
	UPDATE Artikal SET Naziv=@name,KatArtID=@catArtId,Opis=@desc,DobavljacID=@supplierId,Cena=@price
	WHERE Artikal.ID=@artId
	GO
	--DROP PROCEDURE updArt
	--EXECUTE updArt 1,N'',1,N'',1,1
	--@artId INT, @name nvarchar(150), @catArtId INT, @desc nvarchar(2000), @supplierId INT, @price INT

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ delArt - brisanje Artikla ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE delArt @artId int
	AS
	IF NOT EXISTS (SELECT * FROM Fakture WHERE ArtikalID=@artId) AND (SELECT SUM(Kolicina) FROM Stanje WHERE ArtikalID=@artId)=0
	BEGIN	
		DELETE FROM Stanje WHERE ArtikalID=@artId
		DELETE FROM Artikal WHERE Artikal.ID=@artId
	END
	ELSE
	BEGIN
		RETURN '0'
	END
	GO
	--DROP PROCEDURE delArt
	--EXECUTE delArt 2
	--@artId int

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	--btnStanje_Click

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ STANJE ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ showStanje - prikaz stanja(SVEGA) ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE showStanje
	AS
	SELECT Prodavnica.Naziv AS Prodavnica,Artikal.Naziv AS Artikal,Kolicina AS N'Količina' FROM Stanje
	INNER JOIN Prodavnica ON Prodavnica.ID=ProdavnicaID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	ORDER BY Prodavnica.ID,Artikal.ID ASC
	GO

	--DROP PROCEDURE showStanje
	--EXECUTE showStanje

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ schPremaProdavnici - prikaz stanja(prem Prodavnici) ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE schPremaProdavnici @shop int
	AS
	SELECT Prodavnica.Naziv,Artikal.Naziv,Kolicina FROM Stanje
	INNER JOIN Prodavnica ON Prodavnica.ID=ProdavnicaID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	WHERE ProdavnicaID=@shop
	GO

	--DROP PROCEDURE schPremaProdavnici
	--EXECUTE schPremaProdavnici 1
	--@shop int

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ schPremaArtiklu - prikaz stanja(prem Artiklu) ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE schPremaArtiklu @item int
	AS
	SELECT Prodavnica.Naziv,Artikal.Naziv,Kolicina FROM Stanje
	INNER JOIN Prodavnica ON Prodavnica.ID=ProdavnicaID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	WHERE ArtikalID=@item
	GO
	--DROP PROCEDURE schPremaArtiklu
	--EXECUTE schPremaArtiklu 1
	--@item int

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ schPremaProdavniciArtiklu - prikaz stanja(prem Prodavnici i Artiklu) ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE schPremaProdavniciArtiklu @shop int,@item int
	AS
	SELECT Prodavnica.Naziv,Artikal.Naziv,Kolicina FROM Stanje
	INNER JOIN Prodavnica ON Prodavnica.ID=ProdavnicaID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	WHERE ArtikalID=@item AND ProdavnicaID=@shop
	GO
	--DROP PROCEDURE schPremaProdavniciArtiklu
	--EXECUTE schPremaProdavniciArtiklu 1, 1
	--@shop int,@item int


	--btnFakture_Click

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ FAKTURE ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	
	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ Fakturisanje ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--------------------------GET NEXT FAKT za Fakturisanje-----------------------------------
	CREATE PROCEDURE getNextFakt
	AS
		DECLARE @slFakt INT = (SELECT COUNT(DISTINCT Oznaka) FROM Fakture) + 1
		SELECT @slFakt
	GO

	--DROP PROCEDURE getNextFakt
	--EXECUTE getNextFakt

	-------------------------FAKTURISANJE-------------------------------------
	CREATE PROCEDURE Fakturisanje @slFakt INT, @userId INT, @itemId INT, @qty INT, @Napomena VARCHAR(500)
	AS
	DECLARE @shopId int = (SELECT TOP 1 ProdavnicaID FROM Stanje	WHERE ArtikalID = @itemId AND Kolicina>0	ORDER BY Kolicina DESC);
	DECLARE @date date = GETUTCDATE();
	DECLARE @cena INT =(SELECT Cena FROM Artikal WHERE ID=@itemId);
	DECLARE @sum INT = @qty * @cena;
	DECLARE @nule VARCHAR(3)
	IF(@slFakt<10) 
		BEGIN 
			SET @nule='000'
		END
	ELSE
		BEGIN
			IF(@slFakt<100)
				BEGIN
					SET @nule= '00'
				END
			ELSE
				BEGIN
					IF(@slFakt<10)
					 	BEGIN 	
							SET @nule= '0'
					 	END
					ELSE
						BEGIN
							SET @nule= ''
						END
				END
		END
	DECLARE @oznakaSl VARCHAR(10) = 'R' + @nule + CAST(@slFakt AS VARCHAR(4)) + '/19'
	INSERT INTO Fakture VALUES (@oznakaSl,@userId,@itemId,@qty,@sum,@date,@shopId,@Napomena)
	-----------izmStanja------------------
	EXECUTE izmStanja @qty,@itemId,@shopId
	--@kolicina INT,@itemID INT, @shop INT
	GO
	
	--EXECUTE Fakturisanje 1,1,1,1,N''
	--@slFakt INT, @userId INT, @itemId INT, @qty INT, @Napomena VARCHAR(500)
	--DROP PROCEDURE Fakturisanje
		
	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ showFakture - prikaz svih Faktura(GROUP BY Oznaka racuna sa ukupnim iznosima) ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE showFakture
	AS
	SELECT DISTINCT Oznaka AS Racun,Korisnik.userName AS Korisnik,SUM(Iznos) AS Ukupno,CONVERT(VARCHAR(10), Datum, 104) AS Datum,Napomena FROM Fakture
	INNER JOIN Korisnik ON Korisnik.ID=KorisnikID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	GROUP BY Oznaka,Korisnik.userName,Datum,Napomena
	GO
	--DROP PROCEDURE showFakture
	--EXECUTE showFakture

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ showStavkeFakture - prikaz stavki određene fakture ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE showStavkeFakture @oznaka varchar(10)
	AS
	SELECT Artikal.Naziv,Kolicina, Iznos,Korisnik.ID AS KorisnikID, ProdavnicaID,Datum, ArtikalID,Napomena FROM Fakture
	INNER JOIN Korisnik ON Korisnik.ID=KorisnikID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	WHERE Fakture.Oznaka=@oznaka
	GO
	--CONVERT(VARCHAR(10), Datum, 104) AS Datum
	--DROP PROCEDURE showStavkeFakture
	--EXECUTE showStavkeFakture 'R0003/19'
	--@oznaka varchar(10)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ stornFakture - storniranje fakture ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE stornFakture @oznaka varchar(10)
	AS
	UPDATE Fakture SET Napomena='STORNO'
	WHERE Fakture.Oznaka=@oznaka
	GO

	--DROP PROCEDURE stornFakture
	--EXECUTE stornFakture 'R0003/19'
	--@oznaka varchar(10)

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ LogStanja - shwLogStanja ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE shwLogStanja
	AS
	SELECT Korisnik.userName AS Korisnik,Artikal.Naziv AS Artikal,StanjePre,Izmena,StanjePosle,Racun,convert(varchar, LogStanja.Datum, 104) AS Datum FROM LogStanja
	INNER JOIN Korisnik ON Korisnik.ID=KorisnikID
	INNER JOIN Artikal ON Artikal.ID=ArtikalID
	GO
	--DROP PROCEDURE shwLogStanja
	--EXECUTE shwLogStanja


--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ KORPA ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ PRAVLJENJE i DODAVANJE u tmpKorpa - ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE tmpKorpa @userId INT, @artikalId INT, @kolicina INT = 1
	AS
	DECLARE @staraKolicina INT = 0;
	DECLARE @tmpKorpa VARCHAR(50) = 'tmpKorpa_UserId' + CAST(@userId AS VARCHAR(6)) +'';
	DECLARE @komanda VARCHAR(1500) =
   'DECLARE @oldKolicina INT='+CAST(@staraKolicina AS VARCHAR(6))+';
	DECLARE @newKolicina INT='+CAST(@kolicina AS VARCHAR(6))+';
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='''+@tmpKorpa+''' and xtype='''+'U'+''')
	BEGIN 
		CREATE TABLE '+@tmpKorpa+'(ArtikalId int NOT NULL, Kolicina int NOT NULL);
		INSERT INTO '+@tmpKorpa+'(ArtikalId, Kolicina) VALUES ('+CAST(@artikalId AS VARCHAR(6))+','+CAST(@kolicina AS VARCHAR(6))+')	
	END 
	ELSE 
	BEGIN	
		IF NOT EXISTS (SELECT ArtikalId FROM '+@tmpKorpa+' WHERE ArtikalId='+CAST(@artikalId AS VARCHAR(6))+')	
		BEGIN 
			INSERT INTO '+@tmpKorpa+'(ArtikalId, Kolicina) VALUES ('+CAST(@artikalId AS VARCHAR(6))+','+CAST(@kolicina AS VARCHAR(6))+')	
		END	
		ELSE	
		BEGIN
			SET @oldKolicina = (SELECT Kolicina FROM '+@tmpKorpa+' WHERE ArtikalId='+CAST(@artikalId AS VARCHAR(6))+')
			SET @newKolicina = @newKolicina + @oldKolicina;
			UPDATE '+@tmpKorpa+' SET Kolicina=@newKolicina WHERE ArtikalId='+CAST(@artikalId AS VARCHAR(6))+'	
		END	
	END'
	EXEC(@komanda);
	GO
	--DROP PROCEDURE tmpKorpa
	--EXECUTE tmpKorpa 1,2,1
	--tmpKorpa @userId INT, @artikalId INT, @kolicina INT

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ BRISANJE tmpKorpe - delTmpKorpa @userId INT ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	CREATE PROCEDURE delTmpKorpa @userId INT
	AS
	DECLARE @tmpKorpa VARCHAR(50) = 'tmpKorpa_UserId' + CAST(@userId AS VARCHAR(6)) +'';
	DECLARE @komanda VARCHAR(50) = 'DROP TABLE '+@tmpKorpa+'';
	EXEC(@komanda)
	GO
	--DROP PROCEDURE delTmpKorpa
	--EXECUTE delTmpKorpa 1
	--@userId INT

	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ provera tmpKorpe - chckTmpKorpa @userId INT ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	CREATE PROCEDURE chckTmpKorpa @userId INT
	AS
	DECLARE @tmpKorpa VARCHAR(50) = 'tmpKorpa_UserId' + CAST(@userId AS VARCHAR(6)) +'';

	DECLARE @komanda VARCHAR(1000) =
	'IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='''+@tmpKorpa+''' and xtype='''+'U'+''')
		BEGIN 
			SELECT 0;	
		END 
		ELSE 
		BEGIN	
			SELECT COUNT(*) FROM '+@tmpKorpa+'
		END 
		'
	EXECUTE(@komanda)
	GO
	--DROP PROCEDURE chckTmpKorpa
	--EXECUTE chckTmpKorpa 2
	--@userId INT


	--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ PRIKAZ tmpKorpe - shwTmpKorpa @userId INT za prikaz Korpe ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	------------------------------------shwTmpKorpa-------------------------------------------
	CREATE PROCEDURE shwTmpKorpa @userId INT
	AS
	DECLARE @tmpKorpa VARCHAR(50) = 'tmpKorpa_UserId' + CAST(@userId AS VARCHAR(6)) +'';
	DECLARE @komand VARCHAR(1500) =	'SELECT ROW_NUMBER() OVER(ORDER BY Kolicina DESC) AS Stavka,Artikal.Naziv AS Artikal,Kolicina AS Kolicina,Artikal.Cena AS Cena,Artikal.ID AS ArtikalId FROM '+@tmpKorpa+'
	INNER JOIN Artikal ON Artikal.ID=ArtikalId'
	EXEC(@komand)
	GO
	--DROP PROCEDURE shwTmpKorpa
	--EXECUTE shwTmpKorpa 2
	--@userId INT

	--▓▓▓▓▓▓▓▓ UPDATE tmpKorpe - rfshTmpKorpa  @userId INT, @artikalId INT, @kolicina INT za Osveži▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	------------------------------------rfshTmpKorpa-------------------------------------------
	CREATE PROCEDURE rfshTmpKorpa @userId INT, @artikalId INT, @kolicina INT 
	AS
	DECLARE @tmpKorpa VARCHAR(50) = 'tmpKorpa_UserId' + CAST(@userId AS VARCHAR(6)) +'';
	IF (@kolicina=0)
	BEGIN
		DECLARE @komanda1 VARCHAR(1500) = 'DELETE FROM '+@tmpKorpa+' WHERE ArtikalId='+CAST(@artikalId AS VARCHAR(5))+'';
		EXEC(@komanda1);
		DECLARE @komanda VARCHAR(500)= 'IF NOT EXISTS( SELECT TOP 1 Kolicina FROM '+@tmpKorpa+') BEGIN DROP TABLE '+@tmpKorpa+' END';
		EXEC(@komanda);
	END
	ELSE
	BEGIN
		DECLARE @komanda2 VARCHAR(1500) ='UPDATE '+@tmpKorpa+' SET Kolicina='+CAST(@kolicina AS VARCHAR(5))+' WHERE ArtikalId = '+CAST(@artikalId AS VARCHAR(5))+'';
		EXEC(@komanda2);
	END
	GO
	--DROP PROCEDURE rfshTmpKorpa
	--EXECUTE rfshTmpKorpa 1,2,0
	--@userId INT, @artikalId INT, @kolicina INT 
	--SELECT Naziv FROM Artikal WHERE Artikal.ID=1
	
	/*▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/
	/*▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ LOGSTANJA ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓*/

	/*▓▓▓▓▓ izmena stanja prilikom FAKTURISANJA ▓▓▓▓▓*/
	CREATE PROCEDURE logStanjaFakt
	AS
	DECLARE @stavka INT = (SELECT MAX(ID) FROM Fakture)
	DECLARE @shopId INT = (SELECT ProdavnicaID FROM Fakture WHERE ID=@stavka)
	DECLARE @izmena INT = (SELECT Kolicina FROM Fakture WHERE ID=@stavka)
	DECLARE @artikalId INT = (SELECT ArtikalID FROM Fakture WHERE ID=@stavka)
	DECLARE @userId INT = (SELECT KorisnikID FROM Fakture WHERE ID=@stavka)
	DECLARE @racun varchar(10) = (SELECT Oznaka FROM Fakture WHERE ID=@stavka)
	DECLARE @stanjePosle INT = (SELECT Kolicina FROM Stanje WHERE ArtikalId=@artikalId AND ProdavnicaID = @shopId)
	DECLARE @stanjePre INT = @stanjePosle+@izmena;
	DECLARE @datum date = GETUTCDATE();
	INSERT INTO LogStanja VALUES (@userId,@artikalId,@stanjePre,@izmena,@stanjePosle,@racun,@stavka,@datum,@shopId)
	GO

	--DROP PROCEDURE logStanjaFakt
	--EXECUTE logStanjaFakt @userId,@artikalId,@izmena,@shopId
	--@userId INT,@artikalId INT,@izmena INT,@shopId INT

	/*▓▓▓▓▓ izmena stanja prilikom STRONIRANJA ▓▓▓▓▓*/
	CREATE PROCEDURE logStanjaStorn @racun VARCHAR(10)
	AS
	DECLARE @stavka INT
	/*Kursor*/
	DECLARE Kursor CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY 
	FOR 
	SELECT ID FROM Fakture WHERE Oznaka=@racun
	OPEN Kursor
	FETCH NEXT FROM Kursor INTO @stavka 
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		DECLARE @shopId INT = (SELECT ProdavnicaID FROM Fakture WHERE ID = @stavka)
		DECLARE @artikalId INT = (SELECT ArtikalID FROM Fakture WHERE ID = @stavka)
		DECLARE @korisnikId INT = (SELECT KorisnikID FROM Fakture WHERE ID = @stavka)
		DECLARE @stanjePosle INT = (SELECT Kolicina FROM Stanje WHERE ArtikalId=@artikalId AND ProdavnicaID = @shopId)
		DECLARE @izmena INT = (SELECT Kolicina FROM Fakture WHERE ID = @stavka)
		DECLARE @stanje INT = (SELECT TOP 1 stanjePosle FROM LogStanja WHERE ArtikalId=@artikalId AND ProdavnicaID = @shopId	ORDER BY Datum DESC)
		DECLARE @stanjePre INT = @stanjePosle-@izmena
		DECLARE @datum date = GETUTCDATE();
		INSERT INTO LogStanja VALUES (@korisnikId,@artikalId,@stanjePre,@izmena,@stanjePosle,@racun,@stavka,@datum,@shopId)
		FETCH NEXT FROM Kursor INTO @stavka
	END
	CLOSE Kursor
	DEALLOCATE Kursor
	GO

	--DROP PROCEDURE logStanjaStorn
	--EXECUTE logStanjaStorn @racun
	--@racun VARCHAR(10)

		/*▓▓▓▓▓ izmena stanja prilikom IZMENE STANJA ▓▓▓▓▓*/
	CREATE PROCEDURE logStanjaIzmena @korisnikId INT,@artikalId INT,@shopId INT,@kolicina INT
	AS
	DECLARE @stanjePosle INT = @kolicina
	DECLARE @stanje INT = (SELECT TOP 1 stanjePosle FROM LogStanja WHERE ArtikalId=@artikalId AND ProdavnicaID = @shopId	ORDER BY LogStanja.ID DESC)
	DECLARE @stanjePre INT
	IF (@stanje>0) 	BEGIN 		SET @stanjePre = @stanje 	END 	ELSE 	BEGIN		SET @stanjePre = 0 	END
	DECLARE @izmena INT = @stanjePosle-@stanjePre;
	DECLARE @racun varchar(20) = 'Izmena stanja';
	DECLARE @datum date = GETUTCDATE();
	INSERT INTO LogStanja(KorisnikID,ArtikalID,StanjePre,Izmena,StanjePosle,Racun,Datum,ProdavnicaID) VALUES (@korisnikId,@artikalId,@stanjePre,@izmena,@stanjePosle,@racun,@datum,@shopId)
	GO
	
	--DROP PROCEDURE logStanjaIzmena
	--EXECUTE logStanjaIzmena @korisnikId,@artikalId,@shopId,@kolicina
	--@korisnikId INT,@artikalId INT,@shopId INT,@kolicina INT

	/*▓▓▓▓▓ izmena stanja prilikom DODAVANJA STANJA ▓▓▓▓▓*/
	CREATE PROCEDURE logStanjaDodavanje @korisnikId INT,@artikalId INT,@shopId INT
	AS
	DECLARE @stanjePosle INT = (SELECT Kolicina FROM Stanje WHERE ArtikalId=@artikalId AND ProdavnicaID = @shopId)
	DECLARE @stanje INT = (SELECT TOP 1 stanjePosle FROM LogStanja WHERE ArtikalId=@artikalId AND ProdavnicaID = @shopId	ORDER BY LogStanja.ID DESC)
	DECLARE @stanjePre INT
	IF (@stanje>0) 	BEGIN 		SET @stanjePre = @stanje 	END 	ELSE 	BEGIN		SET @stanjePre = 0 	END
	DECLARE @izmena INT = @stanjePosle-@stanjePre;
	DECLARE @racun varchar(20) = 'Izmena stanja';
	DECLARE @datum date = GETUTCDATE();
	INSERT INTO LogStanja(KorisnikID,ArtikalID,StanjePre,Izmena,StanjePosle,Racun,Datum,ProdavnicaID) VALUES (@korisnikId,@artikalId,@stanjePre,@izmena,@stanjePosle,@racun,@datum,@shopId)
	GO
	
	--DROP PROCEDURE logStanjaDodavanje
	--EXECUTE logStanjaDodavanje @korisnikId,@artikalId,@shopId
	--@korisnikId INT,@artikalId INT,@shopId INT


---▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
								/*LEPA MI BESE NAMERA AL NE ZA SAD*/

	------▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ BAZA Core ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--

	------▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ btnLogStanja_Click - Trigger za popunu LogStanja ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓--
	----CREATE TRIGGER PromStanja
	----ON Stanje
	----AFTER INSERT, UPDATE
	----AS
	----DECLARE @korisnikId INT;
	----DECLARE @zadnjaStavka INT;
	----DECLARE @zadnjiRacun NVARCHAR(20);
	----DECLARE @datum date;
	----DECLARE @artikalId INT;
	----DECLARE @shopId INT;
	----DECLARE @izmena INT;
	----DECLARE @stanjePosle INT;
	----DECLARE @stanjePre INT;
	----DECLARE @faktura INT;

	------▓ @zadnjaStavka
	----SET @zadnjaStavka = (SELECT MAX(ID) FROM Fakture)   

	------▓ @datum
	----SET @datum = GETUTCDATE()

	------▓ @korisnik
	----SET @korisnikId = (SELECT KorisnikID FROM Fakture WHERE Fakture.ID = @zadnjaStavka)

	------▓ @artikal
	----SET @artikalId = (SELECT ArtikalID FROM Fakture WHERE Fakture.ID = @zadnjaStavka)

	------▓ @shop
	----SET @shopId = (SELECT ProdavnicaID FROM Fakture WHERE Fakture.ID = @zadnjaStavka)

	------▓ @izmena
	----SET @izmena =(SELECT Fakture.Kolicina FROM Fakture WHERE Fakture.ID = @zadnjaStavka)

	------▓ @stanjePosle
	----SET @stanjePosle =(SELECT Kolicina FROM Stanje WHERE ArtikalID = @artikalId AND ProdavnicaID = @shopId)

	------▓ @stanjePre
	----IF((SELECT COUNT(Racun) FROM LogStanja WHERE Racun = @zadnjiRacun)>0) BEGIN SET @stanjePre = @stanjePosle-@izmena END ELSE BEGIN SET @stanjePre = @stanjePosle+@izmena END

	------▓ @zadnjiRacun
	----SET @zadnjiRacun = (SELECT Oznaka FROM Fakture WHERE Fakture.ID = @zadnjaStavka)

	------▓ INSERT
	----INSERT INTO LogStanja VALUES (@korisnikId,@artikalId,@stanjePre,@izmena,@stanjePosle,@zadnjiRacun,@zadnjaStavka,@datum)
	----GO
	------DROP TRIGGER PromStanja