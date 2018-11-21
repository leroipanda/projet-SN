with Ada.Unchecked_Deallocation;

package body arbre is
procedure Free is
     new Ada.Unchecked_Deallocation (T_Feuille,T_Arbre);
   
   procedure initialiser(arbre : out T_Arbre) is 
   begin
      arbre := null;
   end initialiser;
   
   
   procedure Ajouter_Droite( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre) is
   begin
      Arbre_A_Ajouter.all.Antecedant := Arbre_Recoit;
      Arbre_Recoit.all.Feuille_Droit := Arbre_A_Ajouter ;
   end Ajouter_Droite ;
   
   procedure Ajouter_Gauche ( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre) is
   begin
      Arbre_A_Ajouter.all.Antecedant := Arbre_Recoit;
      Arbre_Recoit.all.Feuille_Gauche := Arbre_A_Ajouter ;
   end Ajouter_Gauche ;
   
   function Element_Arbre (arbre : in T_arbre) return T_Feuille is
   begin
      return arbre.all;
   end Element_Arbre;
   
   function Est_Vide (arbre : in T_Arbre) return Boolean is
      return arbre = null;
   end Est_Vide;
   
   
end arbre;
