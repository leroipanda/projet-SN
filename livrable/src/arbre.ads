
package arbre is
   type T_Arbre is private;
   type T_Feuille is private;


   procedure initialiser(arbre : out T_Arbre);
   procedure Ajouter_Gauche( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre);
   procedure Ajouter_Droite( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre);
   function Element_Arbre (arbre : in T_arbre) return T_Feuille;
   function Est_Vide (arbre : in T_Arbre) return Boolean;
   
   
   
   
   
   
   private 
   type T_Feuille is record 
      Antecedant : T_Arbre;
      Feuille_Droit : T_Arbre;
      Feuille_Gauche : T_Arbre;
      caractere : Character;
      frequence : Integer;
   end record;
   
   type T_Arbre is access T_Feuille;

end arbre;
