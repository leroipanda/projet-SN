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
        nouvelle_cellule : T_Cellule := (elemment,liste,null);
        P_cellule : T_Liste;
   begin
      P_cellule := new T_Cellule'(nouvelle_cellule);
      --cas liste est null pose probleme on differencie
      if liste = null then
         liste := P_cellule;

      else
         liste.all.Antecedant := P_cellule;
         liste := P_cellule;
      end if;



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

   function Element_Debut(liste : in T_Liste) return T_Type is
   begin
      if liste = null then
         raise EXCEPTION_LISTE_VIDE;
      else
         return liste.all.element;
      end if;

   end Element_Debut;

   function Est_Present (liste : in T_Liste; element :in T_Type) return Boolean
   is
      trouve : Boolean := True;
      P_liste : T_Liste := liste;
   begin
      while  not trouve and P_liste /= null loop
         if Liste.element = element then
            trouve := True;
         end if;
         P_liste := P_liste.all.suivant;
      end loop;
      return trouve;
   end Est_Present;

   procedure modifier_element_debut(liste : in T_Liste; element :in T_Type) is
   begin
      liste.all.element := element;
   end modifier_element_debut;

   function Addresse_Suivant(liste : in T_Liste) return T_Liste is
   begin
      if liste = null then
         raise EXCEPTION_LISTE_VIDE;
      else
         return liste.suivant;
      end if;
   end Addresse_Suivant;















end Liste_Generique;
