with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;

procedure IO_Texte is

	-- descripteur de fichier texte (Ada.Text_IO)
	file : Ada.Text_IO.file_type;
	un_char : character;
	str : string(1..8);
begin
	-- Affichage des arguments de la ligne de commande
	new_line;
	put("---- Arguments de la ligne de commande : ");
	put(Argument_Count);
	put_line(" arguments.");
	for i in 1 .. Argument_Count loop
		put("Argument");
		put(i);
		put(" : ");
		put_line(Argument(i));
	end loop;
	new_line(2);

	if Argument_Count >=1 then
		-- Affichage du texte contenu dans le fichier en argument 1.
		put("---- Lecture des caracteres du fichier ");
		put_line(Argument(1));
		begin
		-- Ouverture du fichier
		-- Nom du fichier donne dans le premier argument.
		open(file, In_File, Argument(1));
		-- On lit chaque caractere et on l'affiche.


		-- Note: Ici on n'affiche pas les retour chariot \n car Get() ne les retourne pas.
		-- Pour les detecter, on peut utiliser end_of_line(file)
		loop
			if not end_of_file(file) then
      				Get(file, un_char);
      				Put(un_char);
			end if;
		exit when end_of_file(file);
		end loop;
		close(file);

		exception
			when ADA.IO_EXCEPTIONS.NAME_ERROR =>
				put_line("Fichier non present - donner le nom d'un fichier en argument");
		end;
	end if;
	new_line(2); 	-- on saute 2 ligne

	-- Ecriture d'un texte dans un nouveau fichier
	put_line("---- Ecriture dans un nouveau fichier 'nouveau_texte'");
	create(file, Out_File, "nouveau_texte");
	put(file,'n');
	put(file,'e');
	put(file,'w');
	new_line(file);
	close(file);

	-- Re-ouverture du fichier pour y écrire la fin d'un texte
	open(file, Append_File, "nouveau_texte");
	put(file,' ');
	put(file,'t');
	put(file,'e');
	put(file,'x');
	put(file,'t');
	close(file);

	-- Lecture d'une chaine de caractere (attention il faut connaitre la taille de la chaine !)
	open(file, In_File, "nouveau_texte");
	get(file, str);
	put_line("---- Texte lu dans le nouveau fichier");
	put(str);
	new_line(2);
	close(file);

end IO_Texte;
