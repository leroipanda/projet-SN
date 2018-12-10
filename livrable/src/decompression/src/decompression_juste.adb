with  Ada.Text_IO; use  Ada.Text_IO;
with Ada.Sequential_IO ;


procedure Decompression_juste is

   PACKAGE P_integer_file IS NEW Ada.Sequential_IO(integer) ;
   USE P_integer_file ;

   Fichier : P_integer_file.File_type ;
   nouveau_Fichier : Ada.Text_IO.File_Type;
   Taille_table :constant Integer := 257;
   Taille_octet :constant Integer := 8;
   Taille_texte_encode :constant Integer :=4;
    Taille_arbre_encode :constant Integer :=1;
    cara_test :constant character := 'ù';

   nom : String := "test1.txt";
   Type T_Tableau is array(1..Taille_table) of Character ;
   Type T_Table is array(1..Taille_octet) of T_Tableau;
    Table : T_Table;

begin
   --ouverture et lecture du contenus du fichier( in : string nomfichier, out : File_type fichier)
    P_integer_file.open(Fichier,In_File, "test.txt") ;

   --on itialise la table
   for i in 1..Taille_octet loop
        for j in 1..Taille_table loop
            null;
            Table(i)(j) := cara_test;  --caractere non present dans la table ascii
      end  loop;

   end loop;

    --extraction de la table ( in fichier, out tableau de tableau charactere table)

    declare
        function lire_octet(nombre :in integer) return integer is
            valeur :integer:=0;
            valeur_lu : integer;
        begin

            for i in 1..nombre loop
            read(Fichier,valeur_lu);
                valeur := valeur*2 + valeur_lu;
            end loop;
            return valeur;
        end lire_octet;

        nb_caractere : Integer:=0;
        caractere_traduit : Integer:=0;
        taille_texte : integer;
        taille_arbre : integer;
        tableau_cara : T_Tableau;
        valeur : integer:=0;
        valeur_lu :integer;
        memoir :boolean := False;
        taille : integer :=0;


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

        --on lit le parcour de l'arbre
        while caractere_traduit /= taille_arbre loop
            read(Fichier,valeur_lu);
            if valeur = 0 then
                taille :=taille+1;
                if memoir then
                    valeur := valeur*2 + 1;
                    memoir := False;
                else
                    valeur := valeur*2;
                end if;

            else
                taille:= taille-1;
                valeur := valeur / 2;
                if not memoir then
                    --on enregistre dans la la table
                    caractere_traduit := caractere_traduit+1;
                    table(taille)(valeur) := tableau_cara(caractere_traduit);
                    memoir := true;

                end if;

            end if;
            end loop ;


    end;

    --la table est corectement remplis maintenant
    --il reste plus que à decompresse le contenu maitenant
    declare

      valeurHuffman : Integer;
      taille : Integer:=1;
      convertie : Boolean;
      inte_lu :  integer ;


      begin
      --on passe un ligne du fichier

      create(nouveau_Fichier,Out_File,nom) ;

      while not P_integer_file.End_Of_File(Fichier) loop
         convertie := false;
         taille := 1;
         valeurHuffman :=0;
         while not convertie loop
         read(fichier, inte_lu);
         valeurHuffman := valeurHuffman *2   +inte_lu ;

            if Table(taille)(valeurHuffman+1) /=  cara_test  then
              -- Put_Line("---entree---");
               --Put_Line(Character'Image(Table(taille)(valeurHuffman+1)));
               Put(nouveau_Fichier,Table(taille)(valeurHuffman+1));
               convertie := True;
            end if;
         taille := taille+1;

          end loop;



      end loop;


      end;

   close(Fichier);
   close (nouveau_Fichier);

end Decompression_juste;
