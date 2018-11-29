-- ce module definit une liste chainée qui prends un caractere dynamique

generic
   type T_Type is  private;
   --fonction qui revera si un element est plus grand q'un autre

package Liste_Generique is
   type T_Cellule is  Private;
   type T_Liste is  private;


    EXCEPTION_LISTE_VIDE :EXCEPTION ;

    -- procedure qui initialise une liste chainé
    procedure Initialiser(liste:out T_Liste) ;
    --procédure qui ajoute un element au somment de la liste chain�
    procedure Ajouter_Element(liste: in out T_Liste;elemment : in T_Type) ;
    --procedure qui supprime le premiere element de la liste chainée
    procedure Supprimer_premier_Element(liste : in out T_Liste);
    --fonction qui regarde si la liste est vide
   function Est_Vide(liste : in T_Liste) return Boolean;
   --fonction qui renvoie le premier element de la liste
   function Element_Debut(liste : in T_Liste) return T_Type;
   --fonction qui indique si un element est present
   function Est_Present (liste : in T_Liste; element :in T_Type) return Boolean;
   --procedure qui modifie le premier element d'une liste
   procedure modifier_element_debut(liste : in T_Liste; element :in T_Type);
   --fonction qui renvoie l'element suivant d'une liste
   function Addresse_Suivant(liste : in T_Liste) return T_Liste;
   --fonction qui revoie le t_type en entr�e
   function Renvoie_Element(liste: in T_Liste) return T_Type;
   --procedure qui supprime un la cellule cible
   procedure Supprimer_Cellule(liste: in out T_Liste);



   generic
      --fonction qui revera si un element est plus grand q'un autre
      with function comparaison(elem1 : T_Type; elem2 : T_Type )return Boolean;
      --procedure qui trie la liste
   procedure tri(liste : in out T_Liste) ;

   generic
      --fonctiion qui revoie un valeur de l'element
      type T_Retour is private;
      with function Renvoie_Valeur(elem :in T_Liste) return T_Retour;
      function Valeur(elem : in T_Liste) return T_Retour;





private
    type T_Cellule is record
        element : T_Type;
        suivant : T_Liste;
        Antecedant : T_Liste;
    end record;

    type T_Liste is access T_Cellule;

end Liste_Generique ;
