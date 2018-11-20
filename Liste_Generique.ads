-- ce module definit une liste chainée qui prends un caractere dynamique

generic
    type T_Type is  private;
package Liste_Generique is
   type T_Cellule is  Private;
   type T_Liste is  private;


    EXCEPTION_LISTE_VIDE :EXCEPTION ;

    -- procedure qui initialise une liste chainé
    procedure Initialiser(liste:out T_Liste) ;
    --procédure qui ajoute un élement à la liste chainé
    procedure Ajouter_Element(liste: in out T_Liste;elemment : in T_Type) ;
    --procedure qui supprime le premiere element de la liste chainée
    procedure Supprimer_premier_Element(liste : in out T_Liste);
    --fonction qui regarde si la liste est vide
    function Est_Vide(liste : in T_Liste) return Boolean;






private
    type T_Cellule is record
        element : T_Type;
        suivant : T_Liste;
        Antecedant : T_Liste;
    end record;

    type T_Liste is access T_Cellule;

end Liste_Generique ;
