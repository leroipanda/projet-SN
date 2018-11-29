with Ada.Unchecked_Deallocation;

package body arbre is
procedure Free is
     new Ada.Unchecked_Deallocation (T_Feuille,T_Arbre);
   
   procedure initialiser(arbres :in out T_Arbre; elem :in T_Element) is 
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
   
   function Fusion_Arbre_Ordonne(arbre1 : in out T_Arbre; arbre2: in out  T_Arbre;nv_elem :in T_Element) return T_Arbre is
      
      nouvelle_arbre  : T_Arbre ;
         
   begin
      nouvelle_arbre :=  new T_Feuille'(null,null,null,nv_elem);  
      if comparaison(arbre1.all.elem,arbre2.all.elem) then
         Ajouter_Arbre_Droite(nouvelle_arbre,arbre1);
         Ajouter_Arbre_Gauche(nouvelle_arbre,arbre2);
      else
         Ajouter_Arbre_Droite(nouvelle_arbre,arbre2);
         Ajouter_Arbre_Gauche(nouvelle_arbre,arbre1);
      end if;
      return nouvelle_arbre;
      
   end Fusion_Arbre_Ordonne;
   
   procedure modif_elem(arbres :in out T_Arbre;elem :in T_Element) is
   begin
      arbres.all.elem := elem;
   end modif_elem;
   
   function Renvoie_Element(arbres :in T_Arbre) return T_Element is
   begin
      return arbres.all.elem;
   end Renvoie_Element;
   
     
   
end arbre;
