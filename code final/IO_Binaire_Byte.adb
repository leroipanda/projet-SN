with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Sequential_IO;

-- Cette procedure illustre l'enregistrement d'un code binaire 
-- dans une variable de type modulaire ADA representant un octet.
-- On utilise pour cela le schema de Horner.
-- Ici, on utilise cherche a enregistrer le mot binaire 1011 dans 
-- un octet. 
--
-- 1001 = ((((0 * 2) + 1) * 2 + 0) * 2 + 1) * 2 + 1
-- selon le schema de Horner
-- Elle présente aussi l'écriture de ce code dans un fichier au
-- format binaire en utilisant la bibliothèque Ada.Sequential_IO
-- Cette solution enregistre chaque octet dans un octet du fichier binaire.

procedure IO_Binaire_Byte is
	-- On definit un type modulaire qui represente un octet
	-- Il prend des valeurs entieres entre 0 et 255
	type t_byte is mod 2**8;
	
    -- Package pour lire/ecrire un t_byte sur l'entrée standard.
    -- A ne pas utiliser pour lire/écrire dans un fichier.
	package Mod_IO is new Ada.Text_IO.Modular_IO(t_byte);
	use Mod_IO;
	
	-- Package pour lire/écrire un t_byte en binaire dans un fichier.
	package Bin_IO is new Ada.Sequential_IO(t_byte);
	use Bin_IO;	

    procedure afficher_octet_bit_a_bit(code: in t_byte) is
	-- Affiche un octet bit à bit en
	-- commencant par le plus a gauche
	octet, bit : t_byte;
	begin
		octet := code;
		for i in 1..8 loop
			bit := octet / 2**7;
			Mod_IO.put(bit);
			octet := octet * 2;
		end loop;
		put_line("");
	end afficher_octet_bit_a_bit;

	procedure put_octet(file : in Bin_IO.File_Type; code : in t_byte) is
	-- Ecrit un code enregistré dans un octet en fin de fichier
	-- file : descripteur du fichier ouvert en ecriture
	-- code : code à ecrire en fin de fichier
	begin
		Bin_IO.write(file, code);
	end put_octet; 

	procedure get_octet(file : in Bin_IO.FILE_TYPE; code : out t_byte) is
	-- Lecture du prochain code enregistre dans le fichier
	-- file : descripter de fichier ouvert en lecture
	-- code : code lu
	begin 
		Bin_IO.read(file, code);
	end get_octet;

	-- Codes binaires, initialisés a 0
	code, code_lu, phrase, phrase_lu : t_byte := 0;
	-- Le descripteur de fichier;
	file : Bin_IO.File_Type;

begin
put_line("");
    put_line("Creation du code 00001011");
	-- Ajout du premier bit '1' à droite
	code := (code * 2) + 1;
	afficher_octet_bit_a_bit(code);

	-- Ajout du 2eme bit '0' à droite
	code := (code * 2) + 0;
	afficher_octet_bit_a_bit(code);

	-- Ajout du 3eme bit '1'
	code := (code * 2) + 1;
	afficher_octet_bit_a_bit(code);
	
	-- Ajout du 4eme bit '1'
	code := (code * 2) + 1;
	afficher_octet_bit_a_bit(code);

    -- Affichage de l'octet en décimal avec Mod_IO
    put("   Affichage de l'octet en décimal avec Mod_IO : ");
    Mod_IO.put(code);
    put_line("");
    put_line("");

	-- On souhaite concatener le meme code dans un seul octet
    put_line("Concatenation des deux codes 1011 dans un seul octet: ");
	phrase := code * 2**4; 		-- on recopie et on decale à gauche
	phrase := phrase + code; 	-- on ajoute les 4 bits de poids faible
	afficher_octet_bit_a_bit(phrase);
    put("   Affichage de l'octet en décimal avec Mod_IO : ");
    Mod_IO.put(phrase);
    put_line("");
    put_line("");

	-- Ecriture des deux codes (code et phrase) dans un fichier
	-- file est une reference sur le flux permettant d'ecrire dans le fichier
    -- Out_File signifie que le flux est ouvert en ecriture
    put_line("Ecriture et lecture des codes 00001011, 10111011 dans un fichier binaire : ");
	create(file, Out_File, "donnees.txt.hf");	-- creation du fichier
	put_octet(file, code);
	put_octet(file, phrase);
	-- Fermetude du fichier
	close(file);

	-- lecture et affichage des deux codes, octet par octet
    open(file, In_File, "donnees.txt.hf");
	get_octet(file, code_lu);
    get_octet(file, phrase_lu);
    close(file);
    afficher_octet_bit_a_bit(code_lu);
    afficher_octet_bit_a_bit(phrase_lu);

    -- ouverture du fichier pour y ecrire à la fin à nouveau un octet
    open(file, Append_File, "donnees.txt.hf");    -- creation du fichier
    put_octet(file, phrase);
    close(file);

end IO_Binaire_Byte;
