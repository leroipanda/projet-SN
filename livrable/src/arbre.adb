with Ada.Unchecked_Deallocation;

package body arbre is
procedure Free is
     new Ada.Unchecked_Deallocation (T_Feuille,T_Arbre);
   
   procedure initialiser(arbre : out T_Arbre) is 
   begin
      arbre := null;
   end initialiser;
   
   
   
   
   procedure Ajouter_Arbre_Droite( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre) is
   begin
      Arbre_A_Ajouter.all.Antecedant := Arbre_Recoit;
      Arbre_Recoit.all.Feuille_Droit := Arbre_A_Ajouter ;
   end Ajouter_Arbre_Droite ;
   
   procedure Ajouter_Arbre_Gauche ( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre) is
   begin
      Arbre_A_Ajouter.all.Antecedant := Arbre_Recoit;
      Arbre_Recoit.all.Feuille_Gauche := Arbre_A_Ajouter ;
   end Ajouter_Arbre_Gauche;
   
   procedure Ajouter_Feuille_Gauche(Arbre : in T_Arbre ; Element : in Character; frequence :in Integer) is
      nouvelle_branche :T_Arbre;
      nouvelle_feuille : T_Feuille := (Arbre ,null,null,Element,frequence);
   begin
         nouvelle_branche := new T_Feuille'(nouvelle_feuille);
         Arbre.all.Feuille_Gauche := nouvelle_branche;
   end Ajouter_Feuille_Gauche;
   
   procedure Ajouter_Feuille_Droite(Arbre : in T_Arbre ; Element : in Character; frequence :in Integer) is
      nouvelle_branche :T_Arbre;
      nouvelle_feuille : T_Feuille := (Arbre ,null,null,Element,frequence);
   begin
         nouvelle_branche := new T_Feuille'(nouvelle_feuille);
         Arbre.all.Feuille_Droit := nouvelle_branche;
      end Ajouter_Feuille_Droite;
      
      
     
   
   function Element_Arbre (arbre : in T_arbre) return T_Feuille is
   begin
      return arbre.all;
   end Element_Arbre;
   
   
   
   function Est_Vide (Arbre : in T_Arbre) return Boolean is
   begin
      
      return Arbre = null;
   end Est_Vide;
   
   
end arbre;
