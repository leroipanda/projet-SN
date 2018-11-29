generic 
   type T_Element is private ;
package arbre is
   type T_Arbre is private;
   type T_Feuille is private;

   --procedure qui initialise un arbre
   procedure initialiser(arbres : in out T_Arbre;elem :in T_Element);
   -- procedure qui ajoute un arbre du coté gauche d'une feuille
   procedure Ajouter_Arbre_Gauche( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre);
   -- procedure qui ajoute un arbre du coté droit d'une feuille
   procedure Ajouter_Arbre_Droite( Arbre_Recoit : in T_Arbre ; Arbre_A_Ajouter : in T_Arbre);
   --procedure qui verifie la presence d'un cractere dans l'arbre

   function Est_Vide (arbres : in T_Arbre) return Boolean;
    -- procedure qui ajoute une feulle à droite d'une arbre
   procedure Ajouter_Feuille_Droite(Arbres : in T_Arbre ; Element : in T_Element);
   -- procedure qui ajoute une feulle à gauche d'une arbre
   procedure Ajouter_Feuille_Gauche(Arbres : in T_Arbre ; Element : in T_Element);
   -- procedure qui insere de facon ordonne dans un arbre
   generic
      with function comparaison(elem1 : T_Element; elem2 : T_Element )return Boolean;
   function Fusion_Arbre_Ordonne(arbre1 : in out T_Arbre; arbre2: in out  T_Arbre;nv_elem :in T_Element) return T_Arbre;
   --proceduree qui modifie un element
   procedure modif_elem(arbres :in out T_Arbre;elem :in T_Element);
   --fonction qui renvoie l'element d'un arbre
   function Renvoie_Element(arbres :in T_Arbre) return T_Element;
   
        

   
  
   
   
   private 
   type T_Feuille is record 
      Antecedant : T_Arbre;
      Feuille_Droit : T_Arbre;
      Feuille_Gauche : T_Arbre;
      elem : T_Element ;
   end record;
   
   type T_Arbre is access T_Feuille;

end arbre;
