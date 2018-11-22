with Ada.Unchecked_Deallocation;

package body arbre is
procedure Free is
     new Ada.Unchecked_Deallocation (T_Feuille,T_Arbre);
   
   procedure initialiser(arbres :in out T_Arbre;elem :in T_Element) is 
   begin
      arbres.all := (null,null,null,elem);
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
   
   procedure Ajouter_Feuille_Gauche(Arbres : in T_Arbre ; Element : in T_Element) is
      nouvelle_branche :T_Arbre;
      nouvelle_feuille : T_Feuille := (Arbres ,null,null,Element);
   begin
         nouvelle_branche := new T_Feuille'(nouvelle_feuille);
         Arbres.all.Feuille_Gauche := nouvelle_branche;
   end Ajouter_Feuille_Gauche;
   
   procedure Ajouter_Feuille_Droite(Arbres : in T_Arbre ; Element :in T_Element) is
      nouvelle_branche :T_Arbre;
      nouvelle_feuille : T_Feuille := (Arbres ,null,null,Element);
   begin
         nouvelle_branche := new T_Feuille'(nouvelle_feuille);
         Arbres.all.Feuille_Droit := nouvelle_branche;
      end Ajouter_Feuille_Droite;
    

   
   function Est_Vide (Arbres : in T_Arbre) return Boolean is
   begin
      
      return Arbres = null;
   end Est_Vide;
   
   procedure Insersion_Arbre_Ordonne(Arbres : in out T_Arbre; elem : T_Element;nv_elem: T_Element) is
      
      nouvelle_branche  : T_Arbre ;
      branche_element : T_Arbre;
      
   begin
      nouvelle_branche :=  new T_Feuille'(null,null,null,nv_elem);
      branche_element := new T_Feuille'(nouvelle_branche,null,null,elem);  
      if comparaison(Arbres.elem ,elem) then
         nouvelle_branche.all.Feuille_Droit := arbres;
         arbres.all.antecedant := branche_element;
         nouvelle_branche.all.Feuille_Gauche := branche_element;
      else
         nouvelle_branche.all.Feuille_Gauche := arbres;
         arbres.all.antecedant := branche_element;
         nouvelle_branche.all.Feuille_Droit := branche_element;
      end if;
      arbres := nouvelle_branche ;
      
   end insersion_arbre_ordonne;
   
   procedure modif_elem(arbres :in out T_Arbre;elem :in T_Element) is
   begin
      arbres.all.elem := elem;
   end modif_elem;
   
     
   
end arbre;
