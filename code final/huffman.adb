with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed;  use Ada.Strings.Fixed;
with tree; use tree;
with writer;
with reader;
with tableaux;
with Ada.Sequential_IO;
with Ada.IO_Exceptions;

package body huffman is


    procedure Compress(file_name : in String) is

	package Writer_Compress is
		new writer(file_name);
	use Writer_Compress;

	type T_Cell is record
	    char : Character;
	    code : T_Code;
	end record;

	package Tab_Leaf is
		new tableaux(T_Tree, 127);
	use Tab_Leaf;

	package Tab_Cell is
		new tableaux(T_Cell, 127);
	use Tab_Cell;

	package Mod_IO is
		new Ada.Text_IO.Modular_IO(T_Byte);
	use Mod_IO;

	function Get_Code(Tab : in Tab_Cell.T_Tableau; Char : in Character) return T_Code is
	    i : Integer;
	    find : Boolean;
	begin
	    i := 1;
	    find := false;
	    while i <= Get_Size(Tab) and not find loop
		if Get_Element(Tab, i).char = Char then
		    find := true;
		else
		    i := i + 1;
		end if;
	    end loop;
	    return Get_Element(Tab, i).code;
	end;


	procedure Display_Octet(code: in T_Code) is
	    octet, bit : t_byte;
	begin
	    octet := code.byte;
	    for i in 1..8 loop
		bit := octet / 2**7;
		if i > (8 - code.length) then
		    Mod_IO.put(bit,1);
		end if;
		octet := octet * 2;
	    end loop;
	    New_Line;
	end;


	function Create_Tab_Frequency(file_name : in String) return Tab_Leaf.T_Tableau is

	    procedure Setup_Tab_Frequency(Tab : out Tab_Leaf.T_Tableau) is
		Leaf : T_Tree;
	    begin
		Initialize(Tab);
		for i in 1 .. 127 loop
		    Leaf := Create_Leaf(Character'Val(i));
		    Add(Tab, Leaf);
		end loop;
	    end;

	    procedure Analyze_File(file_name : in String; Tab : in out Tab_Leaf.T_Tableau) is
		file : Ada.Text_IO.file_type;
		c : Character;
		Leaf : T_Tree;
	    begin
		open(file, In_File, file_name);
		loop
		    if not end_of_file(file) then
			Get(file, c);
			Leaf := Get_Element(Tab, Character'Pos(c));
			Add_Occurence(Leaf);
		    end if;
		    if End_Of_Line(file) then
			Leaf := Get_Element(Tab, Character'Pos('\'));
			Add_Occurence(Leaf);
			Leaf := Get_Element(Tab, Character'Pos('n'));
			Add_Occurence(Leaf);
		    end if;
		    exit when end_of_file(file);
		end loop;
		close(file);
	    end;

	    Tab : Tab_Leaf.T_Tableau;
	begin
	    Setup_Tab_Frequency(Tab);
	    Analyze_File(file_name, Tab);
	    return Tab;
	end;


	function Build_Tree_Huffman(Tab : in out Tab_Leaf.T_Tableau) return T_Tree is

	    function Is_Inf(a, b : T_Tree) return Boolean is
	    begin
		return Get_Occurence(a) < Get_Occurence(b);
	    end;

	    procedure Quick_Sort is new Tab_Leaf.Sort(Compare => Is_Inf);

	    procedure Clean_Tab(Tab : in out Tab_Leaf.T_Tableau) is
		Element : T_Tree;
	    begin
		loop
		    Element := Get_Element(Tab, 1);
		    if Get_Occurence(Element) = 0 then
			Delete(Tab, 1);
		    end if;
		    exit when Get_Occurence(Element) /= 0;
		end loop;
	    end;


	    a, b, Node : T_Tree;
	begin
	    Quick_Sort(Tab);
	    Clean_Tab(Tab);
	    loop
		a := Get_Element(Tab, 1);
		b := Get_Element(Tab, 2);
		Delete(Tab, 1);
		Delete(Tab, 1);
		Node := Bind(a, b);
		Add(Tab, Node);
		Quick_Sort(Tab);
		exit when Get_Size(Tab) = 1;
	    end loop;
	    return Get_Element(Tab, 1);
	end;


	function Build_Tab_Huffman(Tree : in T_Tree) return Tab_Cell.T_Tableau is

	    procedure Tab_Recur(Tree : in T_Tree; code : in out T_Code; Tab : out Tab_Cell.T_Tableau) is
		Cell : T_Cell;
		Save : T_Byte;
	    begin
		if not Is_Node(Tree) then
		    if code.length > 8 then
			code.length := 8;
		    end if;
		    Cell.char := Get_Character(Tree);
		    Cell.code := code;
		    Add(Tab, Cell);
		else
		    code.length := code.length + 1;
		    save := code.byte;
		    code.byte := (code.byte * 2) + 0 ;
		    Tab_Recur(Get_Children_Left(Tree), code, Tab);
		    code.byte := save;
		    code.byte := (code.byte * 2) + 1 ;
		    Tab_Recur(Get_Children_Right(Tree), code, Tab);
		    code.length := code.length - 1;
		end if;
	    end;

	    code : T_Code := (0, 0);
	    Tab : Tab_Cell.T_Tableau;
	begin
	    Initialize(Tab);
	    Tab_Recur(Tree, code, Tab);
	    return Tab;
	end;


	procedure Display_Tree(Tree : in T_Tree) is

	    procedure Display_Tree_Recur(Tree : in T_Tree; n : in out Integer) is
	    begin
		if not Is_Node(Tree) then
		    Put('(');
		    Put(Get_Occurence(Tree), 1);
		    Put(") ");
		    Put(''');
		    Put(Get_Character(Tree));
		    Put(''');
		else
		    Put('(');
		    Put(Get_Occurence(Tree), 1);
		    Put(") ");
		    New_Line;
		    Put(n * "        ");
		    n := n + 1;
		    Put("\--");
		    Put("0");
		    Put("-- ");
		    Display_Tree_Recur(Get_Children_Left(Tree), n);
		    New_Line;
		    n := n - 1;
		    Put(n * "        ");
		    n := n + 1;
		    Put("\--");
		    Put("1");
		    Put("-- ");
		    Display_Tree_Recur(Get_Children_Right(Tree), n);
		    n := n - 1;
		end if;
	    end;

	    n : Integer := 0;
	begin
	    Put_Line("============[ Version textuelle de l'arbre d'Huffman ]============");
	    New_Line;
	    Display_Tree_Recur(Tree, n);
	    New_Line(2);
	    Put_Line("===================================================================");
	end;


	procedure Display_Tab(Tab : in Tab_Cell.T_Tableau) is
	    Cell : T_Cell;
	begin
	    Put_Line("============[ Version textuelle de la table de Huffman ]============");
	    New_Line;
	    for i in 1 .. Get_Size(Tab) loop
		Cell := Get_Element(Tab, i);
		Put(''' & Cell.char & ''');
		Put(" -> ");
		Display_Octet(Cell.code);
	    end loop;

	    New_Line;
	    Put_Line("===================================================================");
	end;


	procedure Compress_file(file_name : in String ; Tree : in T_Tree ; Tab_Huffman : in Tab_Cell.T_Tableau) is

	    procedure Write_Tab_Size(Tab : in Tab_Cell.T_Tableau) is
	    begin
		Write_Integer(Get_Size(Tab));
	    end;

	    procedure Write_Char_Tree(Tab : in Tab_Cell.T_Tableau) is
		element : T_Cell;
	    begin
		for i in 1..Get_Size(Tab) loop
		    element := Get_Element(Tab, i);
		    Write_Integer(Character'Pos(element.char));
		end loop;
	    end;

	    procedure Write_Description_Tree(Tree : in T_Tree ; Tab : in Tab_Cell.T_Tableau) is

		procedure Write_Description_Tree_Recur(Tree : in T_Tree ; n : in out Integer ; max : in Integer) is
		begin
		    if not Is_Node(Tree) then
			n := n + 1;
		    else
			Write_Bit(0);
			Write_Description_Tree_Recur(Get_Children_Left(Tree), n, max);
			Write_Bit(1);
			Write_Bit(0);
			Write_Description_Tree_Recur(Get_Children_Right(Tree), n, max);
			if n < max then
			    Write_Bit(1);
			end if;
		    end if;
		end;

		n : Integer := 0;
		max : Integer := Get_Size(Tab);
	    begin
		Write_Description_Tree_Recur(Tree, n, max);
		Write_Bit(1);
		Force_Write_Buffer;
	    end;

	    procedure Write_Text(file_name : in String) is
		file : Ada.Text_IO.file_type;
		c : Character;
	    begin
		open(file, In_File, file_name);
		loop
		    if not End_Of_File(file) then
			Get(file, c);
			Write_Byte(Get_Code(Tab_Huffman, c));
		    end if;
		    if End_Of_Line(file) then
			Write_Byte(Get_Code(Tab_Huffman, '\'));
			Write_Byte(Get_Code(Tab_Huffman, 'n'));
		    end if;
		    exit when end_of_file(file);
		end loop;
		close(file);
		Force_Write_Buffer;
	    end;



	begin

	    -- Créer le nouveau fichier .txt.hf
	    Create_Compressed_File;

	    -- On écrit la taille du texte sur 4 octets
	    Write_Text_Size;

	    -- On écrit la taille de l'arbre sur 1 octet
	    Write_Tab_Size(Tab_Huffman);

	    -- On écrit chacun des caractère de l'arbre (parcours infixe, en profondeur) pour 1 octet par charactère
	    Write_Char_Tree(Tab_Huffman);

	    -- On écrit la description de l'arbre
	    Write_Description_Tree(Tree, Tab_Huffman);

	    -- On écrit le texte
	    Write_Text(file_name);

	    Close_Compressed_File;
	    -- Coder le texte dans le fichier compressé

	end;


	Tab_Frequency : Tab_Leaf.T_Tableau;
	Tab_Huffman : Tab_Cell.T_Tableau;
	Arbre : T_Tree;
    begin

	-- Création du tableau des occurences
	Tab_Frequency := Create_Tab_Frequency(file_name);

	-- Construction de l'arbre
	Arbre := Build_Tree_Huffman(Tab_Frequency);

	-- Construction de la table de huffman
	Tab_Huffman := Build_Tab_Huffman(Arbre);

	-- Affichage de l'arbre et de la table de huffman
	Display_Tree(Arbre);
	New_Line(2);
	Display_Tab(Tab_Huffman);

	-- Compression du fichier
	Compress_file(file_name, Arbre, Tab_Huffman);

	-- Destruction de l'arbre
	Clean_Up(Arbre);

    exception
	when ADA.IO_EXCEPTIONS.NAME_ERROR =>
	    put_line("Fichier non present - donner le nom d'un fichier en argument");

    end;



    procedure Uncompress(file_name : in String) is

	package Reader_Uncompress is
		new reader(file_name);
	use Reader_Uncompress;

    begin

	-- Text_Size

	-- Tab_Size
	-- {tableau créé}

	-- Ajout des caractères dans le tableau

	-- Ajout du code des caractères dans la tableau

	-- Décriptage + écrit dans le ficher .txt


	null;

    end;



    procedure Decompression_juste(file_name : String) is

	PACKAGE P_integer_file IS NEW Ada.Sequential_IO(T_bit) ;
	USE P_integer_file ;



	Fichier : P_integer_file.File_type ;
	nouveau_Fichier : Ada.Text_IO.File_Type;
	Taille_table :constant Integer := 257;
	Taille_octet :constant Integer := 8;
	Taille_texte_encode :constant Integer :=4;
	Taille_arbre_encode :constant Integer :=1;
	cara_test :constant Character :='@' ;
	taille_texte : integer;
	taille_arbre : integer;
	nom : String := "test1.txt";
	Type T_Tableau is array(1..Taille_table) of Character ;
	Type T_Table is array(1..Taille_octet) of T_Tableau;

	Table : T_Table;

    begin
	--ouverture et lecture du contenus du fichier( in : string nomfichier, out : File_type fichier)
	P_integer_file.open(Fichier,In_File, "jerome.txt.hf") ;

	--on itialise la table
	for i in 1..Taille_octet loop
	    for j in 1..Taille_table loop

		Table(i)(j) := cara_test;  --caractere non present dans la table ascii
	    end  loop;

	end loop;

	--extraction de la table ( in fichier, out tableau de tableau charactere table)

	declare
	    function lire_octet(nombre :in integer) return integer is
		valeur :integer:=0;
		valeur_lu : T_bit;
	    begin

		for i in 1..nombre*8 loop
		    read(Fichier,valeur_lu);

		    if Integer(valeur_lu) = 1 then
			valeur := valeur*2 + 1;
		    else
			valeur := valeur*2 ;
		    end if;

		end loop;
		--  put(integer'Image(valeur));
		return valeur;
	    end lire_octet;

	    type position is (Droite,Gauche,noeuds);
	    nb_caractere : Integer:=0;
	    caractere_traduit : Integer:=0;
	    tableau_cara : T_Tableau;
	    valeur : integer:=0;
	    valeur_lu :T_bit;
	    memoire :boolean := False;
	    taille : integer :=0;
	    position_arbre : position := Droite;



	begin
	    --lecture de la taille texte
	    taille_texte := lire_octet(Taille_texte_encode);

	    --lecture de taille arbre
	    taille_arbre := lire_octet(Taille_arbre_encode);
	    --lecture des caractere

	    for i in 1..taille_arbre loop
		tableau_cara(i) := Character'Val(lire_octet(1));
	    end loop;
	    --
	    --put_line("lecture parcour");
	    --on lit le parcour de l'arbre
	    while caractere_traduit /= taille_arbre loop
		read(Fichier,valeur_lu);
		-- put_line("bit lu : " & integer'Image(integer(valeur_lu)) & " valeur : " & integer'Image(valeur));
		if integer(valeur_lu) = 0 then
		    if position_arbre = noeuds then
			position_arbre := gauche;
		    end if;

		    taille := taille +1;
		    if position_arbre = droite then
			valeur := valeur*2 ;

		    else --gauche
			valeur := valeur *2 + 1 ;
			position_arbre := Droite;
		    end if ;


		else  -- valeur_lu = 1


		    if position_arbre /= noeuds  then

			--on enregistre
			caractere_traduit := caractere_traduit+1;
			table(taille)(valeur+1) := tableau_cara(caractere_traduit);
			--put_line( character'Image(tableau_cara(caractere_traduit)) & " = " & Integer'Image(valeur) );
			position_arbre := noeuds ; --je suis maintenant sur un noeuds


		    end if;
		    taille := taille -1;
		    valeur := valeur / 2 ;
		end if;
	    end loop ;


	end;
	--affichage de la table
	--for i in 1..Taille_octet loop
	--for j in 1..Taille_table loop
	--if table(i)(j) /= '@' then
	--put_line("taille : " & integer'Image(i) & " valeur : " & integer'Image(j) &" "& character'Image(table(i)(j) ));
	--     end if;
	--end loop;
	--end loop;




	--la table est corectement remplis maintenant
	--il reste plus que à decompresse le contenu maitenant
	declare

	    valeurHuffman : Integer;
	    taille : Integer:=1;
	    taille_texte_lu:integer :=0;
	    convertie : Boolean;
	    inte_lu :  T_bit ;


	begin
	    --on passe un ligne du fichier

	    create(nouveau_Fichier,Out_File,nom) ;

	    while not   P_integer_file.End_of_file(Fichier) loop
		--  while taille_texte_lu < taille_texte loop
		convertie := false;
		taille := 1;
		valeurHuffman :=0;
		while not convertie loop
		    read(fichier, inte_lu);
		    if Integer(inte_lu )= 1 then
			valeurHuffman := valeurHuffman *2   +1 ;
		    else
			valeurHuffman := valeurHuffman *2   ;
		    end if;
		    --put_line("bit lu : " & integer'Image(integer(inte_lu)) & " valeur : " & integer'Image(valeurHuffman));
		    if Table(taille)(valeurHuffman+1) /=  cara_test  then
			--Put_Line("---entree---");
			--Put_Line(Character'Image(Table(taille)(valeurHuffman+1)));
			Put(nouveau_Fichier,Table(taille)(valeurHuffman+1));
			convertie := True;
		    end if;
		    taille := taille+1;

		end loop;
		taille_texte_lu := taille_texte_lu + taille -1;
		--put_line(integer'image(taille_texte_lu));

	    end loop;


	end;

	close(Fichier);
	close (nouveau_Fichier);

    end Decompression_juste;



end huffman;
