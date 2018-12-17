with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Sequential_IO;

-- Cette procedure illustre l'écriture d'un code binaire
-- à l'aide de variables de type modulaire ADA.
-- Ici, on enregistre le mot binaire 011 dans un fichier, puis on les
-- relit pour les afficher sur la sortie standard.
--
-- On crée un type t_bit qui est généré par un constructeur de type modulaire
-- ADA qui prend ses valeurs dans une base 2. Les valeur 0 et 1 sont donc
-- les seules admissibles.
-- La somme de deux variables se fait modulo 2 dans ce cas.
--
-- Attention: cette solution simplifiée enregistre chaque 'bit' dans un octet.

procedure IO_Binaire_Bit is
	-- On definit un type modulaire qui represente un bit
	-- Il prend des valeurs entieres 0 ou 1.
	type t_bit is mod 2;

	-- Package pour lire et ecrire des donnees binaires dans un fichier
	package Bin_IO is new Ada.Sequential_IO(t_bit);
  use Bin_IO;

	-- Package pour lire et ecrire le type modulaire t_bit sur
	-- les entrees/sorties standard
	package ES_IO is new Ada.Text_IO.Modular_IO(t_bit);
	use ES_IO;

	bw_1, bw_2, bw_3 : t_bit := 0; 	-- bits ecrits
	br_1, br_2, br_3 : t_bit := 0;		-- bits lus

	-- Le descripteur de fichier pour un fichier binaire;
	file : Bin_IO.File_Type;


begin
	bw_1 := 0;
	bw_2 := 1;
	bw_3 := 1;

	-- Ecriture des trois bits dans un fichier au format binaire
	-- file est une reference sur le flux permettant d'ecrire dans le fichier
	-- qui se nomme "donnee.txt.hf"
	-- Out_File signifie que le flux est ouvert en ecriture
	create(file, Out_File, "donnees.txt.hf");	-- creation du fichier
	Bin_IO.write(file, bw_1);
	Bin_IO.write(file, bw_2);
	Bin_IO.Write(file, bw_3);
	-- Fermetude du fichier
	close(file);


	-- lecture et affichage des bits ecrits
	open(file, In_File, "donnees.txt.hf");
	Bin_IO.Read(file, br_1);
	ES_IO.put(br_1);
	Bin_IO.Read(file, br_2);
	ES_IO.put(br_2);
	Bin_IO.Read(file, br_3);
	ES_IO.put(br_3);
	put_line("");

	-- lecture du caractere EOF
	if End_Of_File(file) then
		put_line("fin du fichier");
	end if;
	put_line("");
	close(file);


end IO_Binaire_Bit;
