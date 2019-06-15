--CREATE/DROP DATABASE, RELACIONI MODEL, LEGENDA
/*
CREATE DATABASE ShopV1_6
*/
/*
USE master	DROP DATABASE ShopV1_6
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
USE ShopV1_6
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
INSERT INTO Grad (Tekst) VALUES 
(N'24430 Ada'),
(N'22244 Adaševci'),
(N'24425 Adorjan'),
(N'36203 Adrani'),
(N'18226 Aleksinački Rudnik'),
(N'25212 Aleksa Šantić'),
(N'37230 Aleksandrovac (Kruševački)'),
(N'12370 Aleksandrovac (Požarevački)'),
(N'23217 Aleksandrovo'),
(N'18220 Aleksinac'),
(N'26310 Alibunar'),
(N'31307 Aljinovici'),
(N'25260 Apatin'),
(N'23207 Aradac'),
(N'34300 Aranđelovac'),
(N'31230 Arilje'),
(N'22418 Ašanja'),
(N'11423 Azanja'),
(N'18315 Babin Kal'),
(N'18330 Babušnica'),
(N'21420 Bač'),
(N'31258 Bačevci'),
(N'37265 Bačina'),
(N'22225 Bačinci'),
(N'21400 Bačka Palanka'),
(N'24300 Bačka Topola'),
(N'25275 Bački Breg'),
(N'25242 Bački Brestovac'),
(N'25252 Bački Gracac'),
(N'21234 Bački Jarak'),
(N'25272 Bački Monoštor'),
(N'21470 Bački Petrovac'),
(N'24343 Bački Sokolac'),
(N'24415 Bački Vinogradi'),
(N'21465 Bačko Dobro Polje'),
(N'21217 Bačko Gradište'),
(N'21429 Backo Novo Selo'),
(N'21226 Backo Petrovo Selo'),
(N'34226 Badnjevac'),
(N'15358 Badovinci'),
(N'35204 Bagrdan'),
(N'31250 Bajina Bašta'),
(N'24210 Bajmok'),
(N'24331 Bajsa'),
(N'18257 Balajinac'),
(N'36344 Baljevac Na Ibru'),
(N'26324 Banatska Palanka'),
(N'23332 Banatsko Aranđelovo'),
(N'26234 Banatski Brestovac'),
(N'23242 Banatski Despotovac'),
(N'23216 Banatsko Karađorđevo'),
(N'26314 Banatsko Novo Selo'),
(N'26327 Banatska Subotica'),
(N'23237 Banatsko Visnjicevo'),
(N'23251 Banatska Dubica'),
(N'23315 Banatska Topola'),
(N'23213 Banatski Dvor'),
(N'26320 Banatski Karlovac'),
(N'23312 Banatsko Veliko Selo'),
(N'11424 Banicina'),
(N'34304 Banja'),
(N'31337 Banja Kod Priboja'),
(N'15316 Banja Koviljaca'),
(N'14214 Banjani'),
(N'38216 Banjska'),
(N'21312 Banostor'),
(N'22303 Banovci Dunav'),
(N'15362 Banovo Polje'),
(N'11460 Barajevo'),
(N'26205 Baranda'),
(N'18426 Barbatovac'),
(N'34205 Bare'),
(N'11504 Baric'),
(N'26367 Barice'),
(N'18432 Barlovo'),
(N'11565 Barosevac'),
(N'23316 Basaid'),
(N'34227 Batocina'),
(N'22251 Batrovci'),
(N'26222 Bavaniste'),
(N'21220 Bečej'),
(N'11279 Becmen'),
(N'11308 Begaljica'),
(N'21411 Begeč'),
(N'23232 Begejci'),
(N'26340 Bela Crkva'),
(N'15313 Bela Crkva (kod Krupnja)'),
(N'18310 Bela Palanka'),
(N'37253 Bela Voda'),
(N'31311 Bela Zemlja'),
(N'14246 Belanovica'),
(N'32259 Bele Vode'),
(N'22306 Belegiš'),
(N'11223 Beli Potok'),
(N'19366 Beli Potok (kod Svrljiga)'),
(N'11461 Beljina'),
(N'23205 Belo Blato'),
(N'18424 Beloljin'),
(N'34312 Belosavci'),
(N'18411 Belotinac'),
(N'35263 Belusic'),
(N'21300 Beocin'),
(N'11000 Beograd'),
(N'22242 Berkasovo'),
(N'32305 Beršići'),
(N'22212 Besenovo'),
(N'22324 Beška'),
(N'25270 Bezdan'),
(N'35238 Bigrenica'),
(N'22254 Bikic Do'),
(N'24206 Bikovo'),
(N'17522 Biljaca'),
(N'22253 Bingula'),
(N'31241 Bioska'),
(N'17546 Bistar'),
(N'31325 Bistrica'),
(N'18420 Blace'),
(N'37226 Blazevo'),
(N'35217 Bobovo'),
(N'23274 Bocar'),
(N'21427 Bođani'),
(N'24408 Bogaraš'),
(N'15350 Bogatić'),
(N'25245 Bogojevo'),
(N'14225 Bogovađa'),
(N'19372 Bogovina'),
(N'36341 Bogutovac'),
(N'16205 Bojnik'),
(N'23252 Boka'),
(N'11307 Boleč'),
(N'19370 Boljevac'),
(N'11275 Boljevci'),
(N'32312 Boljkovci'),
(N'19210 Bor'),
(N'11211 Borča'),
(N'19229 Borski Brestovac'),
(N'19231 Borsko Bucje'),
(N'17540 Bosilegrad'),
(N'16232 Bošnjace'),
(N'37262 Bošnjane'),
(N'22217 Bosut'),
(N'23243 Botoš'),
(N'31322 Božetići'),
(N'12313 Boževac'),
(N'17537 Božica'),
(N'19315 Braćevac'),
(N'12206 Bradarac'),
(N'12222 Braničevo'),
(N'14201 Brankovina'),
(N'12225 Bratinac'),
(N'32256 Bratljevo'),
(N'32303 Brđani'),
(N'31234 Brekovo'),
(N'32213 Bresnica'),
(N'22415 Brestac'),
(N'19216 Brestovacka Banja'),
(N'16253 Brestovac'),
(N'12205 Brezane'),
(N'14244 Brezde'),
(N'15309 Brezjak'),
(N'32307 Brezna'),
(N'32253 Brezova'),
(N'38157 Brezovica'),
(N'14212 Brgule'),
(N'12230 Brnjica'),
(N'31305 Brodarevo'),
(N'37220 Brus'),
(N'19313 Brusnik'),
(N'36346 Brvenik'),
(N'19323 Brza Palanka'),
(N'34228 Brzan'),
(N'37225 Brzeće'),
(N'19369 Bučje'),
(N'22421 Buđanovci'),
(N'21242 Budisava'),
(N'17520 Bujanovac'),
(N'21209 Bukovac'),
(N'32251 Bukovica'),
(N'34301 Bukovik'),
(N'34217 Bukurovac'),
(N'34242 Bumbarevo Brdo'),
(N'35273 Bunar'),
(N'18368 Burdimo'),
(N'12307 Burovac'),
(N'35249 Busilovac'),
(N'15224 Cerovac'),
(N'26213 Crepaja'),
(N'36321 Crkvine'),
(N'23328 Crna Bara'),
(N'15355 Crna Bara'),
(N'16215 Crna Trava'),
(N'18304 Crnoklište'),
(N'26323 Crvena Crkva'),
(N'18313 Crvena Reka'),
(N'25220 Crvenka'),
(N'32000 Čačak'),
(N'31310 Čajetina'),
(N'22231 Čalma'),
(N'24220 Čantavir'),
(N'18417 Čecina'),
(N'21413 Čelarevo'),
(N'21233 Čenej'),
(N'23266 Čenta'),
(N'21311 Čerević'),
(N'23215 Čestereg'),
(N'37208 Čitluk (kod Kruševca)'),
(N'18232 Čitluk (kod Soko Banje)'),
(N'23320 Čoka'),
(N'25210 Čonoplja'),
(N'22326 Čortanovci'),
(N'21238 Čurug'),
(N'36220 Čukojevac'),
(N'34322 Čumić'),
(N'37210 Ćićevac'),
(N'35230 Ćuprija'),
(N'34305 Darosava'),
(N'37271 Dasnica'),
(N'26214 Debeljača'),
(N'15214 Debrc'),
(N'22441 Deč'),
(N'26225 Deliblato'),
(N'36307 Delimede'),
(N'25254 Deronje'),
(N'34321 Desimirovac'),
(N'35213 Despotovac'),
(N'21468 Despotovo'),
(N'26316 Devojački Bunar'),
(N'36305 Deževa'),
(N'18320 Dimitrovgrad'),
(N'14222 Divci'),
(N'14204 Divčibare'),
(N'31236 Divljaka'),
(N'22232 Divoš'),
(N'34204 Divostin'),
(N'11272 Dobanovci'),
(N'12224 Dobra'),
(N'18408 Dobri Do'),
(N'15235 Dobrić'),
(N'26354 Dobrica'),
(N'22412 Dobrinci'),
(N'18314 Dolac'),
(N'18410 Doljevac'),
(N'26227 Dolovo'),
(N'19213 Donja Bela Reka'),
(N'15317 Donja Borina'),
(N'19352 Donja Kamenica'),
(N'11326 Donja Livadica'),
(N'17544 Donja Ljubata'),
(N'35255 Donja Mutnica'),
(N'15323 Donja Orovica'),
(N'18404 Donja Rečica'),
(N'34314 Donja Šatornja'),
(N'18421 Donja Trnava'),
(N'35258 Donje Vidovo'),
(N'18414 Donje Crnatovo'),
(N'15227 Donje Crniljevo'),
(N'18254 Donje Medurovo'),
(N'17547 Donje Tlamino'),
(N'19345 Donje Zuniče'),
(N'18242 Donji Dušnik'),
(N'37258 Donji Krčin'),
(N'19220 Donji Milanovac'),
(N'17526 Donji Stajevac'),
(N'25243 Doroslovo'),
(N'14203 Dračić'),
(N'15311 Draginac'),
(N'15226 Draginje'),
(N'31317 Draglica'),
(N'34231 Dragobraca'),
(N'35272 Dragocvet'),
(N'35262 Dragoševac'),
(N'35265 Dragovo'),
(N'38239 Drajkovce'),
(N'11506 Draževac'),
(N'18223 Draževac (kod Aleksinca)'),
(N'15212 Drenovac'),
(N'35257 Drenovac (kod Paraćina)'),
(N'15324 Drlače'),
(N'11432 Drugovac'),
(N'15359 Dublje'),
(N'12255 Duboka'),
(N'26224 Dubovac'),
(N'18406 Dubovo'),
(N'12207 Dubravica'),
(N'11561 Dudovica'),
(N'36312 Duga Poljana'),
(N'18237 Dugo Polje'),
(N'19335 Dušanovac'),
(N'26328 Dupljaja'),
(N'37206 Dvorane'),
(N'17514 Džep'),
(N'18405 Džigolj'),
(N'23335 Đala'),
(N'38238 Đeneral Janković'),
(N'37202 Đunis'),
(N'21239 Đurđevo'),
(N'34215 Đurđevo (kod Kragujevca)'),
(N'24213 Đurđin'),
(N'23203 Ečka'),
(N'23208 Elemir'),
(N'34207 Erdeč'),
(N'22230 Erdevik'),
(N'23264 Farkaždin'),
(N'24323 Feketić'),
(N'21410 Futog'),
(N'18240 Gadžin Han'),
(N'26223 Gaj'),
(N'21432 Gajdobra'),
(N'25282 Gakovo'),
(N'19228 Gamzigradska Banja'),
(N'21247 Gardinovci'),
(N'22258 Gibarac'),
(N'35261 Glavinci'),
(N'37251 Globoder'),
(N'26202 Glogonj'),
(N'35222 Glogovac'),
(N'21412 Gložan'),
(N'15356 Glušci'),
(N'11316 Golobok'),
(N'12223 Golubac'),
(N'22308 Golubinci'),
(N'32232 Goračići'),
(N'32225 Goričani'),
(N'31214 Gornja Dobrinja'),
(N'18425 Gornja Draguša'),
(N'17538 Gornja Lisina'),
(N'34206 Gornja Sabanta'),
(N'14243 Gornja Toplica'),
(N'18202 Gornja Toponica'),
(N'32215 Gornja Trepča'),
(N'32306 Gornji Banjani'),
(N'18241 Gornji Barbeš'),
(N'24406 Gornji Breg'),
(N'16244 Gornji Brestovac'),
(N'32300 Gornji Milanovac'),
(N'18204 Gornji Matejevac'),
(N'37221 Gornji Stepos'),
(N'37234 Gornji Stupanj'),
(N'21237 Gospođinci'),
(N'31313 Gostilje'),
(N'11508 Grabovac'),
(N'22423 Grabovci'),
(N'38205 Gracanica'),
(N'18321 Gradina'),
(N'19205 Gradskovo'),
(N'37229 Graševci'),
(N'16220 Grdelica'),
(N'26347 Grebenac'),
(N'18213 Gredetin'),
(N'18219 Grejač'),
(N'22213 Grgurevci'),
(N'19342 Grlište'),
(N'19341 Grljan'),
(N'11306 Grocka'),
(N'34202 Grošnica'),
(N'34230 Gruža'),
(N'34232 Guberevac'),
(N'32230 Guča'),
(N'26335 Gudurica'),
(N'24312 Gunaroš'),
(N'18208 Guševac'),
(N'38209 Gušterica'),
(N'26370 Hajdučica'),
(N'24414 Hajdukovo'),
(N'19236 Halovo'),
(N'23235 Hetin'),
(N'24410 Horgoš'),
(N'24411 Horgoš Granični Prelaz'),
(N'22427 Hrtkovci'),
(N'23323 Iđoš'),
(N'26207 Idvor'),
(N'26352 Ilandža'),
(N'34203 Ilićevo'),
(N'22250 Ilinci'),
(N'22320 Inđija'),
(N'22406 Irig'),
(N'22407 Iriški Venac'),
(N'32250 Ivanjica'),
(N'26233 Ivanovo'),
(N'26343 Izbište'),
(N'31314 Jablanica'),
(N'14226 Jabučje'),
(N'31306 Jabuka'),
(N'19304 Jabukovac'),
(N'15308 Jadranska Lešnica'),
(N'11412 Jagnjilo'),
(N'35000 Jagodina'),
(N'11276 Jakovo'),
(N'22248 Jamena'),
(N'26362 Janošik'),
(N'22426 Jarak'),
(N'23250 Jarkovac'),
(N'34318 Jarmenovci'),
(N'23230 Jaša Tomić'),
(N'26346 Jasenovo'),
(N'31319 Jasenovo (kod Nove Varoši)'),
(N'35241 Jasenovo (kod Despotovca)'),
(N'37252 Jasika'),
(N'22409 Jazak'),
(N'23327 Jazovo'),
(N'18206 Jelašnica'),
(N'17531 Jelašnica'),
(N'31215 Jelen Do'),
(N'34309 Jelovik'),
(N'26363 Jermenovci'),
(N'32222 Ježevica'),
(N'31213 Ježevica (Užička)'),
(N'18234 Jošanica'),
(N'36345 Jošanicka Banja'),
(N'35205 Jovac'),
(N'18253 Jugbogdanovac'),
(N'11562 Junkovac'),
(N'21241 Kać'),
(N'26212 Kačarevo'),
(N'26329 Kajtasovo'),
(N'19353 Kalna'),
(N'31257 Kaluđerske Bare'),
(N'11130 Kaluđerica'),
(N'32206 Kamenica (kod Čačka)'),
(N'18324 Kamenica (kod Dimitrovgrada)'),
(N'14252 Kamenica (Valjevska)'),
(N'24420 Kanjiža'),
(N'32234 Kaona'),
(N'37256 Kaonik'),
(N'21421 Karađorđevo'),
(N'31204 Karan'),
(N'25255 Karavukovo'),
(N'22443 Karlovčić'),
(N'18225 Katun'),
(N'24104 Kelebija'),
(N'24205 Kelebija Granični Prelaz'),
(N'24407 Kevi'),
(N'23300 Kikinda'),
(N'21211 Kisač'),
(N'19320 Kladovo'),
(N'23211 Klek'),
(N'22424 Klenak'),
(N'17524 Klenike'),
(N'15357 Klenje'),
(N'12258 Klenje (kod Golubca)'),
(N'12209 Kličevac'),
(N'17535 Klisura'),
(N'25221 Kljajićevo'),
(N'19222 Klokočevac'),
(N'34240 Knić'),
(N'23265 Knićanin'),
(N'19350 Knjaževac'),
(N'19316 Kobišnica'),
(N'15220 Koceljeva'),
(N'31318 Kokin Brod'),
(N'35242 Kolare'),
(N'11431 Kolari'),
(N'25274 Kolut'),
(N'14254 Komirić'),
(N'23253 Konak'),
(N'36340 Konarevo'),
(N'35219 Končarevo'),
(N'37254 Konjuh'),
(N'36354 Kopaonik'),
(N'19223 Koprivnica'),
(N'11415 Koračica'),
(N'17545 Korbevac'),
(N'19329 Korbovo'),
(N'15302 Korenita'),
(N'18216 Korman'),
(N'34224 Korman (Kragujevački)'),
(N'38220 Kosovska Mitrovica'),
(N'16206 Kosančić'),
(N'31260 Kosjerić'),
(N'38210 Kosovo Polje'),
(N'31254 Kostojevići'),
(N'12208 Kostolac'),
(N'32235 Kotraža'),
(N'11409 Kovačevac'),
(N'26210 Kovačica'),
(N'21243 Kovilj'),
(N'32257 Kovilje'),
(N'26220 Kovin'),
(N'34000 Kragujevac'),
(N'23231 Krajišnik'),
(N'22411 Kraljevci'),
(N'36000 Kraljevo'),
(N'22325 Krčedin'),
(N'31242 Kremna'),
(N'12316 Krepoljin'),
(N'17543 Kriva Feja'),
(N'37282 Kriva Reka'),
(N'24341 Krivaja'),
(N'19219 Krivelj'),
(N'19375 Krivi Vir'),
(N'22314 Krnješevci'),
(N'11319 Krnjevo'),
(N'18307 Krupac'),
(N'15314 Krupanj'),
(N'35227 Krušar'),
(N'25225 Kruščić'),
(N'31233 Kruščica'),
(N'22328 Krušedol'),
(N'37000 Kruševac'),
(N'18409 Kruševica'),
(N'12240 Kučevo'),
(N'21466 Kucura'),
(N'37255 Kukljin'),
(N'22224 Kukujevci'),
(N'25230 Kula'),
(N'18214 Kulina'),
(N'21472 Kulpin'),
(N'23271 Kumane'),
(N'37222 Kupci'),
(N'26368 Kupinik'),
(N'22419 Kupinovo'),
(N'25262 Kupusina'),
(N'18430 Kuršumlija'),
(N'18435 Kuršumlijska Banja'),
(N'11425 Kusadak'),
(N'26349 Kusić'),
(N'32258 Kušići'),
(N'35226 Kušiljevo'),
(N'26336 Kuštilj'),
(N'22223 Kuzmin'),
(N'22221 Laćarak'),
(N'37232 Laćisled'),
(N'36204 Lađevci'),
(N'14224 Lajkovac'),
(N'25234 Lalić'),
(N'18201 Lalinac'),
(N'34220 Lapovo'),
(N'34223 Lapovo Selo'),
(N'11550 Lazarevac'),
(N'23241 Lazarevo'),
(N'12321 Laznica'),
(N'16230 Lebane'),
(N'16248 Lece'),
(N'21207 Ledinci'),
(N'14205 Lelić'),
(N'19343 Lenovac'),
(N'37224 Lepenac'),
(N'17513 Lepenica'),
(N'38218 Leposavić'),
(N'38219 Lesak'),
(N'16000 Leskovac'),
(N'15307 Lešnica'),
(N'11309 Leštane'),
(N'22207 Lezimir'),
(N'18245 Lički Hanovi'),
(N'25232 Lipar'),
(N'11310 Lipe'),
(N'15305 Lipolist'),
(N'35274 Loćika'),
(N'21248 Lok'),
(N'26361 Lokve'),
(N'24322 Lovćenac'),
(N'15300 Loznica'),
(N'11317 Lozovik'),
(N'19208 Lubnica'),
(N'32240 Lučani'),
(N'21315 Lug'),
(N'11321 Lugavčina'),
(N'19234 Luka'),
(N'36306 Lukare'),
(N'23261 Lukićevo'),
(N'23224 Lukino Selo'),
(N'19371 Lukovo'),
(N'18437 Lukovo (kod Kuršumlije)'),
(N'31203 Lunovo Selo'),
(N'18228 Lužane'),
(N'34325 Lužnice'),
(N'14240 Ljig'),
(N'22255 Ljuba'),
(N'18217 Ljuberađa'),
(N'31209 Ljubiš'),
(N'15320 Ljubovija'),
(N'22321 Ljukovo'),
(N'24215 Ljutovo'),
(N'11261 Mala Moštanica'),
(N'31312 Mačkat'),
(N'22202 Mačvanska Mitrovica'),
(N'15211 Mačvanski Pričinović'),
(N'21473 Maglić'),
(N'23333 Majdan'),
(N'19250 Majdanpek'),
(N'12221 Majilovac'),
(N'15353 Majur'),
(N'35270 Majur (kod Jagodine)'),
(N'24217 Mala Bosna'),
(N'11313 Mala Krsna'),
(N'18423 Mala Plana'),
(N'18207 Malča'),
(N'34216 Male Pčelice'),
(N'24416 Male Pijace'),
(N'24309 Mali Beograd'),
(N'24321 Mali Iđoš'),
(N'19347 Mali Izvor'),
(N'19209 Mali Jasenovac'),
(N'11235 Mali Požarevac'),
(N'15318 Mali Zvornik'),
(N'12311 Malo Crniće'),
(N'34212 Malo Krčmare'),
(N'18415 Malošište'),
(N'22208 Manđelos'),
(N'16201 Manojlovce'),
(N'22327 Maradik'),
(N'26364 Margita'),
(N'11325 Markovac'),
(N'32243 Markovica'),
(N'34209 Maršić'),
(N'22222 Martinci'),
(N'24417 Martonoš'),
(N'36201 Mataruška Banja'),
(N'23234 Međa'),
(N'18209 Medoševac'),
(N'32255 Međurečje'),
(N'16240 Medveđa'),
(N'35224 Medveđa (kod Despotovca)'),
(N'37244 Medveđa (kod Trstenika)'),
(N'23270 Melenci'),
(N'11426 Meljak'),
(N'12305 Melnica'),
(N'18436 Merćez')		-- INSERT 1
INSERT INTO Grad (Tekst) VALUES 
(N'18445 Merdare'),
(N'18252 Merošina'),
(N'15233 Metlić'),
(N'19204 Metovnica'),
(N'11312 Mihajlovac (kod Smedereva)'),
(N'19322 Mihajlovac (Krajinski)'),
(N'23202 Mihajlovo'),
(N'35236 Mijatovac'),
(N'37227 Milentija'),
(N'21227 Mileševo'),
(N'26373 Miletićevo'),
(N'11318 Miloševac'),
(N'35268 Miloševo'),
(N'37246 Milutovac'),
(N'19340 Minićevo'),
(N'14242 Mionica'),
(N'11567 Mirosaljci'),
(N'16204 Miroševce'),
(N'24211 Mišićevo'),
(N'31251 Mitrovac'),
(N'11400 Mladenovac'),
(N'21422 Mladenovo'),
(N'32211 Mojsinje'),
(N'31243 Mokra Gora'),
(N'19317 Mokranja'),
(N'23305 Mokrin'),
(N'24435 Mol'),
(N'22256 Molovin'),
(N'22245 Morović'),
(N'21245 Mošorin'),
(N'18229 Mozgovo'),
(N'18251 Mramor'),
(N'26226 Mramorak'),
(N'32210 Mrčajevci'),
(N'17529 Muhovac'),
(N'23206 Mužlja'),
(N'21216 Nadalj'),
(N'23311 Nakovo'),
(N'34313 Natalinci'),
(N'19300 Negotin'),
(N'12242 Neresnica'),
(N'21314 Neštin'),
(N'23245 Neuzina'),
(N'22422 Nikinci'),
(N'19311 Nikolićevo'),
(N'26322 Nikolinci'),
(N'18000 Niš'),
(N'18366 Niševac'),
(N'18205 Niška Banja'),
(N'22203 Noćaj'),
(N'23218 Nova Crnja'),
(N'25224 Nova Crvenka'),
(N'21431 Nova Gajdobra'),
(N'22330 Nova Pazova'),
(N'31320 Nova Varoš'),
(N'22304 Novi Banovci'),
(N'23272 Novi Bečej'),
(N'23236 Novi Itebej'),
(N'22322 Novi Karlovci'),
(N'23330 Novi Kneževac'),
(N'23313 Novi Kozarci'),
(N'26353 Novi Kozjak'),
(N'36300 Novi Pazar'),
(N'21000 Novi Sad'),
(N'22323 Novi Slankamen'),
(N'24223 Novi Žednik'),
(N'35271 Novo Lanište'),
(N'23273 Novo Miloševo'),
(N'24351 Novo Orahovo'),
(N'18250 Novo Selo'),
(N'24311 Njegoševo'),
(N'11500 Obrenovac'),
(N'37266 Obrež'),
(N'22417 Obrež (Srem)'),
(N'21423 Obrovac'),
(N'25250 Odžaci'),
(N'22416 Ogar'),
(N'26230 Omoljica'),
(N'35267 Oparić'),
(N'26204 Opovo'),
(N'16233 Orane'),
(N'17557 Oraovica'),
(N'34308 Orašac'),
(N'24344 Orešković'),
(N'12308 Oreškovica'),
(N'15213 Orid'),
(N'23263 Orlovat'),
(N'24207 Orom'),
(N'12317 Osaonica'),
(N'14253 Osečina'),
(N'11314 Osipaonica'),
(N'19378 Osnić'),
(N'23326 Ostojićevo'),
(N'18312 Ostrovica'),
(N'11251 Ostružnica'),
(N'11212 Ovča'),
(N'32242 Ovčar Banja'),
(N'24342 Pačir'),
(N'11213 Padinska Skela'),
(N'23325 Padej'),
(N'37257 Padež'),
(N'26215 Padina'),
(N'24413 Palić'),
(N'18363 Palilula'),
(N'14213 Pambukovica'),
(N'26000 Pančevo'),
(N'24330 Panonija'),
(N'35250 Paraćin'),
(N'21434 Parage'),
(N'37201 Parunovac'),
(N'38266 Pasjane'),
(N'26333 Pavliš'),
(N'16251 Pečanjevce'),
(N'22410 Pećinci'),
(N'14207 Pecka'),
(N'18413 Pejkovac'),
(N'37231 Pepeljevac'),
(N'23260 Perlez'),
(N'31256 Perućac'),
(N'15304 Petlovača'),
(N'12300 Petrovac Na Mlavi'),
(N'21131 Petrovaradin'),
(N'11226 Pinosava'),
(N'18300 Pirot'),
(N'21469 Pivnice'),
(N'35247 Plana'),
(N'26360 Plandište'),
(N'19207 Planinica'),
(N'22420 Platičevo'),
(N'21428 Plavna'),
(N'35212 Plažane'),
(N'37238 Pleš'),
(N'37237 Ploča'),
(N'26229 Pločica'),
(N'24313 Pobeda'),
(N'37243 Počekovina'),
(N'14206 Poćuta'),
(N'36215 Podunavci'),
(N'19362 Podvis'),
(N'19321 Podvrška'),
(N'18326 Poganovo'),
(N'37214 Pojate'),
(N'12372 Poljana'),
(N'22428 Popinci'),
(N'18260 Popovac'),
(N'35254 Popovac (kod Paraćina)'),
(N'14221 Popučke'),
(N'12375 Porodin'),
(N'35207 Potočac'),
(N'12000 Požarevac'),
(N'31210 Požega'),
(N'19330 Prahovo'),
(N'32308 Pranjani'),
(N'16222 Predejane'),
(N'18365 Prekonoga'),
(N'32212 Preljina'),
(N'17523 Preševo'),
(N'35264 Prevešt'),
(N'22442 Prhovo'),
(N'31330 Priboj'),
(N'17511 Priboj Vranjski'),
(N'14251 Pričević'),
(N'25263 Prigrevica'),
(N'31300 Prijepolje'),
(N'32252 Prilički Kiseljak'),
(N'38213 Prilužje'),
(N'22257 Privina Glava'),
(N'15306 Prnjavor Mačvanski'),
(N'11280 Progar'),
(N'18400 Prokuplje'),
(N'18433 Prolom'),
(N'15215 Provo'),
(N'11413 Pružatovac'),
(N'18255 Pukovac'),
(N'22404 Putinci'),
(N'12254 Rabrovo'),
(N'18440 Rača'),
(N'34210 Rača Kragujevačka'),
(N'15321 Radalj'),
(N'22206 Radenković'),
(N'21225 Radičević'),
(N'11311 Radinac'),
(N'14211 Radljevo'),
(N'23221 Radojevo'),
(N'19334 Radujevac'),
(N'19314 Rajac'),
(N'14202 Rajković'),
(N'11327 Rakinac'),
(N'21299 Rakovac'),
(N'11233 Ralja'),
(N'34302 Ranilović'),
(N'38267 Ranilug'),
(N'12304 Ranovac'),
(N'12315 Rašanac'),
(N'35206 Raševica'),
(N'36350 Raška'),
(N'25283 Rastina'),
(N'37236 Rataje'),
(N'11411 Ratari'),
(N'36212 Ratina'),
(N'25253 Ratkovo'),
(N'18246 Ravna Dubrava'),
(N'35235 Ravna Reka'),
(N'31206 Ravni'),
(N'23212 Ravni Topolovac'),
(N'22205 Ravnje'),
(N'21471 Ravno Selo'),
(N'31265 Ražana'),
(N'37215 Ražanj'),
(N'37223 Razbojna'),
(N'16252 Razgojna'),
(N'35260 Rekovac'),
(N'17556 Reljan'),
(N'35237 Resavica'),
(N'34225 Resnik'),
(N'19214 Rgotina'),
(N'35220 Ribare (kod Jagodine)'),
(N'15310 Ribari'),
(N'36309 Ribarići'),
(N'37205 Ribarska Banja'),
(N'25280 Riđica'),
(N'11232 Ripanj'),
(N'17521 Ristovac'),
(N'26331 Ritisevo'),
(N'36205 Roćevci'),
(N'11453 Rogača'),
(N'31255 Rogačica'),
(N'31237 Roge'),
(N'19318 Rogljevo'),
(N'31208 Rožanstvo'),
(N'19257 Rudna Glava'),
(N'36353 Rudnica'),
(N'32313 Rudnik'),
(N'36222 Rudno'),
(N'11566 Rudovci'),
(N'22400 Ruma'),
(N'21201 Rumenka'),
(N'16223 Ruplje'),
(N'11194 Rušanj'),
(N'25233 Ruski Krstur'),
(N'23314 Rusko Selo'),
(N'18224 Rutevac'),
(N'23324 Sajan'),
(N'26206 Sakule'),
(N'19224 Salaš'),
(N'22204 Salaš Noćajski'),
(N'36202 Samaila'),
(N'26350 Samoš'),
(N'23331 Sanad'),
(N'11315 Saraorci'),
(N'16213 Sastav Reka'),
(N'31335 Sastavci'),
(N'19377 Savinac'),
(N'21467 Savino Selo'),
(N'31262 Seča Reka'),
(N'23240 Sečanj'),
(N'35211 Sedlare'),
(N'26203 Sefkerin'),
(N'21425 Selenča'),
(N'26351 Seleuš'),
(N'11407 Selevac'),
(N'24400 Senta'),
(N'35233 Senje'),
(N'35234 Senjski Rudnik'),
(N'31205 Sevojno'),
(N'22440 Sibač'),
(N'11454 Sibnica'),
(N'18311 Sićevo'),
(N'16246 Sijarinska Banja'),
(N'35256 Sikirica'),
(N'19225 Sikole'),
(N'21433 Silbaš'),
(N'12373 Simićevo'),
(N'35203 Siokovac'),
(N'19326 Sip'),
(N'36208 Sirča'),
(N'21214 Sirig'),
(N'31207 Sirogojno'),
(N'25223 Sivac'),
(N'36310 Sjenica'),
(N'11509 Skela'),
(N'11322 Skobaj'),
(N'26228 Skorenovac'),
(N'22318 Slankamenački Vinogradi'),
(N'32224 Slatina (kod čačka)'),
(N'14245 Slavkovica'),
(N'14223 Slovac'),
(N'11300 Smederevo'),
(N'11420 Smederevska Palanka'),
(N'18323 Smilovci'),
(N'12312 Smoljinac'),
(N'18230 Soko Banja'),
(N'25000 Sombor'),
(N'25264 Sonta'),
(N'36308 Sopoćani'),
(N'11450 Sopot'),
(N'22243 Sot'),
(N'21480 Srbobran'),
(N'12253 Srednjevo'),
(N'11253 Sremčica'),
(N'21208 Sremska Kamenica'),
(N'22000 Sremska Mitrovica'),
(N'22247 Sremska Rača'),
(N'21205 Sremski Karlovci'),
(N'22413 Sremski Mihaljevci'),
(N'23220 Srpska Crnja'),
(N'23233 Srpski Itebej'),
(N'23334 Srpski Krstur'),
(N'25244 Srpski Miletić'),
(N'23204 Stajićevo'),
(N'37212 Stalać'),
(N'25284 Stanišić'),
(N'25240 Stapar'),
(N'24340 Stara Moravica'),
(N'22300 Stara Pazova'),
(N'26232 Starčevo'),
(N'22305 Stari Banovci'),
(N'26371 Stari Lec'),
(N'22329 Stari Slankamen'),
(N'24224 Stari Žednik'),
(N'11324 Staro Selo (kod Velike Plane)'),
(N'14255 Stave'),
(N'22405 Stejanovci'),
(N'35215 Stenjevac'),
(N'21212 Stepanovićevo'),
(N'14234 Stepojevac'),
(N'34307 Stojnik'),
(N'37242 Stopanja'),
(N'34323 Stragari'),
(N'26345 Straža (Banat)'),
(N'18332 Strelac'),
(N'35269 Strižilo'),
(N'11507 Stubline'),
(N'36343 Studenica'),
(N'24000 Subotica'),
(N'35209 Subotica (kod Svilajnca)'),
(N'18227 Subotinac'),
(N'22414 Subotište'),
(N'18322 Sukovo'),
(N'19376 Sumrakovac'),
(N'35228 Supska'),
(N'11271 Surčin'),
(N'22307 Surduk'),
(N'17530 Surdulica'),
(N'21313 Susek'),
(N'23244 Sutjeska'),
(N'12322 Suvi Do'),
(N'17508 Sveti Ilija'),
(N'25211 Svetozar MiIetić'),
(N'35210 Svilajnac'),
(N'15221 Svileuva'),
(N'25265 Svilojevo'),
(N'16212 Svođe'),
(N'18360 Svrljig'),
(N'35259 Svojnovo'),
(N'15000 Šabac'),
(N'21244 Šajkaš'),
(N'19373 Šarbanovac'),
(N'22425 Šašinci'),
(N'11433 Šepšin'),
(N'12309 Šetonje'),
(N'22240 Šid'),
(N'32311 Šilopaj'),
(N'22310 Šimanovci'),
(N'31244 Šljivovica'),
(N'37239 Šljivovo'),
(N'36311 Štavalj'),
(N'15354 Štitar'),
(N'19303 Štubik'),
(N'23254 Šurjan'),
(N'32304 Takovo'),
(N'23209 Taraš'),
(N'24214 Tavankut'),
(N'15234 Tekeriš'),
(N'19325 Tekija'),
(N'25222 Telečka'),
(N'21235 Temerin'),
(N'18355 Temska'),
(N'18212 Tešica'),
(N'21240 Titel'),
(N'23222 Toba'),
(N'23262 Tomaševac'),
(N'34310 Topola'),
(N'12226 Topolovnik'),
(N'34243 Toponica'),
(N'23214 Torda'),
(N'24352 Tornjoš'),
(N'21424 Tovariševo'),
(N'32205 Trbušani'),
(N'24426 Trešnjevac'),
(N'35248 Trešnjevica'),
(N'17525 Trgovište'),
(N'32221 Trnava (kod (čačka)'),
(N'37235 Trnavci'),
(N'19306 Trnjane'),
(N'37240 Trstenik'),
(N'15303 Tršić'),
(N'18211 Trupale'),
(N'16247 Tulare'),
(N'16231 Turekovac'),
(N'12257 Turija (kod Kučeva)'),
(N'21215 Turija'),
(N'36320 Tutin'),
(N'14210 Ub'),
(N'36313 Ugao'),
(N'32314 Ugrinovci'),
(N'11277 Ugrinovci (kod Batajnice)'),
(N'26330 Uljma'),
(N'11430 Umčari'),
(N'11260 Umka'),
(N'19305 Urovica'),
(N'24437 Utrine'),
(N'36342 Ušće'),
(N'26216 Uzdin'),
(N'15319 Uzovnica'),
(N'31000 Užice'),
(N'21426 Vajska'),
(N'14000 Valjevo'),
(N'31263 Varda 031'),
(N'15232 Varna (kod Šapca)'),
(N'37260 Varvarin'),
(N'19367 Vasilj'),
(N'26337 Vatin'),
(N'22241 Vašica'),
(N'19328 Velesnica'),
(N'37245 Velika Drenova'),
(N'16221 Velika Grabovica'),
(N'26366 Velika Greda'),
(N'11414 Velika Ivanča'),
(N'11408 Velika Krsna'),
(N'37209 Velika Lomnica'),
(N'18305 Velika Lukanja'),
(N'11206 Velika Moštanica'),
(N'11320 Velika Plana'),
(N'18403 Velika Plana (Toplička)'),
(N'15322 Velika Reka'),
(N'37233 Velika Vrbnica'),
(N'23217 Velike Livade'),
(N'11462 Veliki Borak'),
(N'14233 Veliki Crljeni'),
(N'26365 Veliki Gaj'),
(N'19206 Veliki lzvor'),
(N'35223 Veliki Popović'),
(N'22211 Veliki Radinci'),
(N'37204 Veliki Šiljegovac'),
(N'18217 Veliko Bonjince'),
(N'12220 Veliko Gradište'),
(N'12306 Veliko Laole'),
(N'11323 Veliko Orašje'),
(N'12314 Veliko Selo'),
(N'26334 Veliko Središte'),
(N'34306 Venčane'),
(N'21203 Veternik'),
(N'32233 Viča'),
(N'21246 Vilovo'),
(N'19368 Vina'),
(N'16207 Vinarce'),
(N'32254 Vionica'),
(N'18306 Visočka Ržana'),
(N'24222 Višnjevac'),
(N'22246 Višnjićevo'),
(N'36206 Vitanovac'),
(N'36207 Vitkavac'),
(N'22431 Vitojevci'),
(N'37213 Vitoševac'),
(N'17510 Vladičin Han'),
(N'15225 Vladimirci'),
(N'26315 Vladimirovac'),
(N'26332 Vlajkovac'),
(N'17507 Vlase'),
(N'17532 Vlasina Okruglica'),
(N'17533 Vlasina Rid'),
(N'17534 Vlasina Stojkovićeva'),
(N'16210 Vlasotince'),
(N'11406 Vlaška'),
(N'12371 Vlaški Do'),
(N'11328 Vodanj'),
(N'22429 Voganj'),
(N'22313 Vojka'),
(N'35208 Vojska'),
(N'23219 Vojvoda Stepa'),
(N'12256 Voluja'),
(N'32315 Vraćevšnica'),
(N'26348 Vračev Gaj'),
(N'11427 Vranić'),
(N'11329 Vranovo'),
(N'17000 Vranje'),
(N'17542 Vranjska Banja'),
(N'19344 Vratamica'),
(N'19312 Vražogrnac'),
(N'36214 Vrba'),
(N'21460 Vrbas'),
(N'23329 Vrbica'),
(N'11224 Vrčin'),
(N'22408 Vrdnik'),
(N'14230 Vreoci'),
(N'36210 Vrnjačka Banja'),
(N'36217 Vrnjci'),
(N'26300 Vršac'),
(N'16203 Vučje'),
(N'32223 Zablaće'),
(N'34244 Zabojnica'),
(N'11505 Zabrežje'),
(N'26344 Zagaljica'),
(N'15315 Zajača'),
(N'19000 Zaječar'),
(N'22201 Zasavica'),
(N'15312 Zavlaka'),
(N'37203 Zdravinje'),
(N'11080 Zemun'),
(N'31315 Zlatibor'),
(N'31253 Zlodol'),
(N'19215 Zlot'),
(N'21213 Zmajevo'),
(N'23000 Zrenjanin'),
(N'11225 Zuce'),
(N'19227 Zvezdan'),
(N'18333 Zvonce'),
(N'21230 Žabalj'),
(N'12374 Žabari'),
(N'12320 Žagubica'),
(N'11250 Železnik'),
(N'23210 Žitište'),
(N'18210 Žitkovac'),
(N'18407 Žitni Potok'),
(N'18412 Žitorađa'),
(N'18348 Žuć')		-- INSERT 2
UPDATE Grad SET PTT=LEFT(tekst,5);							-- INSERT-ovanje PTT
UPDATE Grad SET Naziv=SUBSTRING(tekst,7,LEN(tekst));	-- INSERT-ovanje Naziv
ALTER TABLE Grad
ALTER COLUMN Naziv nvarchar(50) NOT NULL						-- Naziv - NOT NULL CONSTRAINT
ALTER TABLE Grad
ALTER COLUMN PTT varchar(10) NOT NULL						-- PTT - NOT NULL CONSTRAINT
ALTER TABLE Grad
DROP COLUMN Tekst						-- DROP COLUMN Tekst
--SELECT * FROM Grad WHERE Naziv=N'Čačak'

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
	USE ShopV1_6
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
			SELECT * FROM Artikal
		END
		ELSE
		BEGIN
			SELECT * FROM Artikal WHERE KatArtID=@cat
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
	IF NOT EXISTS(SELECT * FROM Artikal WHERE DobavljacId=@supplierId)
	BEGIN
		DELETE FROM Dobavljac
		WHERE Dobavljac.ID=@supplierId
	END
	ELSE
	BEGIN
		RETURN '1'
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
	IF NOT EXISTS((SELECT * FROM Fakture WHERE ProdavnicaID=@shopId)) AND NOT EXISTS((SELECT * FROM Stanje WHERE ProdavnicaID=@shopId))
	BEGIN
		IF(SELECT SUM(Kolicina) FROM Stanje WHERE ProdavnicaID=@shopId)=0
		BEGIN
			DELETE FROM Stanje WHERE ProdavnicaID=@shopId
			DELETE FROM Prodavnica	WHERE Prodavnica.ID=@shopId
		END
		ELSE
		BEGIN
			RETURN '1'
		END
	END
	ELSE
	BEGIN
		RETURN '1'
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
		RETURN '1'
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
	IF NOT EXISTS (SELECT * FROM Artikal WHERE KatArtID=@catArtId)
	BEGIN
		DELETE FROM KatArt WHERE KatArt.ID=@catArtId
	END
	ELSE
	BEGIN
		RETURN '1'
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
	IF (NOT EXISTS (SELECT * FROM Fakture WHERE ArtikalID=@artId)) AND (SELECT SUM(Kolicina) FROM Stanje WHERE ArtikalID=@artId)=0
	BEGIN
		IF(SELECT SUM(Kolicina) FROM Stanje WHERE ArtikalID=@artId)=0
		BEGIN
			DELETE FROM Stanje WHERE ArtikalID=@artId
			DELETE FROM Artikal WHERE Artikal.ID=@artId
		END
		ELSE
		BEGIN
			RETURN '1'
		END
	END
	ELSE
	BEGIN
		RETURN '1'
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