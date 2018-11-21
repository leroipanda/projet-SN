generic 
   type T_Element is private;
package arbre is
   type T_Arbre is private;
   type T_Feuille is private;

   --procedure qui initialise un arbre
   procedure initialiser(arbre : out T_Arbre);
   -- procedure qui ajoute un arbre du coté gauche d'une feuille
   procedure Ajouter_Arbre_Gauche( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre);
   -- procedure qui ajoute un arbre du coté droit d'une feuille
   procedure Ajouter_Arbre_Droite( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre);
   --procedure qui verifie la presence d'un cractere dans l'arbre

   function Est_Vide (arbre : in T_Arbre) return Boolean;
    -- procedure qui ajoute une feulle à droite d'une arbre
   procedure Ajouter_Feuille_Droite(Arbre : in T_Arbre ; Element : in T_Element);
   -- procedure qui ajoute une feulle à gauche d'une arbre
   procedure Ajouter_Feuille_Gauche(Arbre : in T_Arbre ; Element : in T_Element);
   -- procedure qui icrement la frequence de la feuille ciblé par le pointeur

   
  
   
   
   private 
   type T_Feuille is record 
      Antecedant : T_Arbre;
      Feuille_Droit : T_Arbre;
      Feuille_Gauche : T_Arbre;
      elem : T_Element ;
   end record;
   
   type T_Arbre is access T_Feuille;

end arbre;
