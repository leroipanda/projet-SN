with  Ada.Text_IO; use  Ada.Text_IO;

PACKAGE P_integer_file IS NEW Ada.Direct_IO(Integer) ;
use P_integer_file;

procedure Decompression is
   Fichier : File_type ;
   nouveau_Fichier : File_Type;
   Taille_table :constant Integer := 257;
   Taille_octet :constant Integer := 8;
   nom : String := "test1.txt";
   Type T_Tableau is array(1..Taille_table) of Character ;
   Type T_Table is array(1..Taille_octet) of T_Tableau;
   Table : T_Table;




begin
   --ouverture et lecture du contenus du fichier( in : string nomfichier, out : File_type fichier)
   open(Fichier,In_File, "test.txt") ;
   --on itialise la table
   for i in 1..Taille_octet loop
      for j in 1..Taille_table loop
         Table(i)(j) := '�'; --caractere non present dans la table ascii
      end  loop;

   end loop;

   --extraction de la table
   declare
      nb_cara := Integer :=0 ; -- � modifier
      valeur : integer :=0;
      memoir : Boolean := False;
      compteur_caractere : Integer :=0;
      bit_lu : Integer;


   begin
--manque gestion de la profondeur et enregistrement dans la table
      while compteur_caractere /= nb_cara loop
         P_integer_file.read(Fichier,bit_lu,count(i));
         if bit_lu =0 then
            if memoir then
             valeur = valeur * 2+1;
            else
              valeur = valeur * 2;
            end if;

         else
            if (valeur mod 2) =0 then
--on enregistre la valeur dans le tableau
               memoir := True;
               valeur :=valeur/2
            else
               memoir := False;
               valeur :=valeur/2
            end if;

         end if;




            end loop;
   end

   --extraction du tableau ( in fichier, out tableau de tableau charactere table)
   declare
      OctetCaractere : Integer;
      OctetLongeur : Integer;
      OctetCode : Integer;
      function Lire_octtet_suivant(fichier : in out File_Type) return Integer is
      Octet_Lu : integer:=0;
      cara_lu :  Character ;

   begin
      for i in 1..Taille_octet loop
            Get(fichier, cara_lu);
            -- Put_Line(Character'Image(cara_lu));
            --Put_Line( Integer'Image(Character'Pos(cara_lu)));
         Octet_Lu := Octet_Lu + 2**(8-i) *( Character'Pos(cara_lu) - 48); -- o vaut 48 lors de la conversion
      end loop;
      return Octet_Lu;

      end Lire_octtet_suivant;

   begin
   while not End_Of_Line(Fichier) loop
      OctetCaractere := Lire_octtet_suivant(Fichier );
      OctetLongeur := Lire_octtet_suivant(Fichier );
      OctetCode := Lire_octtet_suivant(Fichier );
        -- Put_Line(Integer'Image(OctetLongeur));
        -- Put_Line(Integer'Image(OctetCode));
        --Put_Line(Integer'Image(OctetCaractere));
        --Put_Line(Character'Image( Character'Val(OctetCaractere)));
      Table(OctetLongeur)(OctetCode+1) := Character'Val(OctetCaractere);--+1 probleme avec les tableau en 0


   end loop;

   end;

   --extraction du contenus du fichier compresser dans un nouveau fichier.txt (in fichier,table  ,out  File_type nouveau_fichier)
   declare

      valeurHuffman : Integer;
      taille : Integer:=1;
      convertie : Boolean;
      cara_lu :  Character ;


      begin
      --on passe un ligne du fichier
      Skip_Line(Fichier);
      create(nouveau_Fichier,Out_File,nom) ;

      while not End_Of_Line(Fichier) loop
         convertie := false;
         taille := 1;
         valeurHuffman :=0;
         while not convertie loop
         Get(fichier, cara_lu);
         valeurHuffman := valeurHuffman *2   +(Character'Pos(cara_lu)-48) ;-- o vaut 48 lors de la conversion
         --Put_Line(Integer'Image(valeurHuffman));

            if Table(taille)(valeurHuffman+1) /=  '�'  then
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

end Decompression;
