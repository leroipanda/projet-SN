with Ada.Text_IO;                 use Ada.Text_IO;
with Liste_Generique;
with arbre;


procedure main is
   
   type T_charactere is record 
      caractere : Character;
      frequence : Integer;
     
   end record;
   
  
   
    
   package liste_caractere is new Liste_Generique(T_Charactere);   
   use liste_caractere; 
   package liste_texte is new Liste_Generique(Character);   
   use liste_texte;
   package arbre_element is new arbre(liste_caractere.T_Liste);
   use arbre_element; 
   package liste_arbre is new Liste_Generique(arbre_element.T_Arbre);
   use liste_arbre;
   
  
     
   
   
   MonFichier        : File_type ;
   caractere_lu      : Character := 'a'; --initialisation pour que l'algo marche
   caractere_lu_prec : Character;
   colone            : integer ;
   ligne             : integer:= 0;
   nb_caractere      : Integer := 0;
   liste_chara : liste_caractere.T_Liste;
   texte  : liste_texte.T_Liste;
   arbre_elem :arbre_element.T_Arbre;
   frequence_arbre : Integer := 0;
   listeArbre : liste_arbre.T_Liste;
  
   --fonction qui incremente la frequence d'un caractere si il est present ou l'ajoute si non present 
   procedure increment_frequence(liste : in out liste_caractere.T_Liste; chara : Character)is
      pointeur : liste_caractere.T_Liste := liste ;
      sortie : Boolean := False;
      
   begin
      if liste_caractere.Est_Vide(pointeur) then 
         
        liste_caractere.Ajouter_Element(liste,(chara ,1));
      else
      while  not sortie  loop 
         
         if liste_caractere.Est_Vide(liste_caractere.Addresse_Suivant(pointeur)) then 
             
            if liste_caractere.Element_Debut(pointeur).caractere = chara then
            sortie :=  True;
            Put_Line("increment");
            liste_caractere.modifier_element_debut(pointeur,(liste_caractere.Element_Debut(pointeur).caractere,liste_caractere.Element_Debut(pointeur).frequence +1));
               
            else
                  liste_caractere.Ajouter_Element(liste,(chara,1));
               sortie := True;
            end if;
            else
               
            if liste_caractere.Element_Debut(pointeur).caractere = chara then
            sortie :=  True;
            Put_Line("increment");
            liste_caractere.modifier_element_debut(pointeur,(liste_caractere.Element_Debut(pointeur).caractere,liste_caractere.Element_Debut(pointeur).frequence +1));
            else
               pointeur := liste_caractere.Addresse_Suivant(pointeur);
         end if;
         end if;
      end loop ;    
      end if;      
      end increment_frequence;
      
   function comparaison_Elem(elem1 : in T_charactere ;elem2 :in T_charactere) return Boolean is
   begin
      
      if  elem1.frequence > elem2.frequence then
      
         return True;
      else
         return false;
      end if;
   end comparaison_Elem;
   
   --procedure de trie pour la liste de charactere         
   procedure trie_liste is new liste_caractere.tri(comparaison_Elem); 
   
   --procedure qui remplit la liste d'arbre
   procedure remplire_liste_arbre(Larbre :in out  liste_arbre.T_Liste ; Lcara :in liste_caractere.T_Liste) is
      nv_arbre : arbre_element.T_Arbre;
      pointeur : liste_caractere.T_Liste := Lcara;
   begin
      while Est_Vide(pointeur) loop
         arbre_element.initialiser(nv_arbre,pointeur);
         liste_arbre.Ajouter_Element(Larbre,nv_arbre);
         pointeur := liste_caractere.Addresse_Suivant(pointeur);
      end loop;
   end remplire_liste_arbre;
   
   procedure Construire_Huffman(Larbre : in out liste_arbre.T_Liste ;Lchara : in out liste_caractere.T_Liste) is
      function revoie_Telm(liste : in liste_caractere.T_Liste)return T_charactere is
         begin
         return liste_caractere.Renvoie_Element(liste);
      end revoie_Telm; 
      
      function comparaison_pointeur_elem( poiteur_liste1 : liste_caractere.T_Liste;poiteur_liste2: liste_caractere.T_Liste) return Boolean is
      begin
         return comparaison_Elem( revoie_Telm(poiteur_liste1),revoie_Telm(poiteur_liste2));
         end comparaison_pointeur_elem;
       
   

        
                          
       --fonction qui trie un arbre pas instancie de facon generique probleme avec les types privés                   
      function Valeur_pointeur_elem is new liste_caractere.Valeur(T_charactere,revoie_Telm);
         function fusion_arbre is new arbre_element.Fusion_Arbre_Ordonne(comparaison_pointeur_elem);
         
         procedure tri_elem_liste_arbre( Larbre :  in out liste_arbre.T_Liste) is
         
         
      begin
         --on trie le premier element de la liste
         
         while not liste_arbre.Est_Vide(liste_arbre.Addresse_Suivant(Larbre)) loop
         while not -- la comparaisoon  loop
           --on echange place tanque le nouvelle element est pas à sa place 
               liste_arbre.echange_position_premier(Larbre);
               pointeur := liste_arbre.Addresse_Suivant(Larbre);

            end loop;
         end loop;
         end tri_elem_liste_arbre;
         
          
         
     -- procedure tri_arbre is new liste_arbre.tri(comparaison_liste_arbre);
      
      arbre_resultant : arbre_element.T_Arbre;
      nv_charactere : T_charactere:=('"',0);
      test : arbre_element.T_Arbre;
      test2 : arbre_element.T_Arbre;
      
      
   begin
      --calcule de la nouvelle fréquence
      nv_charactere.frequence := liste_caractere.Renvoie_Element(arbre_element.Renvoie_Element(liste_arbre.Renvoie_Element(Larbre))).frequence +liste_caractere.Renvoie_Element(arbre_element.Renvoie_Element(liste_arbre.Renvoie_Element(liste_arbre.Addresse_Suivant(Larbre)))).frequence;
      --créaton de l'arbre fusionn
      test := liste_arbre.Renvoie_Element(Larbre);
      test2 := liste_arbre.Renvoie_Element(liste_arbre.Addresse_Suivant(Larbre));
      liste_caractere.Ajouter_Element(Lchara,nv_charactere);
      arbre_resultant := fusion_arbre(test,test2,Lchara);
      liste_arbre.Supprimer_Cellule(Larbre);
      liste_arbre.Supprimer_Cellule(Larbre);
      liste_arbre.Ajouter_Element(Larbre,arbre_resultant);
      tri_elem_liste_arbre( Larbre );
   
      
      
         
   end Construire_Huffman;
   
        
  
begin
   Put_Line("lecture du fichier");
   --ouverture fichier
   Open(MonFichier,in_File,"test_lecture_fichier.txt") ;--bug ici
   liste_caractere.Initialiser(liste_chara);
   liste_texte.Initialiser(texte);
   --on initialise la  liste d'arbre
   liste_arbre.initialiser(listeArbre);
   Put_Line("cst liste");
  

     
   
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
         
   
         if not End_Of_File(MonFichier) then
            Skip_Line(MonFichier,1);
            end if;
      exception 
         when CONSTRAINT_ERROR => put("ok"); --reserver pour le fichier vide ,modifier type erreur
       
      end;
      exit when End_Of_File(MonFichier);
   end loop;

   --on trie la liste en fonction des fréquences
   Put_Line("tri");
   trie_liste(liste_chara);
   remplire_liste_arbre(listeArbre , liste_chara);
    

  
end main;


