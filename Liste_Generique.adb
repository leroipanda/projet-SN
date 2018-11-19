with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Liste_Generique is

    	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule,T_Liste);
    procedure Initialiser(liste : out T_Liste) is
    begin
        liste := Null;
    end Initialiser;

    procedure Ajouter_Element(liste: in out T_Liste,elemment : in T_Type) is
        Nouveau_Element := new T_Liste'(element,Null,liste);
    begin
        liste.all.suivant := Nouveau_Element;
    end Ajouter_Element;

    procedure Supprimer_premier_Elemenent(liste : in out T_Liste) is
        Element_Supprimer : T_Liste := T_Liste
    begin
        if T_Liste = Null then
            raise(EXEPTION_LISTE_VIDE);
        else
                T_Liste := T_Liste.all.suivant;
                Free(Element_Supprimer.all,Element_Supprimer);
        end if;


        end Supprimer_premier_Elemenent;






end Liste_Generique;
