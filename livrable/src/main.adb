with Ada.Text_IO;                 use Ada.Text_IO;
with Liste_Generique;
with arbre;


procedure main is
   
   type T_charactere is record 
      caractere : Character;
      frequence : Integer;
   end record;
   type P_character is access T_charactere;
   
      package arbre_element is new arbre(P_character);
      use arbre_element;  
   package liste_caractere is new Liste_Generique(T_Charactere);   
   use liste_caractere; 
   package liste_texte is new Liste_Generique(Character);   
   use liste_texte;
   
   MonFichier        : File_type ;
   caractere_lu      : Character := 'a'; --initialisation pour que l'algo marche
   caractere_lu_prec : Character;
   colone            : integer ;
   ligne             : integer:= 0;
   nb_caractere      : Integer := 0;
   liste_chara : liste_caractere.T_Liste;
   texte  : liste_texte.T_Liste;
   arbre_elem :arbre_element.T_Arbre;
   
   --fonction qui incremente la frequence d'un caractere si il est present ou l'ajoute si non present 
   procedure increment_frequence(liste : in out liste_caractere.T_Liste; chara : Character)is
      pointeur : liste_caractere.T_Liste := liste ;
      trouve : Boolean := False;
   begin
         while not trouve and not  liste_caractere.Est_Vide(pointeur) loop
            if liste_caractere.Element_Debut(liste).caractere = chara then
               trouve :=  True;
               liste_caractere.modifier_element_debut(pointeur,(liste_caractere.Element_Debut(liste).caractere,liste_caractere.Element_Debut(liste).frequence +1));
            end if;
            pointeur := liste_caractere.Addresse_Suivant(pointeur);
         end loop;
         if not trouve then 
            liste_caractere.Ajouter_Element(liste ,(chara,0));
         end if;
      end increment_frequence;
      
           
            
   
   
   
  
    
begin
   Put_Line("lecture du fichier");
   --ouverture fichier
   Open(MonFichier,in_File,"test_lecture_fichier.txt") ;--bug ici
   liste_caractere.Initialiser(liste_chara);
   liste_texte.Initialiser(texte);
  

     
   
   --lecture du fichier
   loop
      begin
     
     
         --lecture de element d'une ligne
         colone := 0;
         loop  
            caractere_lu_prec := caractere_lu ;
            Get(MonFichier,caractere_lu);
            increment_frequence(liste_chara,caractere_lu);
            --Put(caractere_lu);
            colone := colone+1;
           liste_texte.Ajouter_Element(texte,caractere_lu); --ordre de la liste import peu 
      
            exit when End_Of_Line(MonFichier); --fin de ligne
         end loop;
         --ajout saut de ligne
         liste_texte.Ajouter_Element(texte,'/');
         liste_texte.Ajouter_Element(texte,'n');
         increment_frequence(liste_chara,'/');
         increment_frequence(liste_chara,'n');
         nb_caractere := nb_caractere + colone;
         
   
         Skip_Line(MonFichier,1);
      exception 
         when CONSTRAINT_ERROR => put("ok"); --reserver pour le fichier vide ,modifier type erreur
       
      end;
      exit when End_Of_File(MonFichier);
   end loop;
    
   --on initialise la  liste d'arbre 
   arbre_element.initialiser(arbre_elem);
   
   
   
end main;


