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

   procedure Ajouter_Element(liste: in out T_Liste;elemment : in T_Type) is
        nouvelle_cellule : T_Cellule := (elemment,null,liste);
        P_cellule : T_Liste;
   begin

       P_cellule.all := nouvelle_cellule;
        liste.all.suivant := P_cellule;
    end Ajouter_Element;

    procedure Supprimer_premier_Element(liste : in out T_Liste) is
        Element_Supprimer : T_Liste := liste;
    begin
        if liste = Null then
            raise EXCEPTION_LISTE_VIDE;
        else
                liste := liste.all.suivant;
                Free(Element_Supprimer);
        end if;


        end Supprimer_premier_Element;


        function Est_Vide(liste : in T_Liste) return Boolean is
        begin
            return liste = Null;
        end Est_Vide;







end Liste_Generique;
